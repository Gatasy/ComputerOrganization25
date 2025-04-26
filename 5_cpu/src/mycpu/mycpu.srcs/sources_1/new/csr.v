`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 简化版 csr.v：保留原有异常逻辑，新增两路线中断（SWIO=0, Timer=11），并用 ESTAT_IS[1:0] 记录
//////////////////////////////////////////////////////////////////////////////////
module csr(
    input  wire        clk,             // 时钟
    input  wire        rst_n,           // 低有效复位
    input  wire        exception,       // 来自 decode 的同步异常
    input  wire        interrupt,       // 来自 decode 的线中断请求
    input  wire [7:0]  index,           // [3:0]=异常号, [7:4]=中断号 (0=SWIO,11=Timer)
    input  wire [31:0] pc,              // 触发异常/中断时的 PC

    output wire [32:0] j_exception_addr // {1’b1, 32 位跳转地址}
);

  // ------------------------------------------------------------------------
  // 1. CSR 内部寄存器
  // ------------------------------------------------------------------------
  reg [31:0] ERA;        // 返回地址 (EPC)
  reg [31:0] EENTRY;     // 异常/中断入口基址（LoongArch 简化版默认为 0x0）
  reg [1:0]  ESTAT_IS;   // 低两位：bit0=SWIO (int#0), bit1=Timer (int#11)

  // ------------------------------------------------------------------------
  // 2. 通用例外入口计算 (VS=0)
  // ------------------------------------------------------------------------
  wire        is_ertn = exception && (index[3:0] == 4'b1000);
  // ecode = 异常 ? exc_code : 中断 ? (64 + int_number) : 0
  wire [6:0]  ecode = is_ertn    ? 7'd0
                     : exception  ? index[3:0]
                     : interrupt  ? (7'd64 + index[7:4])
                     : 7'd0;
  wire [31:0] offset = ecode << 2;  // *4

  assign j_exception_addr =
           is_ertn                         ? {1'b1, ERA}                      // ERTN 返回
         : (exception || interrupt)        ? {1'b1, EENTRY + offset}          // 异常/中断入口
         : 33'b0;

  // ------------------------------------------------------------------------
  // 3. 同步逻辑：更新 ERA、EENTRY、ESTAT_IS
  // ------------------------------------------------------------------------
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ERA        <= 32'b0;
      EENTRY     <= 32'b0;   // 基址默认为 0x0
      ESTAT_IS   <= 2'b00;   // 清除 SWIO/Timer标志
    end
    else if (is_ertn) begin
      // ERTN：清除所有软件中断标志
      ESTAT_IS   <= 2'b00;
    end
    else if (exception) begin
      // 同步异常：保存下一条指令地址
      ERA        <= pc + 4;
      // EENTRY 保持 0x0
    end
    else if (interrupt) begin
      // 线中断：保存返回地址，并置 ESTAT_IS 中相应位
      ERA        <= pc + 4;
      // SWIO (int_number=0) → ESTAT_IS[0], Timer (int_number=11) → ESTAT_IS[1]
      ESTAT_IS[0] <= (index[7:4] == 4'd0);
      ESTAT_IS[1] <= (index[7:4] == 4'd11);
    end
    else begin
      // 无事件，保持不变
      ERA        <= ERA;
      EENTRY     <= EENTRY;
      ESTAT_IS   <= ESTAT_IS;
    end
  end

endmodule

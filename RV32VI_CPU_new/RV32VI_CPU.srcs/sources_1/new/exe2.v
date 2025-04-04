`timescale 1ns / 1ps
module exe (
    input EXE_valid,
    input  wire        clk,
    input  wire        rst,
    input wire [2:0] state,
    input  wire [148:0] ID_EXE_bus,   // 来自 ID/译码阶段的总线
    output reg  [65:0] EX_MEM_bus,   // 传递到 MEM/访存阶段的总线
    output reg  [70:0] EX_WB_bus,    //传递到WB回写单元的总线
    output reg  [31:0]  alu_result,
    output  EXE_ready,
    output reg [31:0] EXE_pc
);

localparam EXE = 3'b011;
assign EXE_ready = (state == EXE) & EXE_valid;  // ID模块准备就绪

// 从 ID_EXE_bus 解析信号
wire [3:0]  alu_control  = ID_EXE_bus[148:145]; // ALU 控制信号
wire [31:0] alu_operand1 = ID_EXE_bus[144:113];
wire [31:0] alu_operand2 = ID_EXE_bus[112:81];
wire [31:0] rs2_value    = ID_EXE_bus[80:49];
wire [4:0]  rd           = ID_EXE_bus[48:44];
wire [2:0]  state_       = ID_EXE_bus[43:41];
wire        inst_load    = ID_EXE_bus[40];
wire        inst_store   = ID_EXE_bus[39];
wire        branch       = ID_EXE_bus[38];
wire        inst_shf_sa  = ID_EXE_bus[37];
wire [4:0]  sa           = ID_EXE_bus[36:32];
wire [31:0] pc           = ID_EXE_bus[31:0]; // 当前 PC 值


// 新的 pc（如果是跳转指令，计算新的 pc）
reg [31:0] new_pc;
always @(*) begin
    if (branch) begin
        // 如果是跳转指令，计算新的 PC（例如，JAL, BEQ）
        // 假设使用 `pc + imm` 来计算新 pc（你可以根据指令类型调整计算方式）
        // 对于 BEQ、JALR 等，我们会根据具体条件计算新的 pc
        new_pc = alu_operand1 + alu_operand2;  // 例如，对于跳转指令计算新的 pc
    end else begin
        // 否则，默认 pc = pc + 4
        new_pc = pc + 4;
    end
end

// 根据不同指令执行 ALU 运算
always @(*) begin
    case (alu_control) 
        4'b0000: alu_result = alu_operand1 + alu_operand2;
        4'b0001: alu_result = alu_operand1 - alu_operand2;
        4'b0111: alu_result = alu_operand1 & alu_operand2;
        4'b0010: alu_result = alu_operand1 | alu_operand2;
        4'b0011: alu_result = alu_operand1 ^ alu_operand2;
        4'b0100: alu_result = alu_operand1 << alu_operand2[4:0];
        4'b0101: alu_result = alu_operand1 >> alu_operand2[4:0];
        4'b0110: alu_result = $signed(alu_operand1) >>> alu_operand2[4:0];
        4'b1000: alu_result = ($signed(alu_operand1) < $signed(alu_operand2)) ? 32'd1 : 32'd0;
        4'b1001: alu_result = (alu_operand1 < alu_operand2) ? 32'd1 : 32'd0;
        default: alu_result = 32'd0;
    endcase
end

// store只需要传给访存单元alu_result和rs2 load只需要传给访存单元alu_result
// I计算\load只需要传给回写alu_result和rd，跳转只需要传给回写pc和rd，store不用传给回写单元
// 生成 EX_MEM_bus 传递到 MEM 阶段
always @(posedge clk) begin
    if (rst) begin
        EX_MEM_bus <= 66'd0;
        EX_WB_bus  <= 71'd0;
    end else begin
        EX_MEM_bus <= {alu_result, rs2_value, inst_load, inst_store};  // 32 + 32 + 1 + 1
        EX_WB_bus  <= {alu_result, rd, inst_load, branch, new_pc};  // 32 + 5 + 1 + 1 + 32
    end
end
    // 修复后的时序逻辑

always @(posedge clk or posedge rst) begin
    if (rst) 
        EXE_pc <= 32'b0;      // 复位时清零
    else if (EXE_valid) 
        EXE_pc <= new_pc;     // 仅在 EXE_valid 时更新
end

endmodule
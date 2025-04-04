module ifetch(
    input wire IF_valid,
    input wire clk,
    input wire rst,
    input wire [2:0] state,
    input wire [2:0] reset_delay_cnt,   // 新增：来自Timer模块的复位延迟计数器
    
    // 来自PC的指令地址
    input wire [31:0] pc_addr,
    // 指令存储器IP核接口
    input wire [31:0] inst_data,        // 从存储器读取的指令(douta)
    output reg inst_mem_en,             // 存储器使能(ena)
    output wire inst_mem_we,            // 写使能(wea, 固定为0)
    output wire [14:0] inst_mem_addr,   // 字节地址(addra)
    
    // IF/ID流水线总线输出 (64位: {pc, inst})
    output reg [63:0] IF_ID_bus,
    output wire IF_ready                // 取指就绪信号
);

    // --- 参数定义 ---
    localparam IDLE  = 3'b000;
    localparam FETCH = 3'b001; 
    parameter RESET_DELAY = 3;          // 与Timer模块的复位延迟周期一致

    // --- 地址对齐逻辑 ---
    wire [31:0] aligned_pc = {pc_addr[31:2], 2'b00};  // PC按字对齐
    assign inst_mem_addr = aligned_pc[14:2];          // 1KB指令空间（适配Block RAM地址位宽）

    // --- 写使能固定为0（只读） ---
    assign inst_mem_we = 1'b0; 

    // --- IF_ready信号生成（新增复位延迟判断） ---
    assign IF_ready = (state == FETCH) && (reset_delay_cnt >= RESET_DELAY) && IF_valid;

    // --- 存储器使能逻辑（同步复位延迟） ---
    always @(*) begin
        // 仅在FETCH状态且复位延迟结束后使能存储器
        inst_mem_en = (state == FETCH) && (reset_delay_cnt >= RESET_DELAY) && !rst;
    end

    // --- IF/ID流水线总线更新（复位期间强制输出NOP） ---
    always @(posedge clk) begin
        if (rst || (reset_delay_cnt < RESET_DELAY)) begin
            // 复位或延迟期间输出NOP指令（PC地址保持当前值）
            IF_ID_bus <= {aligned_pc, 32'h00000013};  // RISC-V NOP: addi x0, x0, 0
        end else begin
            case(state)
                FETCH: IF_ID_bus <= {aligned_pc, inst_data};  // 正常取指
                default: IF_ID_bus <= IF_ID_bus;             // 保持当前值
            endcase
        end
    end

endmodule
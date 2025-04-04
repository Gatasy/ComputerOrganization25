module wb(
    // I型计算，跳转，Load,Store,
    input WB_valid,
    input wire clk,
    input wire rst,
    input wire [2:0] state,
    input wire [70:0] EX_WB_bus,
    input wire [31:0] lsu_data,
    output reg reg_wen,    // 回写的使能信号
    output reg [4:0] wb_addr,
    output reg [31:0] wb_data,
    output wire WB_ready
);
 
    localparam WB = 3'b101;
    assign WB_ready = (state == WB) & WB_valid;
    
    // 从EXE_WB_bus解析
    // EX_WB_bus<={alu_result,rd,inst_load,branch,pc}; // 32 5 1 1 32
        
    wire [31:0] alu_result = EX_WB_bus[70:39];
    wire [4:0]  rd         = EX_WB_bus[38:34];
    wire        inst_load  = EX_WB_bus[33];
    wire        branch     = EX_WB_bus[32];
    wire [31:0] pc         = EX_WB_bus[31:0];
    
    always @(*) begin
        // 默认值
        reg_wen = 1'b0;
        wb_addr = 5'b0;
        wb_data = 32'b0;
        
        if (WB_valid && state == 3'b100) begin
            if (branch) begin
                // 跳转指令：写回PC值到目标寄存器
                reg_wen = 1'b1;
                wb_addr = rd;
                wb_data = pc;
            end
            else if (inst_load) begin
                // Load指令：写回从LSU读取的数据
                reg_wen = 1'b1;
                wb_addr = rd;
                wb_data = lsu_data;
            end
            else if (rd != 5'b0) begin
                // 其他需要写回的指令（非x0寄存器）：写回ALU计算结果
                reg_wen = 1'b1;
                wb_addr = rd;
                wb_data = alu_result;
            end
            // Store指令不需要写回寄存器
        end
    end
    
endmodule
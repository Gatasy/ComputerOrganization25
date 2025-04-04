`timescale 1ns / 1ps

module MEM_stage (
    input         clk,             // 时钟
    input         reset,           // 复位
    input wire[2:0]   state,
    input         MEM_valid,       // 存储器访问有效信号
    input  [65:0] EX_MEM_bus,      // 66 位总线数据
    output reg [31:0] read_data,       // 从存储器读取的数据（给 `lw` 用）
    output        MEM_ready,       // 存储操作完成信号
    // BRAM 控制接口
    output        mem_en,          // 存储器使能
    output [3:0]  mem_wea,         // 写使能
    output [31:0] mem_addr,        // 存储器地址
    output [31:0] mem_write_data   // 存储器写入数据（给 `sw` 用）
);

    parameter MEM    = 3'b100;

    // --- 解析 `EX_MEM_bus` ---
    wire [31:0] alu_result = EX_MEM_bus[65:34];   // 计算出的地址
    wire [31:0] rs2_value  = EX_MEM_bus[33:2];  // `sw` 需要写入的数据
    wire        inst_load  = EX_MEM_bus[1];     // `lw` 指令标志
    wire        inst_store = EX_MEM_bus[0];     // `sw` 指令标志

    
    // --- 生成存储器访问信号 ---
    assign mem_en    = (inst_load || inst_store) && MEM_valid; // 仅 `lw` / `sw` 时使能存储器
    assign mem_addr  = {alu_result[31:2], 2'b00}; // 强制字对齐
    assign mem_write_data = rs2_value;           // `sw` 需要存储的数据

    // --- `sw` 使能逻辑 ---
    assign mem_wea = (inst_store && MEM_valid) ? 4'b1111 : 4'b0000; // `sw` 时写 4 字节

    // --- `lw` 直接读取数据 ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            read_data <= 32'b0;
        end else if (state == MEM && MEM_valid) begin
            if(inst_load )
            read_data <= read_data;  
            else 
                read_data <= alu_result;
        end
    end

    // --- 存储器操作完成信号 ---`
    assign MEM_ready = (state == MEM) && MEM_valid;

endmodule
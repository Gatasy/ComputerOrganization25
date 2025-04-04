`timescale 1ns / 1ps

module CPU_Top_tb;
    // 输入信号
    reg clk;
    reg rst;
    
    // 输出信号
    wire [31:0] pc_if;
    wire [31:0] pc_id;
    wire [31:0] pc_ex;
    wire [31:0] pc_mem;
    wire [31:0] pc_wb;
    wire [31:0] IF_inst;
    wire [31:0] rf_data;
    wire [31:0] test_mem_data;
    wire [2:0] display_state;
    
    reg [4:0] rf_addr;
    reg [31:0] test_mem_addr;
    
    // 实例化 CPU_Top 模块
    CPU_Top cpu (
        .clk(clk),
        .rst(rst),
        .pc_if(pc_if),
        .pc_id(pc_id),
        .pc_ex(pc_ex),
        .pc_mem(pc_mem),
        .pc_wb(pc_wb),
        .IF_inst(IF_inst),
        .rf_addr(rf_addr),
        .test_mem_addr(test_mem_addr),
        .rf_data(rf_data),
        .test_mem_data(test_mem_data),
        .display_state(display_state)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // 复位信号产生
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end
    
    // 仿真运行时间控制
    initial begin
        #1000;
        $stop;
    end
    
    // 监视信号
    initial begin
        $monitor("Time=%0t | rst=%b | pc_if=%h | pc_id=%h | pc_ex=%h | pc_mem=%h | pc_wb=%h | IF_inst=%h | rf_data=%h | mem_data=%h | state=%b", 
                 $time, rst, pc_if, pc_id, pc_ex, pc_mem, pc_wb, IF_inst, rf_data, test_mem_data, display_state);
    end
    
    // 波形文件生成
    initial begin
        $dumpfile("cpu_top_waveform.vcd");
        $dumpvars(0, CPU_Top_tb);
    end
    
    // 地址与数据仿真控制
    initial begin
        rf_addr = 'b00000;
        test_mem_addr = 32'b0;
        
        #50 rf_addr = 5'b00001;
        #100 rf_addr = 5'b00010;
        #150 test_mem_addr = 32'h00001000;
        #200 test_mem_addr = 32'h00002000;
    end
    
endmodule

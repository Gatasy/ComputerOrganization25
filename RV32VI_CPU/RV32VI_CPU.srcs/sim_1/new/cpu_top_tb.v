`timescale 1ns / 1ps

module CPU_Top_tb;

    // 输入信号
    reg clk;
    reg rst;
    
    // 输出信号（观察端口）
    wire [31:0] pc_if;
    wire [31:0] pc_id;
    wire [31:0] pc_ex;
    wire [31:0] pc_mem;
    wire [31:0] pc_wb;
    wire [31:0] IF_inst;
    
    // 实例化 CPU_Top 模块
    CPU_Top uut (
        .clk(clk),
        .rst(rst),
        .pc_if(pc_if),
        .pc_id(pc_id),
        .pc_ex(pc_ex),
        .pc_mem(pc_mem),
        .pc_wb(pc_wb),
        .IF_inst(IF_inst)
    );
    
    // 时钟生成：10ns 周期
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // 复位信号产生及释放
    initial begin
        rst = 1;           // 上电复位
        #20;               // 保持复位 20ns
        rst = 0;           // 释放复位，开始正常运行
    end
    
    // 仿真运行时间控制
    initial begin
        // 根据实际仿真需要，设置运行时间
        #800;              // 运行 500ns 后停止仿真
        $stop;
    end
    
    // 输出监视：打印关键信号值，方便观察仿真波形
    initial begin
        $monitor("Time=%0t | rst=%b | pc_if=%h | pc_id=%h | pc_ex=%h | pc_mem=%h | pc_wb=%h | IF_inst=%h",
                  $time, rst, pc_if, pc_id, pc_ex, pc_mem, pc_wb, IF_inst);
    end

endmodule

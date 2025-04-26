`timescale 1ns / 1ps

module tb_cpuCore;

    // Inputs
    reg clk;
    reg rstn;
    reg i_intFlag_1;
    reg init_enable;
    reg [31:0] bus_rd_data;
    reg bus_rdy_;
    reg m0_grnt_;
    reg m1_grnt_;
    reg [31:0] i_instData_32;
    reg [31:0] i_readData_32;

    // Outputs
    wire [31:0] o_instAddr_32;
    wire [3:0] o_enToCache_4;
    wire [3:0] o_dataWen_4;
    wire [31:0] o_dataAddr_32;
    wire [31:0] o_writeData_32;
    wire m0_req_;
    wire [29:0] m0_addr;
    wire m0_as_;
    wire m0_rw;
    wire [31:0] m0_wr_data;
    wire m1_req_;
    wire [29:0] m1_addr;
    wire m1_as_;
    wire m1_rw;
    wire [31:0] m1_wr_data;

    // Instantiate the Unit Under Test (UUT)
    cpuCore uut (
        .clk(clk),
        .rstn(rstn),
        .i_intFlag_1(i_intFlag_1),
        .init_enable(init_enable),
        .bus_rd_data(bus_rd_data),
        .bus_rdy_(bus_rdy_),
        .m0_grnt_(m0_grnt_),
        .m1_grnt_(m1_grnt_),
        .o_instAddr_32(o_instAddr_32),
        .o_enToCache_4(o_enToCache_4),
        .i_instData_32(i_instData_32),
        .o_dataWen_4(o_dataWen_4),
        .o_dataAddr_32(o_dataAddr_32),
        .o_writeData_32(o_writeData_32),
        .i_readData_32(i_readData_32),
        .m0_req_(m0_req_),
        .m0_addr(m0_addr),
        .m0_as_(m0_as_),
        .m0_rw(m0_rw),
        .m0_wr_data(m0_wr_data),
        .m1_req_(m1_req_),
        .m1_addr(m1_addr),
        .m1_as_(m1_as_),
        .m1_rw(m1_rw),
        .m1_wr_data(m1_wr_data)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz
    end

    // 仿真主逻辑
    initial begin
        // 初始值
        rstn = 0;
        i_intFlag_1 = 0;
        init_enable = 0;
        bus_rd_data = 32'h00000000;
        bus_rdy_ = 0;
        m0_grnt_ = 0;
        m1_grnt_ = 0;
        i_instData_32 = 32'h00000013; // NOP
        i_readData_32 = 32'h00000000;

        // 复位脉冲
        #20;
        rstn = 1;

        // 初始化使能
        #10;
        init_enable = 1;
        #20;
        init_enable = 0;

        // 模拟一些数据交互
        #50;
        bus_rdy_ = 1;
        m0_grnt_ = 1;
        m1_grnt_ = 1;
        i_instData_32 = 32'h00000293; // li x5, 0

        // 模拟中断
        #100;
        i_intFlag_1 = 1;
        #20;
        i_intFlag_1 = 0;

        // 等待观察结果
        #200;

        $finish;
    end

endmodule

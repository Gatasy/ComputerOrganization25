`timescale 1ns/1ps

module cpu_top_tb;

  // 时钟和复位
  reg clk;
  reg rst;

  // cpu_top接口信号
  wire [31:0] instAddr_32;
  reg  [31:0] instData_32;
  wire [31:0] dataAddr_32;
  wire [ 3:0] dataWen_4;
  wire [31:0] writeData_32;
  reg  [31:0] readData_32;
  reg swio_i;
  reg timer_i;

  // 实例化 CPU
  cpu_top uut (
    .clk(clk),
    .rst(rst),
    .instAddr_32(instAddr_32),
    .instData_32(instData_32),
    .dataAddr_32(dataAddr_32),
    .dataWen_4(dataWen_4),
    .writeData_32(writeData_32),
    .readData_32(readData_32),
    .swio_i(swio_i),
    .timer_i(timer_i)
  );

  // 时钟生成
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz
  end

  // 指令存储器和数据存储器
  reg [31:0] inst_mem [0:255];
  reg [31:0] data_mem [0:255];
  integer i;

  // 初始化
  initial begin
    // 清空并填充默认值
    for (i = 0; i < 256; i = i + 1) begin
      inst_mem[i] = 32'h00000093; // 默认 NOP
      data_mem[i] = 32'h0;
    end

    // 加载指令
    $readmemh("inst_mem.hex", inst_mem);

    // 复位 (低有效复位)
    rst = 0;
    swio_i = 0;
    timer_i = 0;
    #20;
    rst = 1;  // 释放复位

    // swio_i 和 timer_i 初始保持低
  end

  // swio_i 激励：在第 500ns 时拉高
  initial begin
    #500;
    swio_i = 1;
    $display("[TEST] swio_i asserted at %0t", $time);
    #20;
    swio_i = 0;
    $display("[TEST] swio_i deasserted at %0t", $time);
  end

  // timer_i 激励：在第 1000ns 时拉高
  initial begin
    #1000;
    timer_i = 1;
    $display("[TEST] timer_i asserted at %0t", $time);
    #20;
    timer_i = 0;
    $display("[TEST] timer_i deasserted at %0t", $time);
  end

  // 指令读取
  always @(*) begin
    instData_32 = inst_mem[instAddr_32[9:2]];
  end

  // 数据读取
  always @(*) begin
    readData_32 = data_mem[dataAddr_32[9:2]];
  end

  // 数据写入
  always @(posedge clk) begin
    if (|dataWen_4) begin
      data_mem[dataAddr_32[9:2]] <= writeData_32;
      $display("[DATA STORE] @%0t addr=0x%08h data=0x%08h", $time, dataAddr_32, writeData_32);
    end
  end

  // 仿真监控
  always @(posedge clk) begin
    if (rst) begin
      $display("[INST FETCH] @%0t pc=0x%08h inst=0x%08h swio_i=%b timer_i=%b", $time,
               instAddr_32, instData_32, swio_i, timer_i);
    end
  end

  // 仿真停止条件
  initial begin
    #5000;
    $display("==== Simulation Finished ====");
    $finish;
  end

endmodule

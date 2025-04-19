`timescale 1ns / 1ps

module soc_core_tb;

   // 输入信号
   reg clk;
   reg rstn;
   reg rx;
   reg spi_miso;
   reg [31:0] io_pin_i;
   reg init_enable;  // 仿真时的初始化信号

   // 输出信号
   wire tx;
   wire spi_mosi;
   wire spi_ss;
   wire spi_clk;
   wire [31:0] gpio_pin_o;

   // 时钟和复位信号
   initial begin
     clk = 0;
     rstn = 0;  // 复位信号初始为低
     #5 rstn = 1;  // 在仿真开始后5ns释放复位信号
   end

   // 时钟信号生成，周期为10ns (100MHz)
   always #5 clk = ~clk;

   // 初始化输入信号
   initial begin
     rx = 0;      // UART 接收信号初始化为 0
     spi_miso = 0; // SPI MISO 初始化为 0
     io_pin_i = 32'b0;  // GPIO 输入初始化为 0
     init_enable = 1;    // 初始化使能信号设为 1

     // 测试：模拟一些输入
     #20 rx = 1;  // 10ns后给 UART 输入1
     #20 spi_miso = 1;  // 40ns后模拟 SPI MISO 输入

     // 进一步测试，模拟 GPIO 输入
     #30 io_pin_i = 32'hA5A5A5A5;  // 设置 GPIO 输入为某个值
     
     // 结束仿真
     #500 $finish;
   end

   // 实例化 soc_core 模块
   soc_core uut (
       .clk(clk),
       .rstn(rstn),
       .rx(rx),
       .tx(tx),
       .spi_miso(spi_miso),
       .spi_mosi(spi_mosi),
       .spi_ss(spi_ss),
       .spi_clk(spi_clk),
       .io_pin_i(io_pin_i),
       .gpio_pin_o(gpio_pin_o),
       .init_enable(init_enable)
   );

endmodule

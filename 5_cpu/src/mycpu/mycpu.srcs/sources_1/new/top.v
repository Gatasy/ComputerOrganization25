////////////////////////////////////////////////////////////////////////////////
// top_bus.v
// 顶层模块：连接 CPU 核（cpu_top）与 Bus4LZU IP，实现指令和数据总线、外设和中断连接
////////////////////////////////////////////////////////////////////////////////

module top (
    input  wire        clk,
    input  wire        rst,            // 复位，高电平有效

    // UART 接口
    input  wire        rx,             // 串口接收
    output wire        tx,             // 串口发送

    // GPIO 接口
    inout  wire [31:0] gpio_io         // 通用输入输出
);

// -----------------------------------------------------------------------------
// 总线/CPU 之间的信号
// -----------------------------------------------------------------------------
// 指令总线
wire [31:0] instAddr;
wire [31:0] instData;
// 数据总线
wire [31:0] dataAddr;
wire [ 3:0] dataWen;
wire [31:0] writeData;
wire [31:0] readData;
// 中断信号
wire        swio_irq;
wire        timer_irq;

// -----------------------------------------------------------------------------
// 1) 实例化 CPU 核（cpu_top_bus 版本）
// -----------------------------------------------------------------------------
cpu_top u_cpu (
    .clk           (clk),
    .rst           (rst),
    // 指令总线
    .instAddr_32   (instAddr),
    .instData_32   (instData),
    // 数据总线
    .dataAddr_32   (dataAddr),
    .dataWen_4     (dataWen),
    .writeData_32  (writeData),
    .readData_32   (readData),
    // 中断输入
    .swio_i        (swio_irq),
    .timer_i       (timer_irq)
);

// -----------------------------------------------------------------------------
// 2) 实例化 Bus4LZU IP
// -----------------------------------------------------------------------------
bus4LZU_0 u_bus (
    .clk           (clk),
    .rstn          (rst),
    // UART
    .rx            (rx),
    .tx            (tx),
    // GPIO
    .gpio_io       (gpio_io),
    // 指令总线
    .instAddr_32   (instAddr),
    .instData_32   (instData),
    // 数据总线
    .dataAddr_32   (dataAddr),
    .dataWen_4     (dataWen),
    .writeData_32  (writeData),
    .readData_32   (readData),
    // 外设中断
    .swio_iqr      (swio_irq),
    .timer_iqr     (timer_irq),
    // 其他外设接口可根据需要连接...
    .init_sig      ()
);

endmodule

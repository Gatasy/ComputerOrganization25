`timescale 1ns / 1ps
`include "riscv.h"

module soc_core(
    input  wire               clk,
    input  wire               rstn,

    // 物理外设口
    input  wire               rx,          // UART RX
    output wire               tx,          // UART TX
    input  wire               spi_miso,    // SPI MISO
    output wire               spi_mosi,    // SPI MOSI
    output wire               spi_ss,      // SPI SS
    output wire               spi_clk,     // SPI CLK
    input  wire [`GPIO_NUM-1:0] io_pin_i,  // GPIO 输入口
    output wire [`GPIO_NUM-1:0] gpio_pin_o, // GPIO 输出口

    // 复位／初始化控制
    input  wire               init_enable
);

    //---------------- 总线接口信号声明 ----------------//
    // CPU ↔ Bus4LZU 信号
    wire [31:0]  instAddr;
    wire [31:0]  instData;
    wire [3:0]   dataWen;
    wire [31:0]  dataAddr;
    wire [31:0]  writeData;
    wire [31:0]  readData;
    
    // 总线控制信号
    wire         m0_req, m1_req;
    wire [29:0] m0_addr, m1_addr;
    wire        m0_as, m1_as;
    wire        m0_rw, m1_rw; 
    wire [31:0] m0_wr_data, m1_wr_data;
    wire        grant0, grant1;
    wire        bus_ready;

    // 中断信号
    wire        timer_irq;
    wire        init_sig;       // 总线初始化控制

    //---------------- CPU核实例化 ----------------//
    cpuCore cpu_top (
        .clk           (clk),
        .rstn          (rstn),
        .i_intFlag_1   (timer_irq),    // 连接定时器中断
        .init_enable   (init_sig),     // 总线初始化控制

        // 总线接口
        .bus_rd_data   (readData),
        .bus_rdy_      (bus_ready),
        .m0_grnt_      (grant0),
        .m1_grnt_      (grant1),

        // 指令接口
        .o_instAddr_32 (instAddr),
        .i_instData_32 (instData),
        .o_enToCache_4 (),            // 已固定使能

        // 数据接口
        .o_dataWen_4   (dataWen),
        .o_dataAddr_32 (dataAddr),
        .o_writeData_32(writeData),
        .i_readData_32 (readData),

        // 主端口0（指令）
        .m0_req_       (m0_req),      // 连接到总线
        .m0_addr       (m0_addr),
        .m0_as_        (m0_as),
        .m0_rw         (m0_rw),
        .m0_wr_data    (m0_wr_data),
        
        // 主端口1（数据）
        .m1_req_       (m1_req),
        .m1_addr       (m1_addr),
        .m1_as_        (m1_as),
        .m1_rw         (m1_rw),
        .m1_wr_data    (m1_wr_data)
    );

    //---------------- 总线控制器实例化 ----------------//
    bus4LZU_0 bus4lzu_inst (
        .clk             (clk),
        .rstn            (rstn),

        // 主设备0接口（指令）
        .m0_req_         (m0_req),
        .m0_addr_30      (m0_addr),
        .m0_as_          (m0_as),
        .m0_rw           (m0_rw),
        .m0_wr_data      (m0_wr_data),
        .m0_grnt_        (grant0),

        // 主设备1接口（数据）
        .m1_req_         (m1_req),
        .m1_addr_30      (m1_addr),
        .m1_as_          (m1_as),
        .m1_rw           (m1_rw),
        .m1_wr_data      (m1_wr_data),
        .m1_grnt_        (grant1),

        // 外设接口
        .rx              (rx),
        .tx              (tx),
        .spi_miso       (spi_miso),
        .spi_mosi        (spi_mosi),
        .spi_ss          (spi_ss),
        .spi_clk         (spi_clk),
        .gpio_io_i       (io_pin_i),
        .gpio_io_o       (gpio_pin_o),

        // 存储器接口
        .instAddr_32     (instAddr),
        .instData_32     (instData),
        .dataAddr_32     (dataAddr),
        .writeData_32    (writeData),
        .readData_32     (readData),
        .dataWen_4       (dataWen),
        .bus_ready       (bus_ready),

        // 中断与初始化
        .timer_irq       (timer_irq),
        .init_sig        (init_sig)
    );

endmodule
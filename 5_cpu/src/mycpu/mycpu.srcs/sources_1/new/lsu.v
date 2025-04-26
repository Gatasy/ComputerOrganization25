////////////////////////////////////////////////////////////////////////////////
// lsu_bus.v
// Load/Store Unit for bus-based memory interface
// 去除内部 Dcache，改为通过外部总线访问数据
////////////////////////////////////////////////////////////////////////////////

module lsu(
    input  wire        clk,
    input  wire        rst,
    
    // 来自 ALU 的地址和控制信息
    input  wire [31:0]  i_alu_result,
    input  wire [71:0]  i_data,
    
    // 总线接口：输出到 Bus4LZU
    output wire [31:0]  dataAddr_32,
    output wire [ 3:0]  dataWen_4,
    output wire [31:0]  writeData_32,
    // 来自总线的读数据
    input  wire [31:0]  i_mem_read_data,
    
    // 返回给写回阶段的数据
    output wire [71:0]  o_data,
    output wire [36:0]  o_lsu_dec
);

    // ------------------------------------------------------------------------
    // 计算读写使能
    // i_data[33] = GRF 写使能（1 = 可能写寄存器）
    // i_data[32] = Mem 信号（1 = load/store）
    wire is_mem    = i_data[32];
    wire is_store  = (~i_data[33] && i_data[32]);

    // ------------------------------------------------------------------------
    // 总线读写信号
    assign dataAddr_32  = i_alu_result;
    assign writeData_32 = i_data[31:0];        // 写数据
    assign dataWen_4    = {4{is_store}};       // store 时全字节写使能

    // ------------------------------------------------------------------------
    // 暂存控制信息和 ALU 结果
    reg [71:0] data_reg;
    reg [31:0] alu_reg;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            data_reg <= 72'b0;
            alu_reg  <= 32'b0;
        end else begin
            data_reg <= i_data;
            alu_reg  <= i_alu_result;
        end
    end

    // ------------------------------------------------------------------------
    // 组合返回给写回阶段的数据：
    //  o_data[71:40] = load 时用总线读数据，否则用 ALU 结果
    //  o_data[39:0]  = 原控制信息/data
    //  o_lsu_dec     = 按原逻辑组装 (rd + 读/写数据)
    wire [31:0] load_data = i_mem_read_data;
    assign o_data[71:40]   = (data_reg[33] && data_reg[32]) 
                              ? load_data : alu_reg;
    assign o_data[39:0]    = data_reg[39:0];
    
    assign o_lsu_dec       = data_reg[33] 
                              ? (data_reg[32] 
                                  ? {data_reg[38:34], load_data}       // load 写寄存器数据
                                  : {data_reg[38:34], alu_reg})         // ALU 写寄存器数据
                              : 37'b0;

endmodule

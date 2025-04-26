////////////////////////////////////////////////////////////////////////////////
// cpu_top_bus.v
// CPU ����ģ�飬ͨ���ⲿ Bus4LZU �ṩ�� I-Cache/ROM �� D-Cache/����ӿ�
////////////////////////////////////////////////////////////////////////////////

module cpu_top(
    input  wire        clk,
    input  wire        rst,

    // ���� ָ�����߽ӿ� ����
    output wire [31:0]  instAddr_32,    // ȡָ��ַ
    input  wire [31:0]  instData_32,    // ȡָ����

    // ���� �������߽ӿ� ����
    output wire [31:0]  dataAddr_32,    // ���ݵ�ַ
    output wire [ 3:0]  dataWen_4,      // дʹ��
    output wire [31:0]  writeData_32,   // д����
    input  wire [31:0]  readData_32,    // ������

    // ���� �ж����� ����
    input  wire         swio_i,         // ����ж� (int#0)
    input  wire         timer_i         // ��ʱ���ж� (int#11)
);

// -----------------------------------------------------------------------------
// �ڲ��ź�
// -----------------------------------------------------------------------------
wire [32:0] wb_pc_newpc;
wire [32:0] dec_pc_newpc;
wire [63:0] pc_dec_data;
wire        stop;

wire [ 4:0] grf_rj;
wire [ 4:0] grf_rk;
wire [ 4:0] grf_rd;
wire [ 9:0] dec_alu_opcode;
wire [ 5:0] dec_alu_selcode;

wire [11:0] dec_extend_imm12;
wire [ 4:0] dec_extend_ui5;
wire [ 5:0] dec_extend_sign;
wire [19:0] dec_extend_si20;
wire [15:0] dec_extend_offs16;
wire [ 9:0] dec_extend_offs26;

wire [39:0] dec_alu_data;
wire [37:0] dec_prejump;
wire [31:0] extend_alu_imm32;
wire [31:0] extend_alu_offs32;
wire [36:0] wb_dec_data;
wire [36:0] lsu_dec_data;
wire [36:0] alu_dec_data;
wire [ 5:0] alu_dec_stop;
wire [31:0] grf_alu_rj_data;
wire [31:0] grf_alu_rk_data;
wire [31:0] grf_alu_rd_data;
wire [31:0] alu_lsu_result;
wire [71:0] alu_lsu_data;
wire [71:0] lsu_wb_data;

wire        dec_csr_exception;
wire        dec_csr_interrupt;
wire [ 3:0] dec_csr_index;
wire [31:0] dec_csr_pc;
wire [32:0] csr_pc_newpc;

// -----------------------------------------------------------------------------
// 1. ��������� PC (ͨ���ⲿ����ȡָ)
// -----------------------------------------------------------------------------
pc u_pc(
    .clk(clk),
    .rst(rst),
    .i_wb_newpc(wb_pc_newpc),
    .i_dec_newpc(dec_pc_newpc),
    .i_exception_newpc(csr_pc_newpc),
    .stop(stop),
    .instAddr_32(instAddr_32),
    .instData_32(instData_32),
    .o_data(pc_dec_data)
);

// -----------------------------------------------------------------------------
// 2. ָ������ DECODE
// -----------------------------------------------------------------------------
decode u_dec(
    .i_data(pc_dec_data),
    .clk(clk),
    .rst(rst),
    .stop(stop),
    .dec_jump(pc_dec_data[32]),  // ���� PC ����ת��־
    .swio_i(swio_i),
    .timer_i(timer_i),
    .o_grf_rj(grf_rj),
    .o_grf_rk(grf_rk),
    .o_grf_rd(grf_rd),
    .o_alu_opcode(dec_alu_opcode),
    .o_alu_selcode(dec_alu_selcode),
    .o_extend_imm12(dec_extend_imm12),
    .o_extend_ui5(dec_extend_ui5),
    .o_extend_sign(dec_extend_sign),
    .o_extend_si20(dec_extend_si20),
    .o_extend_offs16(dec_extend_offs16),
    .o_extend_offs26(dec_extend_offs26),
    .o_data(dec_alu_data),
    .o_prejump(dec_prejump),
    .o_exception(dec_csr_exception),
    .o_interrupt(dec_csr_interrupt),
    .o_index(dec_csr_index),
    .o_pc_exception(dec_csr_pc)
);

// -----------------------------------------------------------------------------
// 3. ��������ƫ����չ EXTEND
// -----------------------------------------------------------------------------
extend u_ext(
    .i_i12(dec_extend_imm12),
    .i_ui5(dec_extend_ui5),
    .i_si20(dec_extend_si20),
    .i_offs16(dec_extend_offs16),
    .i_offs26(dec_extend_offs26),
    .i_sign(dec_extend_sign),
    .o_to_alu_imm32(extend_alu_imm32),
    .o_to_alu_offs32(extend_alu_offs32)
);

// -----------------------------------------------------------------------------
// 4. ͨ�üĴ����� GRF
// -----------------------------------------------------------------------------
grf u_grf(
    .clk(clk),
    .rst(rst),
    .i_rj(grf_rj),
    .i_rk(grf_rk),
    .i_rd(grf_rd),
    .i_writeback_data(wb_dec_data),
    .i_lsu_data(lsu_dec_data),
    .i_alu_data(alu_dec_data),
    .load_stop_sign(alu_dec_stop),
    .o_to_alu_rj(grf_alu_rj_data),
    .o_to_alu_rk(grf_alu_rk_data),
    .o_to_alu_rd(grf_alu_rd_data),
    .stop(stop)
);

// -----------------------------------------------------------------------------
// 5. Ԥ��ת�߼� PREJUMP
// -----------------------------------------------------------------------------
prejump u_pj(
    .i_data(dec_prejump),
    .rj_data(grf_alu_rj_data),
    .rd_data(grf_alu_rd_data),
    .offs16(dec_extend_offs16),
    .o_newpc(dec_pc_newpc)
);

// -----------------------------------------------------------------------------
// 6. �����߼���Ԫ ALU
// -----------------------------------------------------------------------------
alu u_alu(
    .clk(clk),
    .rst(rst),
    .i_grf_rj(grf_alu_rj_data),
    .i_grf_rk(grf_alu_rk_data),
    .i_grf_rd(grf_alu_rd_data),
    .i_extend_imm(extend_alu_imm32),
    .i_extend_offs(extend_alu_offs32),
    .i_op_code(dec_alu_opcode),
    .i_sel_code(dec_alu_selcode),
    .i_data(dec_alu_data),
    .stop(stop),
    .o_to_lsu(alu_lsu_result),
    .o_data(alu_lsu_data),
    .o_alu_dec(alu_dec_data),
    .load_stop_sign(alu_dec_stop)
);

// -----------------------------------------------------------------------------
// 7. Load/Store ��Ԫ LSU (�ⲿ���߰�)
// -----------------------------------------------------------------------------
lsu u_lsu(
    .clk(clk),
    .rst(rst),
    .i_alu_result(alu_lsu_result),
    .i_data(alu_lsu_data),
    .i_mem_read_data(readData_32),
    .dataAddr_32(dataAddr_32),
    .dataWen_4(dataWen_4),
    .writeData_32(writeData_32),
    .o_data(lsu_wb_data),
    .o_lsu_dec(lsu_dec_data)
);

// -----------------------------------------------------------------------------
// 8. д�� WB
// -----------------------------------------------------------------------------
writeback u_wb(
    .i_data(lsu_wb_data),
    .clk(clk),
    .rst(rst),
    .o_grf_data(wb_dec_data),
    .o_pc_newpc(wb_pc_newpc)
);

// -----------------------------------------------------------------------------
// 9. CSR/�쳣����
// -----------------------------------------------------------------------------
csr u_csr(
    .clk(clk),
    .rst_n(rst),
    .interrupt(dec_csr_interrupt),
    .exception(dec_csr_exception),
    .index(dec_csr_index),
    .pc(dec_csr_pc),
    .j_exception_addr(csr_pc_newpc)
);

endmodule

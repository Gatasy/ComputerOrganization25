`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/06 15:23:03
// Design Name: 
// Module Name: cpu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_top(
input wire clk,
input wire rst
    );

wire [32:0] wb_pc_newpc;
wire [32:0] dec_pc_newpc;
wire [63:0] pc_dec_data;
wire stop;
wire [4:0] grf_rj;
wire [4:0] grf_rk;
wire [4:0] grf_rd;
wire [9:0] dec_alu_opcode;
wire [5:0] dec_alu_selcode;
wire jump_sign2_stop;

wire [11:0] dec_extend_imm12;
wire [4:0] dec_extend_ui5;
wire [5:0] dec_extend_sign;
wire [19:0] dec_extend_si20;
wire [15:0] dec_extend_offs16;
wire [9:0] dec_extend_offs26;
wire [39:0] dec_alu_data;
wire [37:0] dec_prejump;
wire [31:0] extend_alu_imm32;
wire [31:0] extend_alu_offs32;
wire [36:0] wb_dec_data;
wire [36:0] lsu_dec_data;
wire [36:0] alu_dec_data;
wire [5:0] alu_dec_stop;
wire [31:0] grf_alu_rj_data;
wire [31:0] grf_alu_rk_data;
wire [31:0] grf_alu_rd_data;
wire [31:0] alu_lsu_result;
wire [71:0] alu_lsu_data;
wire [71:0] lsu_wb_data;

wire dec_csr_exception;
wire [3:0] dec_csr_index;
wire [31:0] dec_csr_pc;
wire [32:0] csr_pc_newpc;

pc pc1(
.clk(clk),
.rst(rst),
.i_wb_newpc(wb_pc_newpc),
.i_dec_newpc(dec_pc_newpc),
.i_exception_newpc(csr_pc_newpc),
.stop(stop),

.o_data(pc_dec_data)
    );   
    
decode dec(
.i_data(pc_dec_data),
.clk(clk),
.rst(rst),
.stop(stop),
.dec_jump(dec_pc_newpc[32]),
    
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
.o_index(dec_csr_index),
.o_pc_exception(dec_csr_pc)
);   
    
extend ext(
.i_i12(dec_extend_imm12),
.i_ui5(dec_extend_ui5),
.i_si20(dec_extend_si20),
.i_offs16(dec_extend_offs16),
.i_offs26(dec_extend_offs26),
.i_sign(dec_extend_sign),

.o_to_alu_imm32(extend_alu_imm32),
.o_to_alu_offs32(extend_alu_offs32)
);
    
grf grf1(
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

prejump prej(
.i_data(dec_prejump),
.rj_data(grf_alu_rj_data),
.rd_data(grf_alu_rd_data),
.offs16(dec_extend_offs16),

.o_newpc(dec_pc_newpc)
    );

alu alu1(
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

lsu lsu1(
.clk(clk),
.rst(rst),
.i_alu_result(alu_lsu_result),
.i_data(alu_lsu_data),

.o_data(lsu_wb_data),
.o_lsu_dec(lsu_dec_data)
    );

writeback wb(
.i_data(lsu_wb_data),
.clk(clk),
.rst(rst),

.o_grf_data(wb_dec_data),
.o_pc_newpc(wb_pc_newpc)
    );

csr csr1(
.rst(rst),
.exception(dec_csr_exception),//00-无异常    01-异常触发   10-异常返回
.index(dec_csr_index),//0001-非法指令   0010-SYSCALL   0100-BREAK    1000-ERTN
.pc(dec_csr_pc),

.j_exception_addr(csr_pc_newpc)
);
    
endmodule

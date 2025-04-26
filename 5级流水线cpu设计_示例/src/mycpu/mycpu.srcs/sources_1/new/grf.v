`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 11:55:26
// Design Name: 
// Module Name: GRF
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

module grf(
input wire clk,
input wire rst,
input wire [4:0] i_rj,
input wire [4:0] i_rk,
input wire [4:0] i_rd,
input wire [36:0] i_writeback_data,
input wire [36:0] i_lsu_data,
input wire [36:0] i_alu_data,
input wire [5:0] load_stop_sign,

output reg [31:0] o_to_alu_rj,
output reg [31:0] o_to_alu_rk,
output reg [31:0] o_to_alu_rd,
output wire stop
    );
    
reg [31:0] regs[31:0];
wire [2:0] rj_sign;
wire [2:0] rk_sign;
wire [2:0] rd_sign;
assign rj_sign = {(i_rj == i_alu_data[36:32]), (i_rj == i_lsu_data[36:32]), (i_rj == i_writeback_data[36:32])};
assign rk_sign = {(i_rk == i_alu_data[36:32]), (i_rk == i_lsu_data[36:32]), (i_rk == i_writeback_data[36:32])};
assign rd_sign = {(i_rd == i_alu_data[36:32]), (i_rd == i_lsu_data[36:32]), (i_rd == i_writeback_data[36:32])};
assign stop = load_stop_sign[5] ? ((i_rj == load_stop_sign[4:0]) | (i_rk == load_stop_sign[4:0]) | (i_rd == load_stop_sign[4:0])) : 1'b0;


always @(negedge rst) begin
    regs[0] <= 0;
    regs[1] <= 0;
    regs[2] <= 0;
    regs[3] <= 0;
    regs[4] <= 0;
    regs[5] <= 0;
    regs[6] <= 0;
    regs[7] <= 0;
    regs[8] <= 0;
    regs[9] <= 0;
    regs[10] <= 0;
    regs[11] <= 0;
    regs[12] <= 0;
    regs[13] <= 0;
    regs[14] <= 0;
    regs[15] <= 0;
    regs[16] <= 0;
    regs[17] <= 0;
    regs[18] <= 0;
    regs[19] <= 0;
    regs[20] <= 0;
    regs[21] <= 0;
    regs[22] <= 0;
    regs[23] <= 0;
    regs[24] <= 0;
    regs[25] <= 0;
    regs[26] <= 0;
    regs[27] <= 0;
    regs[28] <= 0;
    regs[29] <= 0;
    regs[30] <= 0;
    regs[31] <= 0;
end

always @(posedge clk) begin
    regs[i_writeback_data[36:32]] <= ((i_writeback_data[36:32] == 5'b0) ? 32'b0 : i_writeback_data[31:0]);
end

always @(*) begin
    casex(rj_sign)
        3'b1xx:o_to_alu_rj <= i_alu_data[31:0];
        3'b01x:o_to_alu_rj <= i_lsu_data[31:0];
        3'b001:o_to_alu_rj <= i_writeback_data[31:0];
        3'b000:o_to_alu_rj <= regs[i_rj];
    endcase
end

always @(*) begin
    casex(rk_sign)
        3'b1xx:o_to_alu_rk <= i_alu_data[31:0];
        3'b01x:o_to_alu_rk <= i_lsu_data[31:0];
        3'b001:o_to_alu_rk <= i_writeback_data[31:0];
        3'b000:o_to_alu_rk <= regs[i_rk];
    endcase
end

always @(*) begin
    casex(rd_sign)
        3'b1xx:o_to_alu_rd <= i_alu_data[31:0];
        3'b01x:o_to_alu_rd <= i_lsu_data[31:0];
        3'b001:o_to_alu_rd <= i_writeback_data[31:0];
        3'b000:o_to_alu_rd <= regs[i_rd];
    endcase
end




endmodule

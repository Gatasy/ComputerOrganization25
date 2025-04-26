`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 10:54:52
// Design Name: 
// Module Name: ALU
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


module alu(
input wire clk,
input wire rst,
input wire [31:0] i_grf_rj,
input wire [31:0] i_grf_rk,
input wire [31:0] i_grf_rd,
input wire [31:0] i_extend_imm,
input wire [31:0] i_extend_offs,
input wire [9:0] i_op_code,
input wire [5:0] i_sel_code,
input wire [39:0] i_data,
input wire stop,


output reg [31:0] o_to_lsu,
output wire [71:0] o_data,
output wire [36:0] o_alu_dec,
output wire [5:0] load_stop_sign
    );
    
reg [9:0] op_code;
reg [31:0] data_1;
reg [31:0] data_2;
reg [71:0] data;
    
assign o_data = data;
assign o_alu_dec = data[32] ? 37'b0 : {data[38:34], o_to_lsu};
assign load_stop_sign = {(data[33:32] == 2'b11), data[38:34]};
always@(posedge clk or negedge rst) begin
    if(!rst | data[39] | stop) begin
        op_code <= 10'b0;
        data_1 <= 32'b0;
        data_2 <= 32'b0;
        o_to_lsu <= 32'b0;
        data <= 72'b0;
    end
    else begin
        data[39:0] <= i_data;
        data[71:40] <= i_grf_rd;
        op_code <= i_op_code;
        case(i_sel_code)
            6'b000001:begin
                data_1 <= i_grf_rj;
                data_2 <= i_grf_rk;
            end
            6'b000010:begin
                data_1 <= i_grf_rj;
                data_2 <= i_extend_imm;
            end
            6'b000100:begin
                data_1 <= i_data[31:0];
                data_2 <= i_extend_imm;
            end
            6'b001000:begin
                data_1 <= 32'b0;
                data_2 <= i_extend_imm;
            end
            6'b010000:begin
                data_1 <= i_grf_rj;
                data_2 <= i_extend_offs;
            end
            6'b100000:begin
                data_1 <= i_data[31:0];
                data_2 <= i_extend_offs;
            end
            default begin
                data_1 <= 32'b0;
                data_2 <= 32'b0;
            end
        endcase
    end
end

always @(*) begin
    case(op_code)
        10'b0000000001:o_to_lsu <= data_1 & data_2;//AND
        10'b0000000010:o_to_lsu <= data_1 | data_2;//OR
        10'b0000000100:o_to_lsu <= data_1 ^ data_2;//XOR
        10'b0000001000:o_to_lsu <= data_1 + data_2;//ADD
        10'b0000010000:o_to_lsu <= data_1 - data_2;//SUB
        10'b0000100000:o_to_lsu <= data_1 << data_2;//SLL
        10'b0001000000:o_to_lsu <= data_1 >> data_2;//SRL
        10'b0010000000:o_to_lsu <= data_1 >>> data_2;//SRA
        10'b0100000000:o_to_lsu <= (($signed(data_1) < $signed(data_2)) ? 32'b1 : 32'b0);//SLT
        10'b1000000000:o_to_lsu <= (($unsigned(data_1) < $unsigned(data_2)) ? 32'b1 : 32'b0);//SLTU
        default begin
            o_to_lsu <= 32'b0;
        end
    endcase
end

endmodule

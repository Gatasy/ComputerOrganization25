`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 22:15:17
// Design Name: 
// Module Name: extend
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


module extend(
input wire [11:0] i_i12,
input wire [4:0] i_ui5,
input wire [19:0] i_si20,
input wire [15:0] i_offs16,
input wire [9:0] i_offs26,
input wire [5:0] i_sign,

output reg [31:0] o_to_alu_imm32,
output reg [31:0] o_to_alu_offs32
    );

wire [31:0] imm_ui5_32;
wire [31:0] imm_i12_si32;
wire [31:0] imm_i12_ui32;
wire [31:0] imm_si20_si32;
wire [31:0] imm_offs16_32;
wire [31:0] imm_offs26_32;
assign imm_ui5_32 = {27'b0 , i_ui5};
assign imm_i12_si32 = (i_i12[11] ? {20'b11111111111111111111 ,i_i12} : {20'b0 ,i_i12});
assign imm_i12_ui32 = {20'b0 ,i_i12};
assign imm_si20_si32 = (i_si20[19] ? {12'b111111111111, i_si20} : {12'b0, i_si20});
assign imm_offs16_32 = (i_offs16[15] ? {14'b11111111111111 ,i_offs16 ,2'b0} : {14'b0, i_offs16, 2'b0});
assign imm_offs26_32 = (i_offs26[9] ? {4'b11111, i_offs26, i_offs16, 2'b0} : {4'b0, i_offs26, i_offs16, 2'b0});

always@(*) begin
    case(i_sign)
        6'b000000:begin
            o_to_alu_imm32 <= 32'b0;
            o_to_alu_offs32 <= 32'b0;
        end
        6'b000001:begin
            o_to_alu_imm32 <= 32'b0;
            o_to_alu_offs32 <= imm_offs26_32;
        end
        6'b000010:begin
            o_to_alu_imm32 <= 32'b0;
            o_to_alu_offs32 <= imm_offs16_32;
        end
        6'b000100:begin
            o_to_alu_imm32 <= imm_si20_si32;
            o_to_alu_offs32 <= 32'b0;
        end
        6'b001000:begin
            o_to_alu_imm32 <= imm_i12_ui32;
            o_to_alu_offs32 <= 32'b0;
        end
        6'b010000:begin
            o_to_alu_imm32 <= imm_i12_si32;
            o_to_alu_offs32 <= 32'b0;
        end
        6'b100000:begin
            o_to_alu_imm32 <= imm_ui5_32;
            o_to_alu_offs32 <= 32'b0;
        end
    endcase
end
  
    
    
    
endmodule

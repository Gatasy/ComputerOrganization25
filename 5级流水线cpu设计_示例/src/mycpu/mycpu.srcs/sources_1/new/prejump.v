`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/22 22:27:30
// Design Name: 
// Module Name: prejump
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


module prejump(
input wire [37:0] i_data,
input wire [31:0] rj_data,
input wire [31:0] rd_data,
input wire [15:0] offs16,

output wire [32:0] o_newpc
    );
    
reg jump;
wire [31:0] offs32;
assign offs32 = offs16[15] ? {14'b11111111111111, offs16, 2'b0} : {14'b0, offs16, 2'b0};
//{inst_BEQ, inst_BNE, inst_BLT, inst_BGE, inst_BLTU, inst_BGEU,
always @(*) begin
    case(i_data[37:32])
        6'b000001:jump <= (($unsigned(rj_data) < $unsigned(rd_data)) ? 1'b0 : 1'b1);
        6'b000010:jump <= (($unsigned(rj_data) < $unsigned(rd_data)) ? 1'b1 : 1'b0);
        6'b000100:jump <= (($signed(rj_data) < $signed(rd_data)) ? 1'b0 : 1'b1);
        6'b001000:jump <= (($signed(rj_data) < $signed(rd_data)) ? 1'b1 : 1'b0);
        6'b010000:jump <= ((rj_data == rd_data) ? 1'b0 : 1'b1);
        6'b100000:jump <= ((rj_data == rd_data) ? 1'b1 : 1'b0);
        default begin
            jump <= 1'b0;
        end
    endcase
end


assign o_newpc = {jump, offs32 + i_data[31:0]};
endmodule

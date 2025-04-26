`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/06 22:23:58
// Design Name: 
// Module Name: lsu
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


module lsu(
input wire clk,
input wire rst,
input wire [31:0] i_alu_result,
input wire [71:0] i_data,

output wire [71:0] o_data,
output wire [36:0] o_lsu_dec
    );
    
wire clkb;
wire [31:0] dcache_out;
wire [3:0] wen;

reg [71:0] data;
reg [31:0] alu_result;

assign clkb = ~clk;
assign wen = {(~data[33] & data[32]),(~data[33] & data[32]),(~data[33] & data[32]),(~data[33] & data[32])};
assign o_data[71:40] = (data[33:32] == 2'b11) ? dcache_out : alu_result;
assign o_data[39:0] = data;
assign o_lsu_dec = data[33] ? (data[32] ? {data[38:34], dcache_out} : {data[38:34], alu_result}) : 37'b0;

always@(posedge clk or negedge rst) begin
    if(!rst | data[39]) begin
        data <= 72'b0;
        alu_result <= 32'b0;
    end
    else begin
        data <= i_data;
        alu_result <= i_alu_result;
    end
end    

blk_mem_gen_1 dcache (
  .clka(clk),    // input wire clka
  .wea(wen),      // input wire [3 : 0] wen
  .addra(alu_result),  // input wire [8 : 0] addra
  .dina(data[71:40]),    // input wire [31 : 0] dina
  
  .clkb(clkb),    // input wire clkb
  .addrb(alu_result),  // input wire [8 : 0] addrb
  .doutb(dcache_out)  // output wire [31 : 0] doutb
);


endmodule

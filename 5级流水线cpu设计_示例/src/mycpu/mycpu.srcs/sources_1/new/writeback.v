`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/05 23:59:49
// Design Name: 
// Module Name: writeback
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


module writeback(
input wire [71:0] i_data,
input wire clk,
input wire rst,

output wire [36:0] o_grf_data,
output wire [32:0] o_pc_newpc
    );

reg [71:0] data;

assign o_grf_data[36:32] = data[33] ? data[38:34] : 5'b0;
assign o_grf_data[31:0] = data[39] ? (data[31:0] + 4) : data[71:40];
assign o_pc_newpc = {data[39], data[71:40]};

always@(posedge clk or negedge rst) begin
    if(!rst | data[39]) begin
        data <= 72'b0;
    end
    else begin
        data <= i_data;
    end
end    

endmodule

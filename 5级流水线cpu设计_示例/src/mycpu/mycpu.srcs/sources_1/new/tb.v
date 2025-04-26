`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/07 09:07:46
// Design Name: 
// Module Name: tb
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


module tb;

reg clk;
reg rst;

cpu_top cpu(
.clk(clk),
.rst(rst)
    );

always #10 clk=~clk;
initial begin
clk = 1;
rst = 0;
#20


rst = 1;
#660


$finish;
#360

#3600
$finish;
end


endmodule

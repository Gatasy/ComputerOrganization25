`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/28 11:42:37
// Design Name: 
// Module Name: csr
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


module csr(
input wire rst,
input wire exception,
input wire [3:0] index,//0001-非法指令   0010-SYSCALL   0100-BREAK    1000-ERTN
input wire [31:0] pc,

output wire [32:0] j_exception_addr
    );
   

 
reg [31:0] ERA;//0x6   例外返回地址

reg [31:0] EENTRY;//0xc   例外进入地址

reg [31:0] SAVE_0;//0x30   数据保存
reg [31:0] SAVE_1;//0x31   数据保存
reg [31:0] SAVE_2;//0x32   数据保存
reg [31:0] SAVE_3;//0x33   数据保存

assign j_exception_addr = exception ? (index[3] ? {1'b1, ERA} :{1'b1, EENTRY}) : 33'b0;

always @(*) begin
    if(~rst) begin
        ERA <= 32'b0;
        EENTRY <= 32'b0;
        SAVE_0 <= 32'b0;
        SAVE_1 <= 32'b0;
        SAVE_2 <= 32'b0;
        SAVE_3 <= 32'b0;
    end
    else begin
        case(index)
            4'b0000:begin EENTRY <= 32'b0;ERA <= ERA;end
            4'b0001:begin EENTRY <= 32'b1;ERA <= pc + 4;end
            4'b0010:begin EENTRY <= 32'b0;ERA <= pc + 4;end
            4'b0100:begin EENTRY <= 32'b0;ERA <= pc + 4;end
            4'b1000:begin EENTRY <= 32'b0;ERA <= ERA;end
        endcase
    end
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/30 12:20:18
// Design Name: 
// Module Name: pc
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
// 实现PC模块，负责：
//控制程序计数器（pc_now、pc_next）的更新；
//根据各种跳转指令（普通跳转、中断跳转、分支跳转、异常跳转）调整PC；
//从指令缓存icache中取出指令；
//特殊处理了 BL（Branch and Link） 和 JIRL（Jump and Link Register）这两类指令的延迟跳转控制。
//////////////////////////////////////////////////////////////////////////////////


module pc(
input wire clk, 
input wire rst,
input wire [32:0] i_wb_newpc, //回写阶段发来的新PC地址,最高位32表示是否有效
input wire [32:0] i_dec_newpc,  //	解码阶段发来的新PC地址,最高位32表示是否有效
input wire [32:0] i_exception_newpc, //	异常处理阶段发来的新PC地址,最高位32表示是否有效
input wire stop, //暂停信号,保持当前PC不变


output wire [63:0] o_data //	当前PC值与指令拼接	64位输出 {pc_now, instruction}
    );
    
reg [31:0] instruction;
reg [31:0] pc_now;
reg [31:0] pc_next;
wire [31:0] icache_out;
wire B_jump;
wire [31:0] B_addr;
wire i_jump;
wire [31:0] i_addr;
assign i_jump = i_wb_newpc[32] | i_dec_newpc[32] | i_exception_newpc[32]; //处理跳转
assign i_addr = i_wb_newpc[32] ? i_wb_newpc[31:0] : (i_dec_newpc[32] ? i_dec_newpc[31:0] : i_exception_newpc[31:0]); //根据优先级处理pc，得到新地址
assign B_jump = (instruction[31:26] == 6'b010100);//B
assign BL_jump = (instruction[31:26] == 6'b010101);//BL
assign JIRL_jump = (instruction[31:26] == 6'b010011);//JIRL
assign jump_sign2 = BL_jump | JIRL_jump;
assign B_addr = instruction[25] ? ({4'b1111, instruction[9:0], instruction[25:10], 2'b0} + pc_now) : ({4'b0, instruction[9:0], instruction[25:10], 2'b0} + pc_now);

wire [31:0] addr;
assign addr = (i_jump | B_jump) ? (B_jump ? B_addr : i_addr) : pc_next;

wire [3:0] jump_sign;
assign jump_sign = {i_dec_newpc[32], i_wb_newpc[32], B_jump, i_exception_newpc[32]};//按优先级跳转或者顺序执行，更新jump模块
assign o_data = (~rst | B_jump | i_jump | jump_sign2_stop) ? 64'b0 : {pc_now, instruction};

always@(posedge clk or negedge rst) begin
    if(~rst) begin
        pc_now <= 32'h00000010;
        pc_next <= 32'h00000010;
        instruction <= 32'b0;
    end
    else if(stop) begin
        pc_now <= pc_now;
        pc_next <= pc_next;
        instruction <= instruction;
    end
    else begin 
        instruction <= icache_out;
        case(jump_sign)
            4'b0001:begin//exception_jump
                pc_now <= i_exception_newpc[31:0];
                pc_next <= i_exception_newpc[31:0] + 4;
            end
            4'b0010:begin//B_jump
                pc_now <= B_addr;
                pc_next <= B_addr + 4;
            end
            4'b0100:begin//i_wb_newpc[32]
                pc_now <= i_wb_newpc[31:0];
                pc_next <= i_wb_newpc[31:0] + 4;
            end
            4'b1000:begin//i_dec_newpc[32]
                pc_now <= i_dec_newpc[31:0];
                pc_next <= i_dec_newpc[31:0] + 4;
            end
            4'b0000:begin
                pc_now <= pc_next;
                pc_next <= pc_next + 4;
            end
        endcase
    end
end



blk_mem_gen_0 icache (
  .clka(~clk),    // input wire clka
  .wea(),      // input wire [0 : 0] wea
  .addra(addr[10:2]),  // input wire [8 : 0] addra
  .dina(),    // input wire [31 : 0] dina
  .douta(icache_out)  // output wire [31 : 0] douta
);

//jirl bl counter
reg [2:0] counter;
reg counter_state;
reg jump_sign2_stop;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        counter <= 3'b0;
        counter_state <= 1'b0;
        jump_sign2_stop <= 1'b0;
    end
    else begin
        if(jump_sign2 & counter_state == 3'b0) begin
            counter <= 3'b1;
            counter_state <= 1'b1;
            jump_sign2_stop <= 1'b1;
        end
        else begin
            if(counter == 3'b100) begin
                counter <= 2'b0;
                counter_state <= 1'b0;
                jump_sign2_stop <= 1'b0;
            end
            else begin
                counter <= counter + 1;
                counter_state <= counter_state;
                jump_sign2_stop <= jump_sign2_stop;
            end
        end
    end
end



endmodule

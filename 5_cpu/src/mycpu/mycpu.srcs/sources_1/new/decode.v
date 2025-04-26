`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 21:06:23
// Design Name: 
// Module Name: decode
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

module decode (
input wire [63:0] i_data,
input wire clk,
input wire rst,
input wire stop,
input wire dec_jump,
input wire swio_i,    // 软件中断 SWIO (中断号0)
input wire timer_i,   // 定时器中断 Timer (中断号11)

output wire [4:0] o_grf_rj,
output wire [4:0] o_grf_rk,
output wire [4:0] o_grf_rd,
output wire [9:0] o_alu_opcode,
output wire [5:0] o_alu_selcode,
output wire [11:0] o_extend_imm12,
output wire [4:0] o_extend_ui5,
output wire [5:0] o_extend_sign,
output wire [19:0] o_extend_si20,
output wire [15:0] o_extend_offs16,
output wire [9:0] o_extend_offs26,

output wire [39:0] o_data,
output wire [37:0] o_prejump,

output wire o_exception,
output wire  o_interrupt,       // 软件中断请求 (SWIO)
output wire [7:0] o_index, // [7:4]=中断号, [3:0]=异常号
output wire [31:0] o_pc_exception
);   

reg [63:0] data;

wire [16:0] func_code_31_15;//R or exception enter
wire [9:0] func_code_31_22;//I
wire [5:0] func_code_31_26;//B 
wire [6:0] func_code_31_25;//U
wire [21:0] func_code_31_10;//exception back
//wire [3:0] exc_code;
wire sign_R, sign_I, sign_B, sign_U, sign_exception;

assign func_code_31_15 = data[31:15];
assign func_code_31_22 = data[31:22];
assign func_code_31_26 = data[31:26];
assign func_code_31_25 = data[31:25];
assign func_code_31_10 = data[31:10];

wire inst_ADD,inst_SUB,inst_SLL,inst_SRL,inst_SRA,inst_AND,inst_OR,
inst_XOR,inst_SLT,inst_SLTU,inst_ADDI,inst_SLLI,inst_SRLI,inst_SRAI,
inst_ANDI,inst_ORI,inst_XORI,inst_SLTI,inst_SLTUI,inst_BL,inst_BEQ,
inst_BNE,inst_BLT,inst_BGE,inst_BLTU,inst_BGEU,inst_JIRL,inst_LDW,inst_STW,
inst_LU12I,inst_PCADDU12I,
inst_SYSCALL,inst_BREAK,inst_ERTN,
inst_NOP;
assign inst_ADD = (func_code_31_15 == `func_add);
assign inst_SUB = (func_code_31_15 == `func_sub);
assign inst_SLL = (func_code_31_15 == `func_sll);
assign inst_SRL = (func_code_31_15 == `func_srl);
assign inst_SRA = (func_code_31_15 == `func_sra);
assign inst_AND = (func_code_31_15 == `func_and);
assign inst_OR = (func_code_31_15 == `func_or);
assign inst_XOR = (func_code_31_15 == `func_xor);
assign inst_SLT = (func_code_31_15 == `func_slt);
assign inst_SLTU = (func_code_31_15 == `func_sltu);
assign inst_SLLI = (func_code_31_15 == `func_slli);
assign inst_SRLI = (func_code_31_15 == `func_srli);
assign inst_SRAI = (func_code_31_15 == `func_srai);
assign inst_SYSCALL = (func_code_31_15 == `func_syscall);
assign inst_BREAK = (func_code_31_15 == `func_break);

assign inst_ADDI = (func_code_31_22 == `func_addi);
assign inst_ANDI = (func_code_31_22 == `func_andi);
assign inst_ORI = (func_code_31_22 == `func_ori);
assign inst_XORI = (func_code_31_22 == `func_xori);
assign inst_SLTI = (func_code_31_22 == `func_slti);
assign inst_SLTUI = (func_code_31_22 == `func_sltui);
assign inst_LDW = (func_code_31_22 == `func_ldw);
assign inst_STW = (func_code_31_22 == `func_stw);

assign inst_BL = (func_code_31_26 == `func_bl);
assign inst_BEQ = (func_code_31_26 == `func_beq);
assign inst_BNE = (func_code_31_26 == `func_bne);
assign inst_BLT = (func_code_31_26 == `func_blt);
assign inst_BGE = (func_code_31_26 == `func_bge);
assign inst_BLTU = (func_code_31_26 == `func_bltu);
assign inst_BGEU = (func_code_31_26 == `func_bgeu);
assign inst_JIRL = (func_code_31_26 == `func_jirl);

assign inst_LU12I = (func_code_31_25 == `func_lu12i);
assign inst_PCADDU12I = (func_code_31_25 == `func_pcaddu12i);

assign inst_ERTN = (func_code_31_10 == `func_ertn); 

assign inst_NOP = (data[31:0] == `func_nop);
     
assign sign_R = inst_ADD | inst_SUB | inst_SLL | inst_SRL | inst_SRA | inst_AND | inst_OR | 
inst_XOR | inst_SLT | inst_SLTU | inst_SLLI | inst_SRLI | inst_SRAI | inst_SYSCALL | inst_BREAK;
assign sign_I = inst_STW  | inst_LDW | inst_SLTUI | inst_SLTI | inst_XORI | inst_ORI | inst_ANDI | inst_ADDI;
assign sign_B = inst_JIRL | inst_BGEU |  inst_BLTU | inst_BGE | inst_BLT | inst_BNE | inst_BEQ |  inst_BL;
assign sign_U = inst_LU12I | inst_PCADDU12I;
assign sign_exception = inst_ERTN;

wire inst_valid;
wire inst_unvalid;
assign inst_valid = sign_R | sign_I | sign_B | sign_U | sign_exception | inst_NOP;
assign inst_unvalid = ~inst_valid;

//assign o_exception = inst_unvalid | inst_SYSCALL | inst_BREAK | inst_ERTN;
//assign o_index = {inst_ERTN, inst_BREAK, inst_SYSCALL, inst_unvalid};
//assign o_pc_exception = data[63:32];
// 异常号（低4位）
    wire [3:0] exc_code      = {inst_ERTN, inst_BREAK, inst_SYSCALL, inst_unvalid};
    wire       has_exception = (exc_code != 4'd0);

    // 线中断信号 & 中断号
    // 异常优先，中断次之
    wire       has_interrupt = swio_i | timer_i;
    // 如果两个同时来，优先取 Timer（int#11）
    wire [3:0] int_number    = timer_i ? 4'd11 : 4'd0;

    // 输出给 CSR
    assign o_exception      = has_exception;
    assign o_interrupt      = !has_exception && has_interrupt;
    assign o_index          = has_exception
                              ? {4'd0, exc_code}            // 异常路径：中断号=0, 异常号=exc_code
                              : has_interrupt
                                ? {int_number, 4'd0}        // 中断路径：中断号=int_number, 异常号=0
                                : 8'd0;
    assign o_pc_exception   = data[63:32];




assign o_grf_rj = data[9:5];
assign o_grf_rk = data[14:10];
assign o_grf_rd = (inst_BL ? 5'b00001 : data[4:0]);
assign o_extend_imm12 = data[21:10];
assign o_extend_ui5 = data[14:10];
assign o_extend_si20 = data[24:5];
assign o_extend_offs16 = data[25:10];
assign o_extend_offs26 = data[9:0];


wire grf_no_wen;
wire ld_sign;
assign grf_no_wen = inst_STW;// 空指令时也会有写使能，但是寄存器号是0所以不会出现问题
assign ld_sign = inst_LDW || inst_STW;


wire ui5 = inst_SLLI || inst_SRLI || inst_SRAI;
wire si12 = inst_ADDI || inst_SLTI || inst_SLTUI || inst_LDW || inst_STW;
wire ui12 = inst_ANDI || inst_ORI || inst_XORI;
wire si20 = inst_LU12I || inst_PCADDU12I;
wire offs16 = inst_BEQ || inst_BNE || inst_BLT || inst_BGE || inst_BLTU || inst_BGEU || inst_JIRL;
wire offs26 = inst_BL;
assign  o_extend_sign = {ui5 ,si12 ,ui12 ,si20 ,offs16 ,offs26};


wire rj_rk = inst_ADD || inst_SUB || inst_SLL || inst_SRL || inst_SRA || inst_AND || inst_OR || inst_XOR || inst_SLT || inst_SLTU;
wire grf_imm = inst_ADDI || inst_SLLI || inst_SRLI || inst_SRAI || inst_ANDI || inst_ORI || inst_XORI || inst_SLTI || inst_SLTUI || inst_LDW || inst_STW;
wire pc_imm = inst_PCADDU12I;
wire zero_imm = inst_LU12I;
wire rj_rd = inst_BEQ || inst_BNE || inst_BLT || inst_BGE || inst_BLTU || inst_BGEU;
wire rj_offs = inst_JIRL;
wire pc_offs = inst_BL;
wire op_and = inst_AND || inst_ANDI;
wire op_or = inst_OR || inst_ORI;
wire op_xor = inst_XOR || inst_XORI;
wire op_add = inst_ADD || inst_ADDI || inst_LDW || inst_STW || inst_LU12I || inst_PCADDU12I || inst_BL || inst_JIRL;
wire op_sub = inst_SUB;
wire op_sll = inst_SLL || inst_SLLI;
wire op_srl = inst_SRL || inst_SRLI;
wire op_sra = inst_SRA || inst_SRAI;
wire op_slt = inst_SLT || inst_SLTI || inst_BLT;
wire op_sltu = inst_SLTU || inst_SLTUI || inst_BLTU;
wire op_bge = inst_BGE;
wire op_bgeu = inst_BGEU;
wire op_e = inst_BEQ;
wire op_n = inst_BNE;
assign o_alu_opcode = {op_sltu, op_slt, op_sra, op_srl, op_sll, op_sub, op_add, op_xor, op_or, op_and};
assign o_alu_selcode = {pc_offs, rj_offs, zero_imm, pc_imm, grf_imm, rj_rk};


wire jump_sign1 = inst_BEQ || inst_BNE || inst_BLT || inst_BGE || inst_BLTU || inst_BGEU;
assign  o_prejump = {inst_BEQ, inst_BNE, inst_BLT, inst_BGE, inst_BLTU, inst_BGEU, data[63:32]};
wire jump_sign2 = inst_BL || inst_JIRL;

assign jump = jump_sign1 | dec_jump;
assign o_data = (jump | o_exception) ? 40'b0 : {jump_sign2, o_grf_rd, ~grf_no_wen, ld_sign, data[63:32]};

always @(posedge clk or negedge rst) begin
    if(!rst | jump_sign2 | o_exception) begin
        data <= 64'b0;
    end
    else begin
        if(stop) begin
            data <= data;
        end
        else begin
            data <= i_data;
        end
    end
end






endmodule
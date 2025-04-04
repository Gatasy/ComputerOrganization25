`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/06 22:21:25
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

module fullAdder(
    input cina,
    input cinb,
    input Cin,
    output S,
    output G,
    output P
);
    assign S = cina ^ cinb ^ Cin;
    assign G = cina & cinb;
    assign P = cina | cinb;
endmodule



module CLA_4bit( //calculate the carry signal
input [3:0]P,
input [3:0]G,
input cin, //external carry input  

output [4:1]CI, //internal carry input for each bit
output Pm, //each bit of the input to generate(y or n)
output Gm
);

assign CI[1] = G[0] | P[0]&cin;
assign CI[2] = G[1] | P[1]&G[0] | P[1]&P[0]&cin;
assign CI[3] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&cin;
assign CI[4] = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&cin;

assign Gm = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]);
assign Pm = P[3]&P[2]&P[1]&P[0];


endmodule


module CLA_add_4bit(
    input [3:0]ina,
    input [3:0]inb,
    input cin,
    output [3:0]SO,
    output Pm,
    output Gm
);
wire [3:0] G;   // generate carry signal
wire [3:0] P;   // procast carry signal
wire [4:1] CI;  // temporary carry in the process

fullAdder FA0(
            .cina(ina[0]),
            .cinb(inb[0]),
            .Cin(cin),
            .S(SO[0]),
            .G(G[0]),
            .P(P[0])
        );

genvar i;
generate 
    for(i = 1;i < 4;i = i+1)begin:adder_chain
        fullAdder FA(
            .cina(ina[i]),
            .cinb(inb[i]),
            .Cin(CI[i]),
            .S(SO[i]),
            .G(G[i]),
            .P(P[i])
        );
    end
endgenerate
CLA_4bit final(
    .P(P),
    .G(G),
    .cin(cin),
    .CI(CI),
    .Pm(Pm),
    .Gm(Gm)
);


endmodule


module Adder_16bit (
    input [15:0]ina,
    input [15:0]inb,
    input cin,
    output [15:0]SO,
    output Pm,
    output Gm
);

wire [3:0] G;   // generate carry signal
wire [3:0] P;   // procast carry signal
wire [4:1] CI;

CLA_add_4bit CA4_0(
            .ina(ina[3:0]),
            .inb(inb[3:0]),
            .cin(cin),
            .SO(SO[3:0]),
            .Pm(P[0]),
            .Gm(G[0])
        );
genvar i;
generate
    for (i = 4 ; i < 16 ;i = i + 4 ) begin
        CLA_add_4bit CA4(
            .ina(ina[i+3:i]),
            .inb(inb[i+3:i]),
            .cin(CI[(i/4)]),
            .SO(SO[i+3:i]),
            .Pm(P[(i/4)]),
            .Gm(G[(i/4)])
        );
    end
endgenerate
CLA_4bit final(
    .P(P),
    .G(G),
    .cin(cin),
    .CI(CI),
    .Pm(Pm),
    .Gm(Gm)
);


    
endmodule



module CLA_add_32bit(
    input [31:0] ina,
    input [31:0] inb,
    input cin,
    output [31:0] SO,  // Sum output
    output Pm,         // Propagate signal
    output Gm          // Generate signal
);

wire [3:0] G ;      // Generate signal for 32-bit CLA
wire [3:0] P ;      // Propagate signal for 32-bit CLA
wire [4:1] CI;     // Internal carry signals

Adder_16bit CLA16_0(
    .ina(ina[15:0]),
    .inb(inb[15:0]),
    .cin(cin),
    .SO(SO[15:0]),
    .Pm(P[0]),
    .Gm(G[0])
);

Adder_16bit CLA16_1(
    .ina(ina[31:16]),
    .inb(inb[31:16]),
    .cin(CI[1]),
    .SO(SO[31:16]),
    .Pm(P[1]),
    .Gm(G[1])
);
assign CI[1] = G[0] | (P[0] & cin);

assign Pm = P[0] & P[1];
assign Gm = G[1] | (P[1] & G[0]);

endmodule

// AND32.v
module AND32 (
    input [31:0] A, B,   // 输入A和B
    output [31:0] Result // 输出结果
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : and_gen
            and (Result[i], A[i], B[i]);  // 按位与操作
        end
    endgenerate
endmodule

// OR32.v
module OR32 (
    input [31:0] A, B,    // 输入A和B
    output [31:0] Result  // 输出结果
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : or_gen
            or (Result[i], A[i], B[i]);  // 按位或操作
        end
    endgenerate
endmodule

// XOR32.v
module XOR32 (
    input [31:0] A, B,    // 输入A和B
    output [31:0] Result  // 输出结果
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : xor_gen
            xor (Result[i], A[i], B[i]);  // 按位异或操作
        end
    endgenerate
endmodule

// NOT32.v
module NOT32 (
    input [31:0] A,    // 输入A
    output [31:0] Result // 输出结果
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : not_gen
            not (Result[i], A[i]);  // 按位非操作
        end
    endgenerate
endmodule

// Define the shifter32 module using gate-level logic
module shifter32(R, X, sa, shift_type);
    output [31:0] R;  
    input [31:0] X;
    input [4:0] sa;
    input [1:0] shift_type;

    wire [31:0] logical_left_shift, logical_right_shift;
    wire [31:0] circular_left_shift, circular_right_shift;

    // Logical left shift using AND gates
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : logical_left
            assign logical_left_shift[i] = (i < sa) ? 1'b0 : X[i - sa];
        end
    endgenerate

    // Logical right shift using AND gates
    generate
        for (i = 0; i < 32; i = i + 1) begin : logical_right
            assign logical_right_shift[i] = (i >= (32 - sa)) ? 1'b0 : X[i + sa];
        end
    endgenerate

    // Circular left shift using AND gates and OR gates
    generate
        for (i = 0; i < 32; i = i + 1) begin : circular_left
            assign circular_left_shift[i] = (i < sa) ? X[31 - (sa - 1 - i)] : X[i - sa];
        end
    endgenerate

    // Circular right shift using AND gates and OR gates
    generate
        for (i = 0; i < 32; i = i + 1) begin : circular_right
            assign circular_right_shift[i] = (i > (31 - sa)) ? X[i - (31 - sa + 1)] : X[i + sa];
        end
    endgenerate

    // Based on the shift_type select the corresponding shift result
    assign R = (shift_type == 2'b00) ? logical_left_shift : 
               (shift_type == 2'b01) ? logical_right_shift : 
               (shift_type == 2'b10) ? circular_left_shift : 
               circular_right_shift;

endmodule

// Truncate32.v
module Cut_decoder (
    input [4:0] bite,
    output [31:0] judge
);
///对bite按位取反
wire [4:0] Nbite;
not (Nbite[0],bite[0]);
not (Nbite[1],bite[1]);
not (Nbite[2],bite[2]);
not (Nbite[3],bite[3]);
not (Nbite[4],bite[4]);

///将bite输入译码器
wire [31:0] judge;
and (judge[0],Nbite[4],Nbite[3],Nbite[2],Nbite[1],Nbite[0]);
and (judge[1],Nbite[4],Nbite[3],Nbite[2],Nbite[1],bite[0]);
and (judge[2],Nbite[4],Nbite[3],Nbite[2],bite[1],Nbite[0]);
and (judge[3],Nbite[4],Nbite[3],Nbite[2],bite[1],bite[0]);
and (judge[4],Nbite[4],Nbite[3],bite[2],Nbite[1],Nbite[0]);
and (judge[5],Nbite[4],Nbite[3],bite[2],Nbite[1],bite[0]);
and (judge[6],Nbite[4],Nbite[3],bite[2],bite[1],Nbite[0]);
and (judge[7],Nbite[4],Nbite[3],bite[2],bite[1],bite[0]);
and (judge[8],Nbite[4],bite[3],Nbite[2],Nbite[1],Nbite[0]);
and (judge[9],Nbite[4],bite[3],Nbite[2],Nbite[1],bite[0]);
and (judge[10],Nbite[4],bite[3],Nbite[2],bite[1],Nbite[0]);
and (judge[11],Nbite[4],bite[3],Nbite[2],bite[1],bite[0]);
and (judge[12],Nbite[4],bite[3],bite[2],Nbite[1],Nbite[0]);
and (judge[13],Nbite[4],bite[3],bite[2],Nbite[1],bite[0]);
and (judge[14],Nbite[4],bite[3],bite[2],bite[1],Nbite[0]);
and (judge[15],Nbite[4],bite[3],bite[2],bite[1],bite[0]);
and (judge[16],bite[4],Nbite[3],Nbite[2],Nbite[1],Nbite[0]);
and (judge[17],bite[4],Nbite[3],Nbite[2],Nbite[1],bite[0]);
and (judge[18],bite[4],Nbite[3],Nbite[2],bite[1],Nbite[0]);
and (judge[19],bite[4],Nbite[3],Nbite[2],bite[1],bite[0]);
and (judge[20],bite[4],Nbite[3],bite[2],Nbite[1],Nbite[0]);
and (judge[21],bite[4],Nbite[3],bite[2],Nbite[1],bite[0]);
and (judge[22],bite[4],Nbite[3],bite[2],bite[1],Nbite[0]);
and (judge[23],bite[4],Nbite[3],bite[2],bite[1],bite[0]);
and (judge[24],bite[4],bite[3],Nbite[2],Nbite[1],Nbite[0]);
and (judge[25],bite[4],bite[3],Nbite[2],Nbite[1],bite[0]);
and (judge[26],bite[4],bite[3],Nbite[2],bite[1],Nbite[0]);
and (judge[27],bite[4],bite[3],Nbite[2],bite[1],bite[0]);
and (judge[28],bite[4],bite[3],bite[2],Nbite[1],Nbite[0]);
and (judge[29],bite[4],bite[3],bite[2],Nbite[1],bite[0]);
and (judge[30],bite[4],bite[3],bite[2],bite[1],Nbite[0]);
and (judge[31],bite[4],bite[3],bite[2],bite[1],bite[0]); 
endmodule
///左边b位保留，右边全置0
module CutL (
    input dir,///0
    input [31:0] a,
    input [31:0] judge,
    output  [31:0] s
);
///相或
wire [31:0] tmp;
or (tmp[31],dir,judge[31]);
or (tmp[30],tmp[31],judge[30]);
or (tmp[29],tmp[30],judge[29]);
or (tmp[28],tmp[29],judge[28]);
or (tmp[27],tmp[28],judge[27]);
or (tmp[26],tmp[27],judge[26]);
or (tmp[25],tmp[26],judge[25]);
or (tmp[24],tmp[25],judge[24]);
or (tmp[23],tmp[24],judge[23]);
or (tmp[22],tmp[23],judge[22]);
or (tmp[21],tmp[22],judge[21]);
or (tmp[20],tmp[21],judge[20]);
or (tmp[19],tmp[20],judge[19]);
or (tmp[18],tmp[19],judge[18]);
or (tmp[17],tmp[18],judge[17]);
or (tmp[16],tmp[17],judge[16]);
or (tmp[15],tmp[16],judge[15]);
or (tmp[14],tmp[15],judge[14]);
or (tmp[13],tmp[14],judge[13]);
or (tmp[12],tmp[13],judge[12]);
or (tmp[11],tmp[12],judge[11]);
or (tmp[10],tmp[11],judge[10]);
or (tmp[9],tmp[10],judge[9]);
or (tmp[8],tmp[9],judge[8]);
or (tmp[7],tmp[8],judge[7]);
or (tmp[6],tmp[7],judge[6]);
or (tmp[5],tmp[6],judge[5]);
or (tmp[4],tmp[5],judge[4]);
or (tmp[3],tmp[4],judge[3]);
or (tmp[2],tmp[3],judge[2]);
or (tmp[1],tmp[2],judge[1]);
or (tmp[0],tmp[1],judge[0]);   

//与输入按位相与，dir=0为左截取
wire in_put;
not (in_put,dir);
and (s[0],tmp[31],a[0],in_put);
and (s[1],tmp[30],a[1],in_put);
and (s[2],tmp[29],a[2],in_put);
and (s[3],tmp[28],a[3],in_put);
and (s[4],tmp[27],a[4],in_put);
and (s[5],tmp[26],a[5],in_put);
and (s[6],tmp[25],a[6],in_put);
and (s[7],tmp[24],a[7],in_put);
and (s[8],tmp[23],a[8],in_put);
and (s[9],tmp[22],a[9],in_put);
and (s[10],tmp[21],a[10],in_put);
and (s[11],tmp[20],a[11],in_put);
and (s[12],tmp[19],a[12],in_put);
and (s[13],tmp[18],a[13],in_put);
and (s[14],tmp[17],a[14],in_put);
and (s[15],tmp[16],a[15],in_put);
and (s[16],tmp[15],a[16],in_put);
and (s[17],tmp[14],a[17],in_put);
and (s[18],tmp[13],a[18],in_put);
and (s[19],tmp[12],a[19],in_put);
and (s[20],tmp[11],a[20],in_put);
and (s[21],tmp[10],a[21],in_put);
and (s[22],tmp[9],a[22],in_put);
and (s[23],tmp[8],a[23],in_put);
and (s[24],tmp[7],a[24],in_put);
and (s[25],tmp[6],a[25],in_put);
and (s[26],tmp[5],a[26],in_put);
and (s[27],tmp[4],a[27],in_put);
and (s[28],tmp[3],a[28],in_put);
and (s[29],tmp[2],a[29],in_put);
and (s[30],tmp[1],a[30],in_put);
and (s[31],tmp[0],a[31],in_put);
endmodule
///右边b位保留，左边全置0
module CutR (
    input dir,///1
    input [31:0] a,
    input [31:0] judge,
    output  [31:0] s
);
///相或
wire [31:0] tmp;
wire in_put;
not (in_put,dir);
or (tmp[31],in_put,judge[31]);
or (tmp[30],tmp[31],judge[30]);
or (tmp[29],tmp[30],judge[29]);
or (tmp[28],tmp[29],judge[28]);
or (tmp[27],tmp[28],judge[27]);
or (tmp[26],tmp[27],judge[26]);
or (tmp[25],tmp[26],judge[25]);
or (tmp[24],tmp[25],judge[24]);
or (tmp[23],tmp[24],judge[23]);
or (tmp[22],tmp[23],judge[22]);
or (tmp[21],tmp[22],judge[21]);
or (tmp[20],tmp[21],judge[20]);
or (tmp[19],tmp[20],judge[19]);
or (tmp[18],tmp[19],judge[18]);
or (tmp[17],tmp[18],judge[17]);
or (tmp[16],tmp[17],judge[16]);
or (tmp[15],tmp[16],judge[15]);
or (tmp[14],tmp[15],judge[14]);
or (tmp[13],tmp[14],judge[13]);
or (tmp[12],tmp[13],judge[12]);
or (tmp[11],tmp[12],judge[11]);
or (tmp[10],tmp[11],judge[10]);
or (tmp[9],tmp[10],judge[9]);
or (tmp[8],tmp[9],judge[8]);
or (tmp[7],tmp[8],judge[7]);
or (tmp[6],tmp[7],judge[6]);
or (tmp[5],tmp[6],judge[5]);
or (tmp[4],tmp[5],judge[4]);
or (tmp[3],tmp[4],judge[3]);
or (tmp[2],tmp[3],judge[2]);
or (tmp[1],tmp[2],judge[1]);
or (tmp[0],tmp[1],judge[0]);

///按位相与，dir=1为从右截取
and (s[31],tmp[31],a[31],dir);
and (s[30],tmp[30],a[30],dir);
and (s[29],tmp[29],a[29],dir);
and (s[28],tmp[28],a[28],dir);
and (s[27],tmp[27],a[27],dir);
and (s[26],tmp[26],a[26],dir);
and (s[25],tmp[25],a[25],dir);
and (s[24],tmp[24],a[24],dir);
and (s[23],tmp[23],a[23],dir);
and (s[22],tmp[22],a[22],dir);
and (s[21],tmp[21],a[21],dir);
and (s[20],tmp[20],a[20],dir);
and (s[19],tmp[19],a[19],dir);
and (s[18],tmp[18],a[18],dir);
and (s[17],tmp[17],a[17],dir);
and (s[16],tmp[16],a[16],dir);
and (s[15],tmp[15],a[15],dir);
and (s[14],tmp[14],a[14],dir);
and (s[13],tmp[13],a[13],dir);
and (s[12],tmp[12],a[12],dir);
and (s[11],tmp[11],a[11],dir);
and (s[10],tmp[10],a[10],dir);
and (s[9],tmp[9],a[9],dir);
and (s[8],tmp[8],a[8],dir);
and (s[7],tmp[7],a[7],dir);
and (s[6],tmp[6],a[6],dir);
and (s[5],tmp[5],a[5],dir);
and (s[4],tmp[4],a[4],dir);
and (s[3],tmp[3],a[3],dir);
and (s[2],tmp[2],a[2],dir);
and (s[1],tmp[1],a[1],dir);
and (s[0],tmp[0],a[0],dir);
endmodule

module Truncate_32bit(
    input [31:0] a,
    input dir, ///0左1右
    input [4:0] bite,
    output [31:0] s
);
///译码
wire [31:0] judge;
Cut_decoder cutd1(
    .bite(bite),
    .judge(judge)
);
///左截取调用
wire [31:0] s1;
CutL cutl1(
    .dir(dir),
    .a(a),
    .judge(judge),
    .s(s1)
);

///右截取调用
wire [31:0] s2;
CutR cutr1(
    .dir(dir),
    .a(a),
    .judge(judge),
    .s(s2)
);
///输出
or (s[0],s1[0],s2[0]);
or (s[1],s1[1],s2[1]);
or (s[2],s1[2],s2[2]);
or (s[3],s1[3],s2[3]);
or (s[4],s1[4],s2[4]);
or (s[5],s1[5],s2[5]);
or (s[6],s1[6],s2[6]);
or (s[7],s1[7],s2[7]);
or (s[8],s1[8],s2[8]);
or (s[9],s1[9],s2[9]);
or (s[10],s1[10],s2[10]);
or (s[11],s1[11],s2[11]);
or (s[12],s1[12],s2[12]);
or (s[13],s1[13],s2[13]);
or (s[14],s1[14],s2[14]);
or (s[15],s1[15],s2[15]);
or (s[16],s1[16],s2[16]);
or (s[17],s1[17],s2[17]);
or (s[18],s1[18],s2[18]);
or (s[19],s1[19],s2[19]);
or (s[20],s1[20],s2[20]);
or (s[21],s1[21],s2[21]);
or (s[22],s1[22],s2[22]);
or (s[23],s1[23],s2[23]);
or (s[24],s1[24],s2[24]);
or (s[25],s1[25],s2[25]);
or (s[26],s1[26],s2[26]);
or (s[27],s1[27],s2[27]);
or (s[28],s1[28],s2[28]);
or (s[29],s1[29],s2[29]);
or (s[30],s1[30],s2[30]);
or (s[31],s1[31],s2[31]);
endmodule
module ALU (
    input dir,
    input [31:0] A, B,           // 输入操作数A和B
    input [3:0] ALUControl,      // 控制信号，决定运算类型
    input [1:0] shift_type,
    input [4:0] TruncateLen,     // 截断长度
    output reg [31:0] Result,    // 输出结果
    output reg Cout             // 进位输出
);

    // 中间信号
    wire [31:0] Sum;             // 加法结果
    wire [31:0] AndResult;       // 按位与结果
    wire [31:0] OrResult;        // 按位或结果
    wire [31:0] XorResult;       // 按位异或结果
    wire [31:0] NotResult;       // 按位取反结果
    wire [31:0] ShiftResult;     // 移位结果
    wire [31:0] TruncateResult;  // 截断结果
    wire Pm, Gm;                 // 加法器的进位生成和传播信号

    // 实例化加法器
    CLA_add_32bit adder (
        .ina(A),
        .inb(B),
        .cin(1'b0),          // 假设无初始进位
        .SO(Sum),
        .Pm(Pm),
        .Gm(Gm)
    );

    // 实例化按位操作模块
    AND32 and_unit (
        .A(A),
        .B(B),
        .Result(AndResult)
    );

    OR32 or_unit (
        .A(A),
        .B(B),
        .Result(OrResult)
    );

    XOR32 xor_unit (
        .A(A),
        .B(B),
        .Result(XorResult)
    );

    NOT32 not_unit (
        .A(A),
        .Result(NotResult)
    );

    // 实例化移位器
    shifter32 shifter (
        .R(ShiftResult),
        .X(A),
        .sa(B[4:0]),              // 使用B的低5位作为移位量
        .shift_type(shift_type) // 根据控制信号选择移位类型
    );

    // 实例化 Truncate_32bit 模块
    Truncate_32bit truncate_instance (
        .a(A),      // 传入32位数据
        .dir(dir),  // 传入方向信号
        .bite(TruncateLen),// 传入截取的位数
        .s(TruncateResult)       // 输出截取结果
    );

    // 根据控制信号生成输出结果
    always @(*) begin
        case (ALUControl)
            4'b0000: Result = Sum;             // 加法
            4'b0001: Result = AndResult;       // 按位与
            4'b0010: Result = OrResult;        // 按位或
            4'b0011: Result = XorResult;       // 按位异或
            4'b0100: Result = NotResult;       // 按位取反
            4'b0101: Result = ShiftResult;     // 移位操作
            4'b0110: Result = TruncateResult;  // 截断操作
            default: Result = 32'b0;           // 默认输出0
        endcase
    end

    // 设置进位输出
    always @(*) begin
        case (ALUControl)
            4'b0000: Cout = Gm | (Pm & 1'b0);  // 加法进位逻辑
            default: Cout = 1'b0;              // 其他操作无进位
        endcase
    end

endmodule





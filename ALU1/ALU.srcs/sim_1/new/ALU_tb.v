`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/10 23:05:07
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb;
    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] ALUControl;
    reg [4:0] TruncateLen;
    reg dir;
    reg [1:0] shift_type; // 新增移位类型信号

    // Outputs
    wire [31:0] Result;
    wire Cout;

    // Instantiate the Unit Under Test (UUT)
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .TruncateLen(TruncateLen),
        .Result(Result),
        .Cout(Cout),
        .dir(dir),
        .shift_type(shift_type) // 修正连接
    );

    // Testbench process
    initial begin
        // Initialize inputs
        A = 0;
        B = 0;
        ALUControl = 0;
        TruncateLen = 0;
        dir = 0;
        shift_type = 2'b00; // 默认移位类型

        // Display header for simulation results
        $display("Time\tA\t\tB\t\tALUControl\tshift_type\tTruncateLen\tResult\t\tCout");

        // Monitor changes to key signals
        $monitor("%d\t%h\t%h\t%b\t\t%b\t\t%d\t\t%h\t\t%b", 
                 $time, A, B, ALUControl, shift_type, TruncateLen, Result, Cout);

        // Test 1: Addition
        #10 A = 32'h0000_000F; B = 32'h0000_0001; ALUControl = 4'b0000; // A + B
        #10 A = 32'hFFFFFFFF; B = 32'h0000_0001; ALUControl = 4'b0000; // Test overflow case

        // Test 2: Bitwise AND
        #10 A = 32'h0F0F_0F0F; B = 32'h00FF_00FF; ALUControl = 4'b0001; // A & B

        // Test 3: Bitwise OR
        #10 A = 32'h0F0F_0F0F; B = 32'h00FF_00FF; ALUControl = 4'b0010; // A | B

        // Test 4: Bitwise XOR
        #10 A = 32'h0F0F_0F0F; B = 32'h00FF_00FF; ALUControl = 4'b0011; // A ^ B

        // Test 5: Bitwise NOT
        #10 A = 32'h0F0F_0F0F; ALUControl = 4'b0100; // ~A

        // 测试 1: 逻辑左移 (shift_type = 00)
        #10 A = 32'h0000_00FF; B = 32'h0000_0008; ALUControl = 4'b1000; shift_type = 2'b00;

        // 测试 2: 逻辑右移 (shift_type = 01)
        #10 A = 32'hFF00_0000; B = 32'h0000_0004; ALUControl = 4'b1000; shift_type = 2'b01;

        // 测试 3: 循环左移 (shift_type = 10)
        #10 A = 32'h8000_0001; B = 32'h0000_0003; ALUControl = 4'b1000; shift_type = 2'b10;

        // 测试 4: 循环右移 (shift_type = 11)
        #10 A = 32'h0000_000F; B = 32'h0000_0002; ALUControl = 4'b1000; shift_type = 2'b11;

        // Test 7: Left truncation
        #10 A = 32'hFFFFFFFF; TruncateLen = 5'd16; ALUControl = 4'b0110;dir=0;// Truncate to lower 16 bits

        // Test 8: Right truncation
        #10 A = 32'hFFFFFFFF; TruncateLen = 5'd16; ALUControl = 4'b0110;dir=1;// Truncate to upper 16 bits
        

        // End simulation
        #10 $finish;
    end
endmodule


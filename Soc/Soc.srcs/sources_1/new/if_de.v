//-----------------------------------------------
//    module name: if_de
//    author: 
//  
//    version: 1st version (2023-7-17)
//    description: \u017e媚？槲欢u0152读魉咧甛u0152涞腬u0152禱u0152鋅u0152腬u017d嫫髂？?//                 
//
//
//-----------------------------------------------
`timescale 1ns / 1ps

module if_de(
    input  wire        rstn,            
    input  wire        clk,      
	input  wire 	   i_holdflag_1,
	input  wire 	   i_flushflag_1,
    input  wire [63:0] i_instAndPc_64,      
	output wire [63:0] o_instAndPc_64
);
    localparam nop64 = 64'b0;
    reg  [63:0] r_instAndPc_64;
    
    always @ (posedge clk or negedge rstn) begin
        if(!rstn) begin
            r_instAndPc_64 <= nop64;
        end 
        else begin
            if(i_flushflag_1) begin
                r_instAndPc_64 <= nop64;
            end 
            else begin
                if(i_holdflag_1 == 1'b1 ) begin
                    r_instAndPc_64 <= r_instAndPc_64;
                end
                else begin
                    r_instAndPc_64 <= i_instAndPc_64;
                end
            end
        end
    end
            
    assign o_instAndPc_64 = r_instAndPc_64;
endmodule

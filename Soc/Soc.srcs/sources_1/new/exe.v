//-----------------------------------------------
//    module name: m_exe
//    author: Wei Ren
//  
//    version: 1st version (2021-10-01)
//    description: 瀹炰緥鍖朼lu妯″潡銆佷箻娉曟ā鍧楋拷?锟介櫎娉曟ā鍧楋紝杈撳嚭鐩殑瀵勫瓨鍣ㄥ湴锟??銆丆SR鏁版嵁銆佷箻闄ゆ硶娴佹按绾挎殏鍋滀俊鍙蜂互鍙婏拷?锟藉線瀛樺偍鍣ㄧ殑鎬荤嚎鏁版嵁锟??
//                 鎬荤嚎鏁版嵁鍖呬腑鍖呮嫭瀵勫瓨鍣ㄦ暟鎹拷?锟絘lu鎿嶄綔鏁帮拷?锟紾RF鍐欎娇鑳斤拷?锟絪tore鏍囧織銆佽鍐欏搴︽爣蹇楋拷?锟借鎸囦护绗﹀彿銆佹墽琛屾ā鍧楃粨鏋滐拷?锟絣oad鏍囧織銆丆SR鎸囦护鏍囧織
//
//
//-----------------------------------------------
`timescale 1ns / 1ps
`include "./riscv.h"
module m_exe(                                // 鎵ц妯″潡
    input  wire         clk,                 // 鏃堕挓
    input  wire         rstn,                // 閲嶇疆    
    input  wire [189:0] i_DecoderExeBus_190, // ID->EXE鎬荤嚎
    output wire [138:0] o_ExeLsuBus_139,     // EXE->MEM鎬荤嚎
    output wire         o_csrWen_1,
	output wire  [ 4:0] o_rdAddr_5,
	output wire [ 31:0] o_csrWdata_32,
    output wire         o_muldivHold_1,      // 涔橀櫎娉曟祦姘寸嚎鏆傚 
    output wire [31:0]  o_exeResult_32   
);
//-----{IDEXE鎬荤嚎}begin

    //EXE锟??瑕佺敤鍒扮殑淇℃伅
    wire        w_mulLow_1;                        // 涔樻硶浣庝綅
    wire        w_mulHigh_1;                       // 涔樻硶楂樹綅
    wire        w_quo_1;                           // 闄ゆ硶
    wire        w_remainder_1;                     // 鍙栦綑
    wire [ 4:0] w_rdValue_5;                       // 浠巇ecoder杈撳叆鐨勭洰鐨勫瘎瀛樺櫒鍦板潃
    wire        w_load_1;                          // 璇绘寚锟??
    wire        w_store_1;                         // 鍐欐寚锟??
    wire        w_loadSign_1;                      // 璇绘寚浠ょ锟??
    wire [ 1:0] w_loadStoreWidth_2;                // 璇诲啓瀛楅暱
    wire        w_CSRTYpe_1;                       // CSR鎸囦护
    wire [11:0] w_csrAddr_12;                      // CSR鍦板潃
    wire [ 1:0] w_mulDivSign_2;                    // 涔橀櫎娉曠鍙锋儏锟??
    wire [10:0] w_aluControl_11;                   // ALU鎺у埗鎬荤嚎
    wire [31:0] w_aluOperand1_32;                  // ALU鎿嶄綔锟??1
    wire [31:0] w_aluOperand2_32;                  // ALU鎿嶄綔锟??2
    wire        w_MulDiv_1;
	wire        w_grfWen_1;
	wire [31:0] w_storeData_32;  
	wire [31:0]  w_PC_32;
	wire [31:0]  w_inst_32;
    assign  {
			w_storeData_32,//rs2
			w_grfWen_1,
            w_aluControl_11,
            w_aluOperand1_32,
            w_aluOperand2_32,
            w_mulLow_1,
            w_mulHigh_1,
            w_quo_1,
            w_remainder_1,
            w_mulDivSign_2,
            w_rdValue_5,
            w_load_1,
            w_store_1,
            w_loadSign_1,
            w_loadStoreWidth_2,
            w_CSRTYpe_1,
            w_MulDiv_1,
            w_PC_32,
            w_inst_32 }   = i_DecoderExeBus_190;

//-----{ID->EXE鎬荤嚎}end

//-----{ALU}begin

    wire [31:0] w_aluResult_32;                  // alu杈撳嚭

    m_alu alu(
        .i_aluControl_11    (w_aluControl_11),   // ALU鎺у埗淇″彿
        .i_aluOperand1_32   (w_aluOperand1_32),  // ALU鎿嶄綔锟??1
        .i_aluOperand2_32   (w_aluOperand2_32),  // ALU鎿嶄綔锟??2
        .o_aluResult_32     (w_aluResult_32)     // ALU缁撴灉
    );

//-----{ALU}end

//-----{涔樻硶鍣▆begin

    wire        w_mulBegin_1;                           // 涔樻硶锟??濮嬩俊锟??
    wire [63:0] w_product_64;                           // 涔樼Н
    wire        w_mulWorking_1;                         // 涔樻硶宸ヤ綔淇″彿
    wire        w_mulEnd_1;                             // 涔樻硶缁撴潫淇″彿
    wire        mul_sign,div_sign;
    
    assign   mul_sign = w_mulDivSign_2[1];
    assign   div_sign = w_mulDivSign_2[0];
    assign w_mulBegin_1 =  w_mulLow_1  | w_mulHigh_1;   // 涔樻硶锟??濮嬩俊鍙风敓锟??
    
    mul multiply(
        .clk       (clk),               // 鏃堕挓
        .rst       (rstn),
       .mul_start  (w_mulBegin_1),      // 涔樻硶锟??濮嬩俊锟??
        .mul_sign  (mul_sign),          // 涔樻硶鎿嶄綔锟??1
        .i_mulNum1 (w_aluOperand1_32),  // 涔樻硶鎿嶄綔锟??2    w_mulDivSign_2
        .i_mulNum2 (w_aluOperand2_32),  // 涔樻硶绗﹀彿
        .o_mulNum  (w_product_64),      // 涔樼Н
        .mul_end   (w_mulEnd_1)         // 涔樻硶缁撴潫淇″彿
    );
    
    assign w_mulWorking_1 = w_mulEnd_1;
//-----{涔樻硶鍣▆end

//-----{闄ゆ硶鍣▆begin

    wire        w_divBegin_1;                           // 闄ゆ硶锟??濮嬩俊锟??
    wire [31:0] w_quotient_32;                          // 锟??
    wire [31:0] w_remainder_32;                         // 浣欐暟
    wire        w_divWorking_1;                         // 闄ゆ硶宸ヤ綔淇″彿
    wire        w_divEnd_1;                             // 闄ゆ硶缁撴潫淇″彿

    assign w_divBegin_1 =   w_quo_1 | w_remainder_1;    // 闄ゆ硶锟??濮嬩俊鍙风敓锟??
    
    div_radix16 division (
        .clk                (clk                ),      // 鏃堕挓
        .rst                (rstn               ),
        .en                 (w_divBegin_1       ),      // 闄ゆ硶锟??濮嬩俊锟??
        .signed_div         (div_sign           ),      // 闄ゆ硶绗﹀彿
        .i_dividend         (w_aluOperand1_32   ),      // 琚櫎锟??
        .i_divisor          (w_aluOperand2_32   ),      // 闄ゆ暟
        .quotient           (w_quotient_32      ),      // 锟??
        .remainder          (w_remainder_32     ),      // 浣欐暟
        .done               (w_divEnd_1         ),      // 闄ゆ硶缁撴潫淇″彿
        .busy               (w_divWorking_1     )     // 闄ゆ硶宸ヤ綔淇″彿
    );
    
		assign o_muldivHold_1 = w_MulDiv_1 & (~(w_divEnd_1 & w_mulEnd_1));

//-----{EXE妯″潡鐨刣est鍊紏begin
   //鍙湁鍦‥XE妯″潡鏈夋晥鏃讹紝鍏跺啓鍥炵洰鐨勫瘎瀛樺櫒鍙锋墠鏈夋剰锟??
    wire [4:0] w_rdAddr_5;

    assign w_rdAddr_5      = w_rdValue_5   & {5{ w_divEnd_1}};

//-----{EXE妯″潡鐨刣est鍊紏end

//-----{EXE->MEM鎬荤嚎}begin

    wire [31:0] w_exeResult_32;     // exe妯″潡锟??缁堣緭锟??

    assign w_exeResult_32   = {{32{w_mulHigh_1                      }}  & w_product_64[63:32]   }
                            | {{32{w_mulLow_1                       }}  & w_product_64[31: 0]   }
                            | {{32{w_quo_1                          }}  & w_quotient_32         }
                            | {{32{w_remainder_1                    }}  & w_remainder_32        }
                            | {{32{|w_aluControl_11                 }}  & w_aluResult_32        };                            
     assign o_exeResult_32   =  w_CSRTYpe_1 ? w_storeData_32 : w_exeResult_32;                          ////////////////////////////改过
    assign o_ExeLsuBus_139   = {
                                w_load_1,
                                w_store_1,
                                w_loadSign_1,
								w_grfWen_1,
                                w_loadStoreWidth_2,
                                w_exeResult_32,
								w_storeData_32,//rs2
                                w_rdValue_5,
                                w_PC_32,
                                w_inst_32
							  };

//-----{EXE->MEM鎬荤嚎}end

	assign o_csrWen_1     = w_CSRTYpe_1;
	assign o_rdAddr_5     = w_rdAddr_5;
	assign o_csrWdata_32  = {32{w_CSRTYpe_1}} & w_exeResult_32;
	
endmodule

//寰楀仛涓瘎瀛樺櫒锛屽湪鍋氫箻闄ゆ硶鐨勬椂鍊欐妸闈炲綋鍓嶈姹傜殑缁撴灉瀛樿捣鏉ワ紝濡傛灉涓嬩竴鏉℃寚浠ゆ槸閭ｄ釜鐨勮姹傜殑璇濓紝鐩存帴閫佸嚭缁撴灉骞跺惎鍔拷??

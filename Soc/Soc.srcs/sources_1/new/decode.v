//-----------------------------------------------
//    module name: m_decode
//    author: TanYuan WeiRen
//  
//    version: 1st version (2021-10-01)
//   
//-----------------------------------------------
`timescale 1ns / 1ps
`include "./riscv.h"
module m_decode(                      // 璇戠爜锟????
	input  wire [63:0]  i_PcAndinstr_64,
	input  wire [63:0]  i_grfToId_64,
    input  wire [31:0]  i_csrValue_32,	    
    output wire [ 4:0]  o_rs1Addr_5,
    output wire [ 4:0]  o_rs2Addr_5,
    output wire [11:0]  o_csrAddr_12,
    output wire [31:0]  w_inst_32,
    output wire [189:0] o_DecoderExeBus_190,
    output wire         o_IllegalInsSecond_1,
    output wire [18:0]  o_secondtohazard_19
);
//-----{淇″彿鎵撳寘}begin
	wire [31:0]  w_PC_32;
	wire [31:0]  w_rs1Value_32;
	wire [31:0]  w_rs2Value_32;
	
	assign {
			w_PC_32,
			w_inst_32 } = i_PcAndinstr_64;
	assign {
			w_rs1Value_32,
			w_rs2Value_32 } = i_grfToId_64;		
//-----{淇″彿鎵撳寘}end
//-----{鎸囦护鍒楄〃}begin
    // RV32鎸囦护鍒嗗尯
    wire [ 6:0] w_opcode_7;     // opcode鍖哄煙
    wire [ 4:0] w_rd_5;         // rd鍖哄煙
    wire [ 4:0] w_rs1_5;        // rs1鍖哄煙
    wire [ 4:0] w_rs2_5;        // rs2鍖哄煙
    wire [ 2:0] w_funct_3;      // funct3鍖哄煙
    wire [ 6:0] w_funct_7;      // funct3鍖哄煙
    wire [11:0] w_imm_12;       // imm12鍖哄煙
    wire [ 6:0] w_imm_7;        // imm7鍖哄煙
    wire [ 4:0] w_imm_5;        // imm5鍖哄煙
    wire [19:0] w_imm_20;       // imm20鍖哄煙
    wire [11:0] w_csrAddr_12;   // csr鍦板潃鍖哄煙
    wire [ 4:0] w_csrImm_5;     // csr绔嬪嵆鏁板尯锟????

    assign w_opcode_7   = w_inst_32[ 6: 0];
    assign w_rd_5       = w_inst_32[11: 7];
    assign w_rs1_5      = w_inst_32[19:15];
    assign w_rs2_5      = w_inst_32[24:20];
    assign w_funct_3    = w_inst_32[14:12];
    assign w_funct_7    = w_inst_32[31:25];
    assign w_imm_12     = w_inst_32[31:20];
    assign w_imm_7      = w_inst_32[31:25];
    assign w_imm_5      = w_inst_32[11:7 ];
    assign w_imm_20     = w_inst_32[31:12];
    assign w_csrImm_5   = w_inst_32[19:15];
    assign w_csrAddr_12 = w_inst_32[31:20];
    assign o_rs1Addr_5 =  w_rs1_5;
    assign o_rs2Addr_5 = w_rs2_5 ;
    
    // RV32I鎸囦护鍒楄〃
    wire w_instLUI_1    , w_instAUIPC_1;
    wire w_instLB_1     , w_instLH_1    , w_instLW_1    , w_instLBU_1 ;
    wire w_instLHU_1    , w_instSB_1    , w_instSH_1    , w_instSW_1  ;
    wire w_instADDI_1   , w_instSLTI_1  , w_instSLTIU_1 , w_instXORI_1;
    wire w_instORI_1    , w_instANDI_1  , w_instSLLI_1  , w_instSRLI_1;
    wire w_instSRAI_1   , w_instADD_1   , w_instSUB_1   , w_instSLL_1 ;
    wire w_instSLT_1    , w_instSLTU_1  , w_instXOR_1   , w_instSRL_1 ;
    wire w_instSRA_1    , w_instOR_1    , w_instAND_1   ;
    wire w_instJAL_1    , w_instJALR_1  ;
    // RV32M鎸囦护鍒楄〃
    wire w_instMUL_1 , w_instMULH_1 , w_instMULHSU_1, w_instMULHU_1;
    wire w_instDIV_1 , w_instDIVU_1 , w_instREM_1   , w_instREMU_1;
    // RV32Zicsr鎸囦护鍒楄〃
    wire w_instCSRRW_1  , w_instCSRRS_1 , w_instCSRRC_1 , w_intsCSRRWI_1
        ,w_instCSRRSI_1 , w_instCSRRCI_1;
//-----{鎸囦护鍒楄〃}end

//-----{鎸囦护璇戠爜}begin
    // RV32I鎸囦护璇戠爜(ALU鎿嶄綔)
    assign w_instADD_1      = (w_funct_3 == `FUNCT3_ADD  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instSUB_1      = (w_funct_3 == `FUNCT3_SUB  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0100000);
    assign w_instSLL_1      = (w_funct_3 == `FUNCT3_SLL  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instSLT_1      = (w_funct_3 == `FUNCT3_SLT  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instSLTU_1     = (w_funct_3 == `FUNCT3_SLTU ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instXOR_1      = (w_funct_3 == `FUNCT3_XOR  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instSRL_1      = (w_funct_3 == `FUNCT3_SRL  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instSRA_1      = (w_funct_3 == `FUNCT3_SRA  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0100000);
    assign w_instOR_1       = (w_funct_3 == `FUNCT3_OR   ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instAND_1      = (w_funct_3 == `FUNCT3_AND  ) & (w_opcode_7 == `OP_OP    ) & (w_funct_7 == 7'b0000000);
    assign w_instADDI_1     = (w_funct_3 == `FUNCT3_ADDI)  & (w_opcode_7 == `OP_OP_IMM);
    assign w_instSLTI_1     = (w_funct_3 == `FUNCT3_SLTI)  & (w_opcode_7 == `OP_OP_IMM);
    assign w_instSLTIU_1    = (w_funct_3 == `FUNCT3_SLTIU) & (w_opcode_7 == `OP_OP_IMM);
    assign w_instXORI_1     = (w_funct_3 == `FUNCT3_XORI ) & (w_opcode_7 == `OP_OP_IMM);
    assign w_instORI_1      = (w_funct_3 == `FUNCT3_ORI  ) & (w_opcode_7 == `OP_OP_IMM);
    assign w_instANDI_1     = (w_funct_3 == `FUNCT3_ANDI ) & (w_opcode_7 == `OP_OP_IMM);
    assign w_instSLLI_1     = (w_funct_3 == `FUNCT3_SLLI ) & (w_opcode_7 == `OP_OP_IMM) & (w_funct_7 == 7'b0000000);
    assign w_instSRLI_1     = (w_funct_3 == `FUNCT3_SRLI ) & (w_opcode_7 == `OP_OP_IMM) & (w_funct_7 == 7'b0000000);
    assign w_instSRAI_1     = (w_funct_3 == `FUNCT3_SRAI ) & (w_opcode_7 == `OP_OP_IMM) & (w_funct_7 == 7'b0100000); 
    // RV32I鎸囦护璇戠爜(Load Store鎸囦护)
    assign w_instLB_1       = (w_funct_3 == `FUNCT3_LB )   & (w_opcode_7 == `OP_LOAD);
    assign w_instLH_1       = (w_funct_3 == `FUNCT3_LH )   & (w_opcode_7 == `OP_LOAD);
    assign w_instLW_1       = (w_funct_3 == `FUNCT3_LW )   & (w_opcode_7 == `OP_LOAD);
    assign w_instLBU_1      = (w_funct_3 == `FUNCT3_LBU)   & (w_opcode_7 == `OP_LOAD);
    assign w_instLHU_1      = (w_funct_3 == `FUNCT3_LHU)   & (w_opcode_7 == `OP_LOAD);
    // RV32I鎸囦护璇戠爜(LUI鍜孉UIPC)
    assign w_instLUI_1      = (w_opcode_7 == 7'b0110111);
    assign w_instAUIPC_1    = (w_opcode_7 == 7'b0010111);
    assign w_instSB_1       = (w_funct_3 == `FUNCT3_SB )   & (w_opcode_7 == `OP_STORE);
    assign w_instSH_1       = (w_funct_3 == `FUNCT3_SH )   & (w_opcode_7 == `OP_STORE);
    assign w_instSW_1       = (w_funct_3 == `FUNCT3_SW )   & (w_opcode_7 == `OP_STORE);
        // RV32I鎸囦护璇戠爜(璺宠浆鎸囦护)
    assign w_instJAL_1      = (w_opcode_7 == `OP_JAL);
    assign w_instJALR_1     = (w_opcode_7 == `OP_JALR);
    // RV32M鎸囦护璇戠爜
    assign w_instMUL_1      = (w_funct_3 == `FUNCT3_MUL   ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instMULH_1     = (w_funct_3 == `FUNCT3_MULH  ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instMULHSU_1   = (w_funct_3 == `FUNCT3_MULHSU) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instMULHU_1    = (w_funct_3 == `FUNCT3_MULHU ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instDIV_1      = (w_funct_3 == `FUNCT3_DIV   ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instDIVU_1     = (w_funct_3 == `FUNCT3_DIVU  ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instREM_1      = (w_funct_3 == `FUNCT3_REM   ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    assign w_instREMU_1     = (w_funct_3 == `FUNCT3_REMU  ) & (w_opcode_7 == `OP_OP) & (w_funct_7 == `FUNCT7_RV32M);
    // RV32Zicsr鎸囦护璇戠爜
    assign w_instCSRRW_1    = (w_funct_3 == `FUNCT3_CSRRW ) & (w_opcode_7 == `OP_SYSTEM);
    assign w_instCSRRS_1    = (w_funct_3 == `FUNCT3_CSRRS ) & (w_opcode_7 == `OP_SYSTEM);
    assign w_instCSRRC_1    = (w_funct_3 == `FUNCT3_CSRRC ) & (w_opcode_7 == `OP_SYSTEM);
    assign w_intsCSRRWI_1   = (w_funct_3 == `FUNCT3_CSRRWI) & (w_opcode_7 == `OP_SYSTEM);
    assign w_instCSRRSI_1   = (w_funct_3 == `FUNCT3_CSRRSI) & (w_opcode_7 == `OP_SYSTEM);
    assign w_instCSRRCI_1   = (w_funct_3 == `FUNCT3_CSRRCI) & (w_opcode_7 == `OP_SYSTEM);
//-----{鎸囦护璇戠爜}end

    assign o_IllegalInsSecond_1 = ~( w_instADD_1 | w_instSUB_1 | w_instSLL_1 | w_instSLT_1 | w_instSLTU_1 | w_instXOR_1 
                                 | w_instSRL_1 | w_instSRA_1 | w_instOR_1  | w_instAND_1 
                                 | w_instADDI_1 | w_instSLTI_1 | w_instSLTIU_1 | w_instXORI_1 | w_instORI_1 | w_instANDI_1 
                                 | w_instSLLI_1 | w_instSRLI_1 | w_instSRAI_1 
                                 | w_instLB_1 |  w_instLH_1 | w_instLW_1 | w_instLBU_1 | w_instLHU_1 
                                 | w_instLUI_1 | w_instAUIPC_1 | w_instSB_1 | w_instSH_1 | w_instSW_1 
                                 | w_instJAL_1 | w_instJALR_1 
                                 | w_instMUL_1 | w_instMULH_1 | w_instMULHSU_1 | w_instMULHU_1 | w_instDIV_1 
                                 | w_instDIVU_1 | w_instREM_1 | w_instREMU_1 
                                 | w_instCSRRW_1 | w_instCSRRS_1 | w_instCSRRC_1 | w_intsCSRRWI_1 | w_instCSRRSI_1 | w_instCSRRCI_1 
                                 | (w_inst_32 == `nop));
//-----{鎸囦护鍒嗙被}begin

    // ALU 鎿嶄綔鍒嗙被
    wire w_add_1, w_sub_1, w_slt_1, w_sltu_1;
    wire w_and_1, w_or_1 , w_xor_1, w_sll_1 ;
    wire w_srl_1, w_sra_1, w_lui_1          ;

    assign w_add_1 =  w_instADDI_1  | w_instADD_1   | w_instLB_1            // 鍔犳硶
                    | w_instLH_1    | w_instLW_1    | w_instLBU_1
                    | w_instLHU_1   | w_instSB_1    | w_instSH_1
                    | w_instSW_1    | w_instAUIPC_1 | w_instJAL_1
                    | w_instJALR_1   ;
    assign w_sub_1  = w_instSUB_1                 ;                         // 鍑忔硶
    assign w_slt_1  = w_instSLT_1   | w_instSLTI_1 ;                        // 鏈夌鍙峰皬浜庣疆锟????
    assign w_sltu_1 = w_instSLTU_1  | w_instSLTIU_1;                        // 鏃犵鍙峰皬浜庣疆锟????
    assign w_and_1  = w_instAND_1   | w_instANDI_1
                    | w_instCSRRC_1 | w_instCSRRCI_1;                       // 閫昏緫锟????
    assign w_or_1   = w_instOR_1    | w_instORI_1
                    | w_instCSRRS_1 | w_instCSRRSI_1    ;                   // 閫昏緫锟????
    assign w_xor_1  = w_instXOR_1   | w_instXORI_1 ;                        // 閫昏緫寮傛垨
    assign w_sll_1  = w_instSLL_1   | w_instSLLI_1 ;                        // 閫昏緫宸︾Щ
    assign w_srl_1  = w_instSRL_1   | w_instSRLI_1 ;                        // 閫昏緫鍙崇Щ
    assign w_sra_1  = w_instSRA_1   | w_instSRAI_1 ;                        // 绠楁湳鍙崇Щ
    assign w_lui_1  = w_instLUI_1   | w_instCSRRW_1 | w_intsCSRRWI_1;       // 楂樹綅鍔犺浇

    // 鏍规嵁鎸囦护绫诲瀷杩涜鍒嗙被
    wire w_RType_1;     // R-type
    wire w_IType_1;     // I-type
    wire w_SType_1;     // S-type
    wire w_UType_1;     // U-type
    wire w_CSRType_1;   // CSR鎸囦护
    wire w_JType_1;     // J-type
    wire w_RV32M_1;
    
    assign w_RV32M_1        =  w_instMUL_1  | w_instMULH_1  
                            | w_instMULHSU_1| w_instMULHU_1 | w_instDIV_1   
                            | w_instDIVU_1  | w_instREM_1   | w_instREMU_1 ; //fix bug
    assign w_RType_1        = w_instADD_1   | w_instSUB_1
                            | w_instSLL_1   | w_instSLT_1   | w_instSLTU_1
                            | w_instXOR_1   | w_instSRL_1   | w_instSRA_1
                            | w_instOR_1    | w_instAND_1   | w_RV32M_1;
    assign w_IType_1        = w_instLB_1    | w_instLH_1    | w_instLW_1
                            | w_instLBU_1   | w_instLHU_1   | w_instADDI_1
                            | w_instSLTI_1  | w_instSLTIU_1 | w_instXORI_1
                            | w_instORI_1   | w_instANDI_1  | w_instSLLI_1
                            | w_instSRLI_1  | w_instSRAI_1;
    assign w_SType_1        = w_instSB_1    | w_instSH_1    | w_instSW_1;
    assign w_UType_1        = w_lui_1       | w_instAUIPC_1 ;
    assign w_JType_1        = w_instJAL_1   | w_instJALR_1  ;
    assign w_CSRType_1      = w_instCSRRC_1 |w_instCSRRCI_1 | w_instCSRRW_1
                            | w_intsCSRRWI_1|w_instCSRRS_1  | w_instCSRRSI_1;  
                                                                           
    // 鏍规嵁鎸囦护缁勬垚杩涜鍒嗙被
    wire w_rs1Exist_1;      // rs1瀛樺湪
    wire w_rs2Exist_1;      // rs2瀛樺湪
    wire w_rdExist_1;       // rd瀛樺湪
    wire w_immExist_1;      // imm瀛樺湪

    assign w_rs1Exist_1    = w_RType_1  | w_IType_1  | w_SType_1;
    assign w_rs2Exist_1    = w_RType_1;
    assign w_rdExist_1     = w_RType_1  | w_IType_1  | w_UType_1 | w_JType_1 |w_CSRType_1;
    assign w_immExist_1    = w_IType_1  | w_SType_1  | w_UType_1 | w_JType_1;
    
    wire w_rs1use_1,w_rs2use_1,w_rduse_1;
    
    assign w_rs1use_1 = ~(o_IllegalInsSecond_1 | w_instLUI_1 | w_instAUIPC_1 | w_JType_1 );
    assign w_rs2use_1 =  w_RType_1 | w_SType_1;
    assign w_rduse_1  =  w_RType_1 | w_IType_1 | w_UType_1 | w_CSRType_1 | w_JType_1 ;
    
    // 涔橀櫎娉曠浉鍏冲垎锟????
    wire        w_mulquorem;
    wire        w_mulLow_1;             // 浣庝綅涔樼Н
    wire        w_mulHigh_1;            // 楂樹綅涔樼Н
    wire        w_quo_1;                // 姹傚晢
    wire        w_remainder_1;          // 鍙栦綑

    assign w_mulLow_1       = w_instMUL_1;
    assign w_mulHigh_1      = w_instMULH_1  | w_instMULHU_1 | w_instMULHSU_1;
    assign w_quo_1          = w_instDIV_1   | w_instDIVU_1;
    assign w_remainder_1    = w_instREM_1   | w_instREMU_1;
    assign w_mulquorem = w_mulLow_1 | w_mulHigh_1 | w_quo_1 | w_remainder_1; //lzc
    
    // LoadStore鐩稿叧鍒嗙被
    wire [ 1:0] w_loadStoreWidth_2;     // 璇诲啓瀹藉害鏍囧織
    wire        w_load_1 ;              // 璇绘寚锟????
    wire        w_store_1;              // 鍐欐寚锟????
    wire        w_loadSign_1;           // Load鎷撳睍鏂瑰紡
    wire        w_widthB_1;             // 瀛楄妭璇诲啓
    wire        w_widthH_1;             // 鍗婂瓧璇诲啓
    wire        w_widthW_1;             // 瀛楅暱璇诲啓

    assign w_load_1         = w_instLB_1 | w_instLH_1 | w_instLW_1 | w_instLBU_1 | w_instLHU_1;
    assign w_store_1        = w_instSB_1 | w_instSH_1 | w_instSW_1 ;
    assign w_loadSign_1     = ~(w_instLBU_1 | w_instLHU_1);
    assign w_widthB_1       = w_instLB_1 | w_instLBU_1 | w_instSB_1;
    assign w_widthH_1       = w_instLH_1 | w_instLHU_1 | w_instSH_1;
    assign w_widthW_1       = w_instLW_1 | w_instSW_1;
    assign w_loadStoreWidth_2   = {{2{w_widthB_1}} & 2'b01}
                                | {{2{w_widthH_1}} & 2'b10}
                                | {{2{w_widthW_1}} & 2'b11};
    // 鍏朵粬鍒嗙被
    wire w_operand1PC_1;    // 绗竴鎿嶄綔鏁颁负PC鐨勬寚锟????

    assign w_operand1PC_1   = w_JType_1 | w_instAUIPC_1;
//-----{鎸囦护鍒嗙被}end

//-----{杈撳嚭淇″彿鐢熸垚}begin
    // ALU涓や釜婧愭搷浣滄暟鍜屾帶鍒朵俊锟????
    wire [ 1:0] w_mulDivSign_2;         // 涔橀櫎娉曠鍙锋爣锟????
    wire [ 4:0] w_rdValue_5;            // 鐩殑瀵勫瓨鍣ㄥ湴锟????
    wire [31:0] w_imm_32;               // 绔嬪嵆锟????
    wire [31:0] w_csrOper2_32;          // csr鎸囦护鎿嶄綔锟????2
    wire [10:0] w_aluControl_11;        // alu鎺у埗
    wire [31:0] w_aluOperand1_32;       // alu鎿嶄綔锟????1
    wire [31:0] w_aluOperand2_32;       // alu鎿嶄綔锟????2
	wire 		w_grfWen_1;

    assign w_mulDivSign_2       = {{2{w_instMULH_1   }} & 2'b10}
                                | {{2{w_instMULHU_1  }} & 2'b00}
                                | {{2{w_instMULHSU_1 }} & 2'b00}
                                | {{2{w_instMUL_1    }} & 2'b10}
                                | {{2{w_instDIV_1    }} & 2'b01}
                                | {{2{w_instDIVU_1   }} & 2'b00}
                                | {{2{w_instREM_1    }} & 2'b01}
                                | {{2{w_instREMU_1   }} & 2'b00};
    assign w_rdValue_5          = {{5{w_rdExist_1}} & w_rd_5};
    assign w_csrOper2_32        = {{32{w_instCSRRW_1 | w_instCSRRS_1}} & w_rs1Value_32  }
                                | {{32{w_instCSRRC_1                }} & ~w_rs1Value_32 }
                                | {{32{w_intsCSRRWI_1|w_instCSRRSI_1}} & {27'b0,w_rs1_5}}
                                | {{32{w_instCSRRCI_1               }} &~{27'b0,w_rs1_5}};
    assign w_aluControl_11       = {w_add_1 ,        // ALU鎿嶄綔鐮侊紝鐙儹缂栫爜
                                    w_sub_1 ,
                                    w_slt_1 ,
                                    w_sltu_1,
                                    w_and_1 ,
                                    w_or_1  ,
                                    w_xor_1 ,
                                    w_sll_1 ,
                                    w_srl_1 ,
                                    w_sra_1 ,
                                    w_lui_1  };
    assign w_aluOperand1_32     = {{32{ w_operand1PC_1  }} &  w_PC_32   }
                                | {{32{ w_CSRType_1     }} &  w_csrOper2_32 }
                                | {{32{~(w_operand1PC_1 | w_CSRType_1)     }} &  w_rs1Value_32 };
    assign w_aluOperand2_32     = {{32{ w_rs2Exist_1    }} &  w_rs2Value_32 }
                                | {{32{ w_immExist_1    }} &  w_imm_32       }
                                | {{32{ w_CSRType_1     }} &  i_csrValue_32 };
    assign w_imm_32             = {{32{w_IType_1    }} & {{20{w_inst_32[31]}},  w_imm_12            }}
                                | {{32{w_SType_1    }} & {{20{w_inst_32[31]}}, {w_imm_7, w_imm_5   }}}
                                | {{32{w_instLUI_1  }} & {    w_imm_20, 12'd0                       }}
                                | {{32{w_instAUIPC_1}} & {    w_imm_20, 12'd0                       }}
								| {{32{w_JType_1    }} & {    32'd4									}};                             
    assign w_grfWen_1           = w_RType_1  | w_UType_1 | w_JType_1 | w_instADDI_1
								| w_instSLTI_1  | w_instSLTIU_1 | w_instXORI_1
								| w_instORI_1   | w_instANDI_1  | w_instSLLI_1
								| w_instSRLI_1  | w_instSRAI_1 | w_CSRType_1 | w_load_1;     //////////////////////////////
								
    wire [31:0] o_sbhjs_32;
    
    assign o_sbhjs_32           = w_CSRType_1 ?  i_csrValue_32 : w_rs2Value_32 ;  
    assign o_DecoderExeBus_190  = {
									o_sbhjs_32,//jump
									w_grfWen_1,//wb
                                    w_aluControl_11,//alu
                                    w_aluOperand1_32,
                                    w_aluOperand2_32,//alu
                                    w_mulLow_1,//*/
                                    w_mulHigh_1,
                                    w_quo_1,
                                    w_remainder_1,//*/
                                    w_mulDivSign_2,//*/绗﹀彿
                                    w_rdValue_5,//wb
                                    w_load_1,////load store
                                    w_store_1,
                                    w_loadSign_1,
                                    w_loadStoreWidth_2,////load store
                                    w_CSRType_1,//csr
                                    w_mulquorem,//*/
                                    w_PC_32,
                                    w_inst_32
                                                    };
	assign   o_secondtohazard_19 = { w_rs1_5 ,
	                                 w_rs2_5 ,
	                                 w_rs1use_1,
	                                 w_rs2use_1,
	                                 w_rd_5  ,
	                                 w_rduse_1 ,
	                                 w_load_1
	                                 };	                                	                                
    assign o_csrAddr_12   = {12{w_CSRType_1}} & w_csrAddr_12;
//-----{杈撳嚭淇″彿鐢熸垚}end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/17 08:46:08
// Design Name: 
// Module Name: Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  该模块对上一周期锁存的 IF_ID_bus 数据进行解码，包括提取 opcode、rd、rs1、rs2、imm 等，并生成 inst_type
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module Decoder(
    input        clk,
    input        rst,
    input        ID_valid,    // 译码级有效信号
    input  [63:0]IF_ID_bus_r, // IF->ID总线，由顶层锁存，包含 {pc, inst}
    input  [31:0] rs1_value,   // 第一源操作数值
    input  [31:0] rs2_value,   // 第二源操作数值
    input  [2:0]  state,       // 状态机状态
    output [4:0]  rs1,         // 第一源操作数地址 
    output [4:0]  rs2,         // 第二源操作数地址
    output [4:0]  rd,          // 目的寄存器地址
    output reg [31:0] jbr_bus,   // 跳转总线
    output reg        branch,    // 分支指令标志
    output            inst_load,
    output       ID_ready,     // ID模块是否准备就绪
    output reg [148:0] ID_EXE_bus// ID->EXE总线
  //  output reg [3:0] inst_type   // 指令类型
    );
    
    localparam DECODE = 3'b010;
    // ID状态判断
    assign ID_ready = (state == DECODE) & ID_valid & !rst;
    
    //--------------------------------------------------------------------------
    // 内部流水线寄存器，用于锁存上一周期的IF_ID_bus数据（格式：{pc, inst}）
    reg [31:0] pc_reg;
    reg [31:0] inst_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_reg   <= 32'b0;
            inst_reg <= 32'b0;
        end
        else if (ID_valid) begin
            {pc_reg, inst_reg} <= IF_ID_bus_r;
        end
    end
    //--------------------------------------------------------------------------
    
    //----- 指令译码 begin -----
    // 提取指令各字段，全部基于锁存后的 inst_reg
    wire [6:0] opcode;   // 操作码
    wire [2:0] func3;    // 功能码
    wire [6:0] func7;    // R型功能码
    wire [31:0] imm;     // 立即数
    wire [4:0] sa;       // 移位位数
    
    assign opcode = inst_reg[6:0];      // 固定[6:0]为操作码
    assign rd     = inst_reg[11:7];       // 目标寄存器地址
    assign func3  = inst_reg[14:12];      // 功能码
    assign rs1    = inst_reg[19:15];      // 第一源寄存器地址
    assign rs2    = inst_reg[24:20];      // 第二源寄存器地址
    assign sa     = inst_reg[24:20];       // 用于移位指令
    assign func7  = inst_reg[31:25];      // R型的功能码
    
    // 根据不同指令类型生成立即数（以 inst_reg 为基础）
    wire is_shift_imm = (opcode == 7'b0010011) & ((func3 == 3'b001) | (func3 == 3'b101));
    assign imm = (opcode == 7'b1101111) ? ({{12{inst_reg[31]}}, inst_reg[19:12], inst_reg[20], inst_reg[30:21], 1'b0}) :  // J型
                 (opcode == 7'b0100011) ? ({{20{inst_reg[31]}}, inst_reg[31:25], inst_reg[11:7]}) :                    // S型
                 (is_shift_imm)        ? ({27'b0, inst_reg[24:20]}) :                                                // 移位指令（零扩展）
                 ((opcode == 7'b0000011) || (opcode == 7'b0010011) || (opcode == 7'b1100111)) ? ({{20{inst_reg[31]}}, inst_reg[31:20]}) :
                 32'b0;
    
    // 指令类型判断信号
    // 实现指令列表
    wire inst_JAL_J;    // J型
    wire inst_JALR_I;   // I型 link
    wire inst_LW;       // I型 load
    wire inst_ADDI, inst_SLTI, inst_SLTIU, inst_XORI, inst_ORI, inst_ANDI; // I型计算
    wire inst_SLLI, inst_SRLI, inst_SRAI; // I型移位
    wire inst_ADD, inst_SUB, inst_SLL, inst_SLT, inst_SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND; // R型
    wire inst_SW;       // S型

    assign inst_JAL_J  = (opcode == 7'b1101111);
    assign inst_JALR_I = (opcode == 7'b1100111) & (func3 == 3'b000);
    assign inst_LW     = (opcode == 7'b0000011) & (func3 == 3'b010);
    assign inst_ADDI   = (opcode == 7'b0010011) & (func3 == 3'b000);
    assign inst_SLTI   = (opcode == 7'b0010011) & (func3 == 3'b010);
    assign inst_SLTIU  = (opcode == 7'b0010011) & (func3 == 3'b011);
    assign inst_XORI   = (opcode == 7'b0010011) & (func3 == 3'b100);
    assign inst_ORI    = (opcode == 7'b0010011) & (func3 == 7'b110);
    assign inst_ANDI   = (opcode == 7'b0010011) & (func3 == 7'b111);
    assign inst_SLLI   = (opcode == 7'b0010011) & (func3 == 7'b001);
    assign inst_SRLI   = (opcode == 7'b0010011) & (func3 == 7'b101) & (func7 == 7'b0000000);
    assign inst_SRAI   = (opcode == 7'b0010011) & (func3 == 7'b101) & (func7 == 7'b0100000);

    assign inst_ADD    = (opcode == 7'b0110011) & (func3 == 7'b000) & (func7 == 7'b0000000); 
    assign inst_SUB    = (opcode == 7'b0110011) & (func3 == 7'b000) & (func7 == 7'b0100000);
    assign inst_SLL    = (opcode == 7'b0110011) & (func3 == 7'b001);
    assign inst_SLT    = (opcode == 7'b0110011) & (func3 == 7'b010);
    assign inst_SLTU   = (opcode == 7'b0110011) & (func3 == 7'b011);
    assign inst_XOR    = (opcode == 7'b0110011) & (func3 == 7'b100);
    assign inst_SRL    = (opcode == 7'b0110011) & (func3 == 7'b101) & (func7 == 7'b0000000);
    assign inst_SRA    = (opcode == 7'b0110011) & (func3 == 7'b101) & (func7 == 7'b0100000);
    assign inst_OR     = (opcode == 7'b0110011) & (func3 == 7'b110);
    assign inst_AND    = (opcode == 7'b0110011) & (func3 == 7'b111);
    assign inst_SW     = (opcode == 7'b0100011) & (func3 == 7'b010);

    // load/store 类型判断
    wire inst_store;
    assign inst_load  = inst_LW;  // load 指令
    assign inst_store = inst_SW;  // store 指令

    // 使用 sa 域作为移位指令的偏移量
    wire inst_shf_sa;
    assign inst_shf_sa = inst_SLLI | inst_SRLI | inst_SRAI;
    
    // ALU 操作分类
    wire inst_add, inst_sub;
    wire inst_and, inst_or, inst_xor, inst_sll, inst_srl, inst_sra;
    wire inst_slt, inst_sltu;
    assign inst_add = inst_ADD | inst_ADDI | inst_load | inst_store;
    assign inst_sub = inst_SUB;
    assign inst_and = inst_AND | inst_ANDI;
    assign inst_or  = inst_OR  | inst_ORI;
    assign inst_xor = inst_XOR | inst_XORI;
    assign inst_sll = inst_SLL | inst_SLLI;
    assign inst_srl = inst_SRL | inst_SRLI;
    assign inst_sra = inst_SRA | inst_SRAI;
    assign inst_slt = inst_SLT | inst_SLTI;
    assign inst_sltu= inst_SLTIU | inst_SLTU;
    
    // 指令集分类，用于生成 inst_type
    wire inst_r_type, inst_i_type, inst_s_type, inst_j_type;
    assign inst_r_type = inst_ADD | inst_AND | inst_OR | inst_XOR | inst_SLL | inst_SRL | inst_SRA | inst_SLT | inst_SLTU | inst_SUB;
    assign inst_i_type = inst_ADDI | inst_SLTI | inst_SLTIU | inst_XORI | inst_ORI | inst_ANDI | inst_LW | inst_JALR_I | inst_shf_sa;
    assign inst_j_type = inst_JAL_J;
    assign inst_s_type = inst_SW;
    //----- 指令译码 end -----
    
    //----- 分支指令执行 begin -----
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            jbr_bus <= 32'b0;
            branch  <= 1'b0;
        end
        else begin
            if (opcode == 7'b1100111) // JALR
                jbr_bus <= (rs1_value + imm) & ~1;
            else if (opcode == 7'b1101111) // JAL
                jbr_bus <= pc_reg + imm;
            else
                jbr_bus <= pc_reg + 4;
                
            branch <= (opcode == 7'b1100111) | (opcode == 7'b1101111); // JALR 或 JAL
        end
    end
    //----- 分支指令执行 end -----
    
    //----- inst_type 生成 begin -----
    /*
    always @(posedge clk or posedge rst) begin
        if (rst)
            inst_type <= 4'b0000;
        else if (ID_valid) begin
            inst_type[0] <= inst_r_type;
            inst_type[1] <= inst_i_type;
            inst_type[2] <= inst_s_type;
            inst_type[3] <= inst_j_type;
        end
    end
    */
    //----- inst_type 生成 end -----
    
    //----- ID_EXE_bus 总线生成 begin -----
    wire [3:0] alu_control;
    wire [31:0] alu_operand1;
    wire [31:0] alu_operand2;
    
    assign alu_operand1 = rs1_value; // 来自寄存器
    assign alu_operand2 = inst_shf_sa ? {27'b0, sa} :
                          ((inst_ADDI || inst_SLTI || inst_SLTIU || inst_XORI || inst_ORI || inst_ANDI || inst_LW || inst_JALR_I || inst_store) ? 
                           imm : rs2_value);
    
    assign alu_control = (inst_add)  ? 4'b0000 :
                         (inst_sub)  ? 4'b0001 :
                         (inst_or)   ? 4'b0010 :
                         (inst_xor)  ? 4'b0011 :
                         (inst_sll)  ? 4'b0100 :
                         (inst_srl)  ? 4'b0101 :
                         (inst_sra)  ? 4'b0110 :
                         (inst_and)  ? 4'b0111 :
                         (inst_slt)  ? 4'b1000 :
                         (inst_sltu) ? 4'b1001 : 
                         4'b1111; // 默认 NOP
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            ID_EXE_bus <= 149'b0;
        else
            ID_EXE_bus <= {alu_control, alu_operand1, alu_operand2, rs2_value, rd, state,
                           inst_load,   // inst_load 标志
                           inst_store,   // inst_store 标志
                           branch, 
                           is_shift_imm, 
                           sa, 
                           pc_reg};
    end
    //----- ID_EXE_bus 总线生成 end
    
endmodule   
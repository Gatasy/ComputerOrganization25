`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: CPU_Top
// Description: 顶层CPU模块，连接取指、译码、执行、访存和写回五个阶段。
//////////////////////////////////////////////////////////////////////////////////
module CPU_Top(
    input  wire        clk,        // 时钟信号
    input  wire        rst,        // 复位信号
    //display显示部分
    output reg [31:0] pc_if,       // IF阶段PC值
    output reg [31:0] pc_id,       // ID阶段PC值
    output reg [31:0] pc_ex,       // EXE阶段PC值
    output reg [31:0] pc_mem,      // MEM阶段PC值
    output reg [31:0] pc_wb,       // WB阶段PC值
    output wire [31:0] IF_inst,   // IF阶段指令
    
    input  [ 4:0] rf_addr,
    output [31:0] rf_data,
    input  [31:0] test_mem_addr,  // 外部输入的内存地址
    output [31:0] test_mem_data,   // 读取出的内存数据

    output [2:0]display_state
    
    
);
    // 状态信号
    wire [2:0] state;
	wire [2:0] next_state;

    
    // 状态编码
    parameter IDLE = 3'b000;
    parameter FETCH = 3'b001;
    parameter DECODE = 3'b010;
    parameter EXE = 3'b011;
    parameter MEM = 3'b100;
    parameter WB = 3'b101;
    
    //5模块的valid信号
    wire IF_valid;
    wire ID_valid;
    wire EXE_valid;
    wire MEM_valid;
    wire WB_valid;
    assign  IF_valid = (state == FETCH );  // 当前状态为取指时，IF级有效
    assign  ID_valid = (state == DECODE);  // 当前状态为译码时，ID级有效
    assign EXE_valid = (state == EXE   );  // 当前状态为执行时，EXE级有效
    assign MEM_valid = (state == MEM   );  // 当前状态为访存时，MEM级有效
    assign  WB_valid = (state == WB    );  // 当前状态为写回时，WB级有效




    
     // IF 阶段信号
    wire [31:0] pc_addr;
    wire [31:0] inst_data;
    wire [63:0] IF_ID_bus;
    wire        IF_ready;
    wire        inst_mem_en;
    wire [14:0]  inst_mem_addr;
    
    // ID 阶段信号
    wire [4:0]  rs1, rs2, rd;
    wire [31:0] rs1_value, rs2_value;
    wire [31:0] jbr_bus;
    wire        branch;
    wire        ID_ready;
    wire [148:0] ID_EXE_bus;
    wire [3:0]inst_type;
    wire inst_load;
   
    // EX 阶段信号
    wire [31:0] alu_result;
    wire [70:0] EX_WB_bus;
    wire        EXE_ready;
    wire [31:0] EXE_pc;
    wire [65:0] EX_MEM_bus;
    
    
    // MEM 阶段信号
    wire [31:0] read_data;
    wire        mem_busy;
	wire       MEM_ready;
	wire        mem_en;                // 存储器使能
    wire [3:0]  mem_wea;               // 字节写使能
    wire [31:0] mem_addr;              // 存储器地址
    wire [31:0] mem_write_data;        // 存储数据

    
    // WB 阶段信号
    wire        reg_wen;
    wire [4:0]  wb_addr;
    wire [31:0] wb_data;
    wire        WB_ready;
    wire [2:0] reset_delay_cnt;

    // --- 修改后的PC生成逻辑 ---
    reg [31:0] pc_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_reg <= 32'b0;        
         end else begin
            if (reset_delay_cnt < 3'd3) begin
                pc_reg <= 32'b0;
            end else if (IF_ready) begin
                pc_reg <= (branch) ? ID_EXE_bus_r[31:0] : pc_reg + 4;
            end
        end
    end
    assign pc_addr = pc_reg;

    // --- 同步IF_ready信号 ---
   

    // --- 强制复位期间输出NOP指令 ---
    assign IF_inst = (rst || reset_delay_cnt < 3) ? 32'h00000013 : inst_data;

//*/m
    reg [63:0] IF_ID_bus_r;
    always @(posedge clk or posedge rst) begin
        if (rst)
            IF_ID_bus_r <= 64'b0;
        else if (IF_ready)
            IF_ID_bus_r <= IF_ID_bus;
    end
    
    reg [148:0] ID_EXE_bus_r;
    always @(posedge clk or posedge rst) begin
        if (rst)
            ID_EXE_bus_r <= 149'b0;
        else if (ID_ready)
            ID_EXE_bus_r <= ID_EXE_bus;
    end
    
    reg [65:0] EX_MEM_bus_r;
    always @(posedge clk or posedge rst) begin
        if (rst)
            EX_MEM_bus_r <= 66'b0;
        else if (EXE_ready)
            EX_MEM_bus_r <= EX_MEM_bus;
    end
    
    reg [31:0] pc_mem_r;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_mem_r <= 32'b0;
        else if (EXE_ready)
            pc_mem_r <= EXE_pc;  // EXE_pc 来自 exe 模块
    end

    
    reg [70:0] EX_WB_bus_r;
    always @(posedge clk or posedge rst) begin
        if (rst)
            EX_WB_bus_r <= 71'b0;
        else if (MEM_ready)
            EX_WB_bus_r <= EX_WB_bus;
    end
    
        

  
// 实例化状态机 (Timer)
   Timer timer (
        .clk(clk),
        .rst(rst),
        .IF_over(IF_ready),
        .ID_over(ID_ready),
        .EXE_over(EXE_ready),
        .MEM_over(MEM_ready),
        .WB_over(WB_ready),
        .branch(branch),
       // .inst_load(inst_load),
       // .inst_type(inst_type),
        .state(state),
        .next_state(next_state),
        .reset_delay_cnt(reset_delay_cnt)  // <--- Added: 传递复位延迟计数器
    );

    // --- 实例化ifetch模块 ---
    ifetch ifetch_inst (
        .IF_valid(IF_valid),
        .clk(clk),
        .rst(rst),
        .state(state),
        .reset_delay_cnt(reset_delay_cnt),  // <--- Added: 传递复位延迟计数器
        .pc_addr(pc_addr),
        .inst_data(inst_data),
        .inst_mem_en(inst_mem_en),
        .inst_mem_we(),
        .inst_mem_addr(inst_mem_addr),
        .IF_ID_bus(IF_ID_bus),
        .IF_ready(IF_ready)
    );
    
    // 寄存器堆 (RegFile)
    regfile regfile_inst (
        .clk(clk),
        .wen(reg_wen),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(wb_addr),
        .wdata(wb_data),
        .rdata1(rs1_value),
        .rdata2(rs2_value),
        .test_addr(rf_addr),
        .test_data(rf_data)
    );
    
    // 译码模块 (Decoder)
    Decoder decoder_inst (
        .clk(clk),
        .rst(rst),
        .ID_valid(ID_valid),
        .IF_ID_bus_r(IF_ID_bus_r),
        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .state(state),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .jbr_bus(jbr_bus),
        .branch(branch),
        .inst_load(inst_load),
        .ID_ready(ID_ready),
        .ID_EXE_bus(ID_EXE_bus)
       // .inst_type(inst_type)
        
            );
    
    // 执行模块 (EXE)
    exe exe_inst (
        .EXE_valid(EXE_valid),
        .clk(clk),
        .rst(rst),
        .state(state),
        .ID_EXE_bus(ID_EXE_bus_r),
        .EX_MEM_bus(EX_MEM_bus),
        .EX_WB_bus(EX_WB_bus),
        .alu_result(alu_result),
        .EXE_ready(EXE_ready),
        .EXE_pc(EXE_pc)
        
    );
    
    // 访存模块 (MEM)
    MEM_stage mem_stage_inst (
        .clk(clk),
        .reset(rst),
        .state(state),
        .MEM_valid(MEM_valid),
        .EX_MEM_bus(EX_MEM_bus_r),
        .read_data(read_data),
	    .MEM_ready(MEM_ready),
	    
	    .mem_en(mem_en),
        .mem_wea(mem_wea),
        .mem_addr(mem_addr),
        .mem_write_data(mem_write_data)
    );
    
    // 数据存储器实例化
   blk_mem_gen_0 data_memory (
    // 端口 A：CPU 访存
    .clka(clk),                         
    .ena(mem_en),                    
    .wea(mem_wea),                   
    .addra(mem_addr[16:2]),  
    .dina(mem_write_data),  
   
    // 端口 B：测试只读
    .clkb(clk),                       
    .enb(1'b1),  // 始终允许读测试地址
    .addrb(test_mem_addr[16:2]),  
    .doutb(test_mem_data)  // 输出测试数据
);

    
    // 写回模块 (WB)
    wb wb_inst (
        .WB_valid(WB_valid),
        .clk(clk),
        .rst(rst),
        .state(state),
        .EX_WB_bus(EX_WB_bus_r),
        .lsu_data(read_data),
        .reg_wen(reg_wen),
        .wb_addr(wb_addr),
        .wb_data(wb_data),
        .WB_ready(WB_ready)
    );
      // 指令存储器实例化
    blk_mem_gen_1 inst_memory (
        // 端口A：用于取指（只读）
        .clka(clk),                         // 时钟信号
        .ena(inst_mem_en),                  // 取指阶段使能信号
        .addra(inst_mem_addr),              // 取指地址（15 位宽）
        .douta(inst_data)                       // 无写入数据
    
    );
    
    
       // 输出当前PC值，便于调试
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_if  <= 32'b0;
            pc_id  <= 32'b0;
            pc_ex  <= 32'b0;
            pc_mem <= 32'b0;
            pc_wb  <= 32'b0;
        end
        else begin
            pc_if  <= pc_addr;             // 取指阶段 PC
            pc_id  <= IF_ID_bus_r[63:32];  // 解码阶段 PC
            pc_ex  <= ID_EXE_bus_r[31:0];  // 执行阶段 PC
            pc_mem <= (ID_EXE_bus_r[39]||ID_EXE_bus_r[40])? pc_mem_r : 32'b0;  // 访存阶段 PC
            pc_wb <= (!ID_EXE_bus_r[38] && ID_EXE_bus_r[148:145] != 4'b1111) ? EX_WB_bus_r[31:0] : 32'b0;
        end
    end

//assign IF_inst = inst_data; // 输出IF阶段指令
assign display_state=state;
    

    
endmodule

////////////////////////////////////////////////////////////////////////////////
// pc_bus.v
// Program Counter for bus-based instruction fetch (externally via instAddr_32/instData_32)
// 修正：复位时 PC 从 0 开始
////////////////////////////////////////////////////////////////////////////////

module pc(
    input  wire        clk,
    input  wire        rst,
    input  wire [32:0] i_wb_newpc,        // 写回阶段新PC，高位有效
    input  wire [32:0] i_dec_newpc,       // 译码阶段新PC，高位有效
    input  wire [32:0] i_exception_newpc, // 异常处理新PC，高位有效
    input  wire        stop,              // 暂停信号

    // 外部总线取指口
    output wire [31:0] instAddr_32,       // 取指地址
    input  wire [31:0] instData_32,       // 取指数据

    // 当前 PC + 指令，供 decode 用
    output wire [63:0] o_data             // {pc_now, instruction}
);

reg [31:0] instruction;
reg [31:0] pc_now;
reg [31:0] pc_next;

// B/BL/JIRL 分支检测
wire B_jump    = (instruction[31:26] == 6'b010100);
wire BL_jump   = (instruction[31:26] == 6'b010101);
wire JIRL_jump = (instruction[31:26] == 6'b010011);
wire jump_sign2 = BL_jump | JIRL_jump;

// 计算 B 分支目标地址
wire [31:0] B_addr = instruction[25] ?
    ({4'b1111, instruction[9:0], instruction[25:10], 2'b0} + pc_now) :
    ({4'b0000, instruction[9:0], instruction[25:10], 2'b0} + pc_now);

// o_data 输出
assign o_data = (~rst || jump_sign2_stop) ? 64'b0 : {pc_now, instruction};

// 取指地址直接是 pc_next
assign instAddr_32 = pc_next;

// PC 更新
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        pc_now      <= 32'h00000000;  // ← 从 0 开始
        pc_next     <= 32'h00000000;  // ← 从 0 开始
        instruction <= 32'b0;
    end
    else if (stop) begin
        pc_now      <= pc_now;
        pc_next     <= pc_next;
        instruction <= instruction;
    end
    else begin
        // 接收总线给的指令
        instruction <= instData_32;

        // 跳转优先级：异常 > 写回 > 译码 > B 分支 > 顺序
        if (i_exception_newpc[32]) begin
            pc_now  <= i_exception_newpc[31:0];
            pc_next <= i_exception_newpc[31:0] + 4;
        end
        else if (i_wb_newpc[32]) begin
            pc_now  <= i_wb_newpc[31:0];
            pc_next <= i_wb_newpc[31:0] + 4;
        end
        else if (i_dec_newpc[32]) begin
            pc_now  <= i_dec_newpc[31:0];
            pc_next <= i_dec_newpc[31:0] + 4;
        end
        else if (B_jump) begin
            pc_now  <= B_addr;
            pc_next <= B_addr + 4;
        end
        else begin
            pc_now  <= pc_next;
            pc_next <= pc_next + 4;
        end
    end
end

// BL/JIRL 插气泡暂停逻辑
reg [2:0] counter;
reg       counter_state;
reg       jump_sign2_stop;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        counter         <= 3'b0;
        counter_state   <= 1'b0;
        jump_sign2_stop <= 1'b0;
    end
    else if (jump_sign2 && !counter_state) begin
        counter         <= 3'b1;
        counter_state   <= 1'b1;
        jump_sign2_stop <= 1'b1;
    end
    else if (counter_state) begin
        if (counter == 3'b100) begin
            counter         <= 3'b0;
            counter_state   <= 1'b0;
            jump_sign2_stop <= 1'b0;
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule

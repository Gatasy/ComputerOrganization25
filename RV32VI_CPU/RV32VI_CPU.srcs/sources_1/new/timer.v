module Timer(
    input clk,                    // 时钟信号
    input rst,                    // 复位信号（高电平有效）
    input IF_over,                // 取指完成信号
    input ID_over,                // 译码完成信号
    input EXE_over,               // 执行完成信号
    input MEM_over,               // 访存完成信号
    input WB_over,                // 写回完成信号
    input branch,                 // 分支指令信号
   // input inst_load,              // 加载类指令标识
   // input [3:0] inst_type,        // 指令类型编码
    output reg [2:0] state,       // 当前状态
    output reg [2:0] next_state,  // 下一状态
    output reg [2:0] reset_delay_cnt  // <--- 新增：复位延迟计数器输出
);

    // --- 参数定义 ---
    parameter IDLE   = 3'b000;
    parameter FETCH  = 3'b001;
    parameter DECODE = 3'b010;
    parameter EXE    = 3'b011;
    parameter MEM    = 3'b100;
    parameter WB     = 3'b101;
    parameter MAX_CYCLES = 5;     // 状态超时阈值
    parameter RESET_DELAY = 3;    // 复位后延迟周期数

    // --- 内部信号 ---
  //  reg [3:0] inst_type_r;        // 指令类型锁存
    reg [2:0] stall_counter;      // 状态停滞计数器

    // --- 指令类型锁存 ---
    /*
    always @(posedge clk or posedge rst) begin
        if (rst) 
            inst_type_r <= 4'b0;
        else
            inst_type_r <= inst_type;
    end
   */

    // --- 复位延迟计数器 ---
    always @(posedge clk or posedge rst) begin
        if (rst)
            reset_delay_cnt <= 0;
        else if (reset_delay_cnt < RESET_DELAY)
            reset_delay_cnt <= reset_delay_cnt + 1;
    end

    // --- 组合逻辑：下一状态计算 ---
    always @(*) begin
        if (reset_delay_cnt < RESET_DELAY) begin
            next_state = IDLE;  // 复位延迟期间强制保持IDLE
        end else begin
            case (state)
                IDLE:   next_state = FETCH;
                FETCH:  next_state = IF_over ? DECODE : FETCH;
                DECODE: begin
                    if (ID_over) 
                            next_state = EXE;
                     else
                        next_state = DECODE;
                end
                EXE: begin
                    if (EXE_over) begin
                            next_state = MEM;
                        end 
                        else
                            next_state = EXE;
                end
                MEM:    next_state = MEM_over ? WB : MEM;
                WB:     next_state = WB_over ? FETCH : WB;
                default: next_state = IDLE;
            endcase
        end
    end

    // --- 时序逻辑：状态更新与超时保护 ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            stall_counter <= 0;
        end else begin
            // 复位延迟期间强制保持IDLE
            if (reset_delay_cnt < RESET_DELAY) begin
                state <= IDLE;
                stall_counter <= 0;
            end else begin
                // 超时保护逻辑
                if (state == next_state) begin
                    stall_counter <= stall_counter + 1;
                    if (stall_counter >= MAX_CYCLES)
                        state <= IDLE;  // 超时强制复位
                end else begin
                    stall_counter <= 0;  // 状态切换时重置计数器
                    state <= next_state;
                end
            end
        end
    end

endmodule
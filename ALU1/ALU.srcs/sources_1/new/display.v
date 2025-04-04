module display(
    // 时钟与复位信号
    input clk,
    input resetn,    // 后缀"n"代表低电平有效

    // 拨码开关，用于选择输入数
    input [2:0] input_sel, // 000:输入为控制信号(ALU_op)
                            // 001:输入为源操作数1(A)
                            // 010:输入为源操作数2(B)
                            // 011:输入为截断位数(TruncateLen)
                            // 100:输入为截断方向信号(dir)
                            // 101:输入为移位类型(shift_type)

    // 触摸屏相关接口
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
);

    // -----{调用ALU模块}begin
    reg [31:0] A;               // ALU操作数1
    reg [31:0] B;               // ALU操作数2
    reg [3:0] ALUControl;       // ALU操作码
    reg [4:0] TruncateLen;      // 截断位数
    reg [1:0] shift_type;       // 移位类型
    reg dir;                    // 截断方向信号
    wire [31:0] Result;         // ALU运算结果
    wire Cout;                  // 进位输出

    ALU alu_module (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .TruncateLen(TruncateLen),
        .shift_type(shift_type),  // 传递移位类型
        .dir(dir),                // 传递方向信号
        .Result(Result),
        .Cout(Cout)
    );
    // -----{调用ALU模块}end

    // 此小节不需要更改
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   // 10MHz
        .resetn         (resetn        ),

        // 调用触摸屏的接口
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        // lcd触摸屏相关接口，不需要更改
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 

    // -----{从触摸屏获取输入}begin
    // 写死 ALU 操作码
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            ALUControl <= 4'd0;
        end else begin
            ALUControl <= 4'b1010;  // 固定的操作码（例如 ADD）
        end
    end

    // 写死操作数 A
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            A <= 32'd0;
        end else begin
            A <= 32'd1;  // 固定值 1
        end
    end

    // 写死操作数 B
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            B <= 32'd0;
        end else begin
            B <= 32'd2;  // 固定值 2
        end
    end

    // 写死截断位数
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            TruncateLen <= 5'd0;
        end else begin
            TruncateLen <= 5'd10;  // 固定值 10
        end
    end

    // 写死截断方向信号
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            dir <= 1'b0;  // 默认方向
        end else begin
            dir <= 1'b1;  // 固定方向信号
        end
    end

    // 写死移位类型
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            shift_type <= 2'b00;  // 默认移位类型
        end else begin
            shift_type <= 2'b01;  // 固定移位类型
        end
    end
    // -----{从触摸屏获取输入}end

    // -----{输出到触摸屏显示}begin
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            display_valid <= 1'b0;
            display_name <= 40'd0;
            display_value <= 32'd0;
        end else begin
            case(display_number)
                6'd1: begin    // 显示操作数A
                    display_valid <= 1'b1;
                    display_name  <= "OP_A                                ";
                    display_value <= 32'd1; // 固定值
                end
                6'd2: begin    // 显示操作数B
                    display_valid <= 1'b1;
                    display_name  <= "OP_B                                ";
                    display_value <= 32'd2; // 固定值
                end
                6'd3: begin    // 显示ALU操作码
                    display_valid <= 1'b1;
                    display_name  <= "ALU_OP                              ";
                    display_value <= 32'd10; // 固定值
                end
                6'd4: begin    // 显示截断位数
                    display_valid <= 1'b1;
                    display_name  <= "TRUNC                                ";
                    display_value <= 32'd10; // 固定值
                end
                6'd5: begin    // 显示ALU运算结果
                    display_valid <= 1'b1;
                    display_name  <= "RESULT                               ";
                    display_value <= Result; // ALU计算结果
                end
                6'd6: begin    // 显示进位输出
                    display_valid <= 1'b1;
                    display_name  <= "COUT                                 ";
                    display_value <= {31'd0, Cout}; // 进位输出
                end
                6'd7: begin    // 显示截断方向
                    display_valid <= 1'b1;
                    display_name  <= "DIR                                  ";
                    display_value <= {31'd0, dir}; // 截断方向
                end
                6'd8: begin    // 显示移位类型
                    display_valid <= 1'b1;
                    display_name  <= "SHIFT                                ";
                    display_value <= {30'd0, shift_type}; // 移位类型
                end
                default: begin
                    display_valid <= 1'b0;
                    display_name  <= 40'd0;
                    display_value <= 32'd0;
                end
            endcase
        end
    end
    // -----{输出到触摸屏显示}end

endmodule

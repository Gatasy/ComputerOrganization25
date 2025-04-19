`timescale 1ns / 1ps

module spi(

    input wire       clk,
    input wire       rst,
    
    //�������ߵ��ź�
    input wire      i_cs_1,
    input wire      i_as_1,
    input wire      i_rw_1,
    
    //���������
    output reg      o_rdy_1,
    
//    input wire       we_i,
    input wire[31:0] i_data_32,
    input wire[31:0] i_addr_32,
    output reg[31:0] o_data_32,

    output reg       o_spiMosi_1,             // spi�����������spi�豸�����ź�
    input  wire      i_spiMiso_1,             // spi���������롢spi�豸����ź�
    output wire      o_spiSs_1,              // spi�豸Ƭѡ
    output reg       o_spiClk_1               // spi�豸ʱ�ӣ����Ƶ��Ϊ����clk��һ��

    );

    localparam SPI_CTRL   = 4'h0;    // spi_ctrl�Ĵ�����ַƫ��
    localparam SPI_DATA   = 4'h4;    // spi_data�Ĵ�����ַƫ��
    localparam SPI_STATUS = 4'h8;    // spi_status�Ĵ�����ַƫ��

    // spi���ƼĴ���
    // addr: 0x00
    // [0]: 1: enable, 0: disable
    // [1]: CPOL
    // [2]: CPHA
    // [3]: select slave, 1: select, 0: deselect
    // [15:8]: clk div
    reg[31:0] spi_ctrl;
    // spi���ݼĴ���
    // addr: 0x04
    // [7:0] cmd or inout data
    reg[31:0] spi_data;
    // spi״̬�Ĵ���
    // addr: 0x08
    // [0]: 1: busy, 0: idle
    reg[31:0] spi_status;

    reg[8:0] clk_cnt;               // ��Ƶ����
    reg en;                         // ʹ�ܣ���ʼ�����źţ������ڼ�һֱ��Ч
    reg[4:0] spi_clk_edge_cnt;      // spi clkʱ���صĸ���
    reg spi_clk_edge_level;         // spi clk�ص�ƽ
    reg[7:0] rdata;                 // ��spi�豸������������
    reg done;                       // ��������ź�
    reg[3:0] bit_index;             // ����bit����
    wire[8:0] div_cnt;


    assign o_spiSs_1 = ~spi_ctrl[3];   // SPI�豸Ƭѡ�ź�
    assign div_cnt = spi_ctrl[15:8];// 0: 2��Ƶ��1��4��Ƶ��2��8��Ƶ��3��16��Ƶ��4��32��Ƶ���Դ�����

    // ����ʹ���ź�
    // �����ڼ�һֱ��Ч
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            en <= 1'b0;
            o_rdy_1<=1'b1;
        end else begin
            /*�����ź�����*/
            if((i_cs_1 == 1'b0)&&(i_as_1==1'b0))begin//�Ķ�
                o_rdy_1<= 1'b0;
            end else begin
                o_rdy_1<=1'b1;
            end
            if (spi_ctrl[0] == 1'b1 && (i_cs_1==1'b0)&&(i_as_1==1'b0)) begin
                en <= 1'b1;
            end else if (done == 1'b1) begin
                en <= 1'b0;
            end else begin
                en <= en;
            end
        end
    end

    // ������ʱ�ӽ��м���
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            clk_cnt <= 9'h0;
        end else if (en == 1'b1) begin
            if (clk_cnt == div_cnt) begin
                clk_cnt <= 9'h0;
            end else begin
                clk_cnt <= clk_cnt + 1'b1;
            end
        end else begin
            clk_cnt <= 9'h0;
        end
    end

    // ��spi clk�ؽ��м���
    // ÿ����������Ƶֵʱ����һ������������
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            spi_clk_edge_cnt <= 5'h0;
            spi_clk_edge_level <= 1'b0;
        end else if (en == 1'b1) begin
            // �����ﵽ��Ƶֵ
            if (clk_cnt == div_cnt) begin
                if (spi_clk_edge_cnt == 5'd17) begin
                    spi_clk_edge_cnt <= 5'h0;
                    spi_clk_edge_level <= 1'b0;
                end else begin
                    spi_clk_edge_cnt <= spi_clk_edge_cnt + 1'b1;
                    spi_clk_edge_level <= 1'b1;
                end
            end else begin
                spi_clk_edge_level <= 1'b0;
            end
        end else begin
            spi_clk_edge_cnt <= 5'h0;
            spi_clk_edge_level <= 1'b0;
        end
    end

    // bit����
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            o_spiClk_1 <= 1'b0;
            rdata <= 8'h0;
            o_spiMosi_1 <= 1'b0;
            bit_index <= 4'h0;
        end else begin
            if (en) begin
                if (spi_clk_edge_level == 1'b1) begin
                    case (spi_clk_edge_cnt)
                        // ��������ʱ����
                        1, 3, 5, 7, 9, 11, 13, 15: begin
                            o_spiClk_1 <= ~o_spiClk_1;
                            if (spi_ctrl[2] == 1'b1) begin
                                o_spiMosi_1 <= spi_data[bit_index];   // �ͳ�1bit����
                                bit_index <= bit_index - 1'b1;
                            end else begin
                                rdata <= {rdata[6:0], i_spiMiso_1};   // ��1bit����
                            end
                        end
                        // ��ż����ʱ����
                        2, 4, 6, 8, 10, 12, 14, 16: begin
                            o_spiClk_1 <= ~o_spiClk_1;
                            if (spi_ctrl[2] == 1'b1) begin
                                rdata <= {rdata[6:0], i_spiMiso_1};   // ��1bit����
                            end else begin
                                o_spiMosi_1 <= spi_data[bit_index];   // �ͳ�1bit����
                                bit_index <= bit_index - 1'b1;
                            end
                        end
                        17: begin
                            o_spiClk_1 <= spi_ctrl[1];
                        end
                    endcase
                end
            end else begin
                // ��ʼ״̬
                o_spiClk_1 <= spi_ctrl[1];
                if (spi_ctrl[2] == 1'b0) begin
                    o_spiMosi_1 <= spi_data[7];           // �ͳ����λ����
                    bit_index <= 4'h6;
                end else begin
                    bit_index <= 4'h7;
                end
            end
        end
    end

    // ��������(���)�ź�
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            done <= 1'b0;
        end else begin
            if (en && spi_clk_edge_cnt == 5'd17) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // write reg
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            spi_ctrl <= 32'h0;
            spi_data <= 32'h0;
            spi_status <= 32'h0;
        end else begin
            spi_status[0] <= en;
            if (i_rw_1 == 1'b0) begin//�Ķ�
                case (i_addr_32[3:0])
                    SPI_CTRL: begin
                        spi_ctrl <= i_data_32;
                    end
                    SPI_DATA: begin
                        spi_data <= i_data_32;
                    end
                    default: begin

                    end
                endcase
            end else begin
                spi_ctrl[0] <= 1'b0;
                // ������ɺ�������ݼĴ���
                if (done == 1'b1) begin
                    spi_data <= {24'h0, rdata};
                end
            end
        end
    end

    // read reg
    always @ (*) begin
        if (!rst) begin
            o_data_32 = 32'h0;
        end else begin
            case (i_addr_32[3:0])
                SPI_CTRL: begin
                    o_data_32 = spi_ctrl;
                end
                SPI_DATA: begin
                    o_data_32 = spi_data;
                end
                SPI_STATUS: begin
                    o_data_32 = spi_status;
                end
                default: begin
                    o_data_32 = 32'h0;
                end
            endcase
        end
    end

endmodule
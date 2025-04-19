`timescale 1ns / 1ps

module data_init
#(
    parameter FREQ = 25
)
(
    input wire         clk,
    input wire         rst,                      //��λ�źţ��͵�ƽ��Ч
    input wire         i_uartRx_1,                    //���ڽ����ⲿ���ݣ������ݰ�����ÿ�ν���1bit
    output wire        o_uartTx_1,                    //����CRCУ�����ACK/NAK�źţ���uart_rxһ����ÿ�δ���1bit����
    
    output wire        o_initSig_1,
    output wire        o_ibusWe_1,                    //Icacheдʹ���źţ������ݷ��͸�Icacheʱ��Ч
    output wire [31:0] o_ibusAddr_32,                //Icache��Ŀ�ĵ�ַ
    output wire [31:0] o_ibusData_32,                //������Icache�����ݣ���data�Ĵ�����ȡ����ÿ�η���32bit
    output wire        o_dbusWe_1,                    //Dcacheдʹ���źţ������ݷ��͸�Dcacheʱ��Ч
    output wire [31:0] o_dbusAddr_32,                //Dcache��Ŀ�ĵ�ַ
    output wire [31:0] o_dbusData_32                 //������Dcache�����ݣ���data�Ĵ�����ȡ����ÿ�η���32bit
);

    
    localparam UART_RESP_ACK          = 8'h6  ;    //uart����ȷ���ź�ACK
    localparam UART_RESP_NAK          = 8'h15 ;    //uart����δȷ���ź�NAK
    localparam UART_REMAIN_PACKET_LEN = 8'd131;    //���ݰ�����131Byte

    //data_init״̬����������
    localparam  IDLE       =  10'h000;
    localparam  NUM        =  10'h001;
    localparam  DATA0      =  10'h002;
    localparam  DATA1      =  10'h004;
    localparam  DATA2      =  10'h008;
    localparam  DATA3      =  10'h00F;
    localparam  SEND       =  10'h010;
    localparam  CRC1       =  10'h020;
    localparam  CRC_START  =  10'h040;
    localparam  CRC_CALC   =  10'h080;
    localparam  CRC_END    =  10'h0F0;
    localparam  SENDRSP    =  10'h100;
    localparam  WAITSEND   =  10'h200;

    reg        r_ibus_we;
    reg [31:0] r_ibus_addr_o;
    reg [31:0] r_ibus_data_o;
    reg        r_dbus_we;
    reg [31:0] r_dbus_addr_o;
    reg [31:0] r_dbus_data_o;
    
    reg [ 7:0] tx_data;          //DATAing data
    reg        tx_data_valid;    //DATAing data valid
    wire       tx_data_ready;    //singal for DATAing data
    wire [7:0] rx_data;          //receiving data
    wire       rx_data_valid;    // receiving data valid
    //wire       rx_data_ready;    // singal for receiving data
    reg  [9:0] c_state;     
    reg  [9:0] n_state;  

    //assign rx_data_ready = 1'b1;
    
    reg [31:0] data;             //��������rx�����ݣ�ÿ�ν���8bit
    reg [ 7:0] count;           //�ѽ��ն���Byte�����ݣ��ۼ���128ʱ���ݲ��ֽ�����ϣ�����CRC
    reg [31:0] addr_i;           //Icache��ַ
    reg [31:0] addr_d;           //Dcache��ַ
    reg        valid;            //SEND״̬�ݴ�rx_data_valid�ź�
    
    //�ļ���С������ţ����ڱ�ʶ����Icache����Dcache
    reg [ 7:0] number;
    //�Ƿ�Ϊ��һ��������һ����ֻ��CRC����Ҫ�洢��
    reg [ 7:0] first;
    reg [ 7:0] size;

    //����CRC����
    reg [ 7:0] crc_data[0:128];
    reg [ 7:0] rec_bytes_index;
    reg [ 7:0] need_to_rec_bytes;
    reg [15:0] crc_result;
    reg [ 3:0] crc_bit_index;
    reg [ 7:0] crc_byte_index;
    reg [15:0] r_crc_16;

    //-----{����ʽ״̬��}begin
    //-----{ʱ���߼�������״̬ת��}begin
    always @(posedge clk or negedge rst) begin
        if(!rst)
            c_state <= IDLE;
        else 
            c_state <= n_state;
    end
    //-----{ʱ���߼�������״̬ת��}end

    //-----{����߼����ж�״̬ת������}begin
    always @(*) begin
        case (c_state)
            IDLE:begin
                if(rx_data_valid)
                    n_state = NUM;
                else 
                    n_state = IDLE;
            end
            NUM:begin
                if(rx_data_valid)
                    n_state = DATA0;
                else 
                    n_state = NUM;
            end
            DATA0:begin
                if(rx_data_valid)
                    n_state = DATA1;
                else 
                    n_state = DATA0;
            end
            DATA1:begin
                if(rx_data_valid)
                    n_state = DATA2;
                else 
                    n_state = DATA1;
            end
            DATA2:begin
                if(rx_data_valid)
                    n_state = DATA3;
                else 
                    n_state = DATA2;
            end        
            DATA3:begin
                if(rx_data_valid)
                    n_state = SEND;
                else
                    n_state = DATA3;
            end    
            SEND:begin
                if(count == 8'd128)
                    n_state = CRC1;
                    //n_state = CRC_START;//������
                else 
                    n_state = DATA0;
            end
            CRC1:begin
                if(rx_data_valid)
                    n_state = CRC_START;
                else
                    n_state = CRC1;            
            end
            CRC_START:begin
				if(count == 8'd130 || (count == 8'd128 && (first == 8'h0 || first == 8'hff))) //������Ҫ����
					n_state = CRC_CALC;
                else if(rx_data_valid || (valid && count == 8'd128))
                    n_state = CRC_CALC;
                else
                    n_state = CRC_START;    
            end
            CRC_CALC:begin
                if ((crc_byte_index == need_to_rec_bytes - 2) && crc_bit_index == 4'h8)
                    n_state = CRC_END;
                else 
                    n_state = CRC_CALC;
            end
            CRC_END:begin
				n_state = SENDRSP;
            end
            SENDRSP:begin
				n_state = WAITSEND;
            end
			WAITSEND:begin
				 if(tx_data_ready &&( rx_data_valid ) )
                    n_state = NUM;
                else
                    n_state = WAITSEND;
			end
            default: 
                n_state = IDLE;
        endcase
    end
    //-----{����߼����ж�״̬ת������}end
    
    //-----{ʱ���߼�����ÿ��״̬����������ж�}begin
	integer i; 
	
    always @(posedge clk or negedge rst) begin
        if(!rst)begin
		   for(i = 0 ; i < 129;i = i + 1) begin
				crc_data[i] <= 8'b0;
			end
            r_ibus_we       <= 1'b0;
            r_ibus_addr_o   <= 32'b0;
            r_ibus_data_o   <= 32'b0;
            r_dbus_we       <= 1'b0;
            r_dbus_addr_o   <= 32'b0;
            r_dbus_data_o   <= 32'b0;
            tx_data         <= 8'b0;
            tx_data_valid   <= 1'b0;
            data            <= 32'b0;
            count           <= 8'b0;

            addr_i          <= 32'h0;
            //addr_d <= 32'h4000;
            addr_d          <= 32'h0;
            number          <= 8'b0;
            first           <= 8'b0;
            valid           <= 1'b0;
            r_crc_16        <= 16'h0;
            rec_bytes_index <= 8'b1;
            size            <= 8'b0;
        end
        else begin
            case (n_state)
                NUM:      begin
                    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    tx_data_valid   <= 1'b0;
                    rec_bytes_index <= 8'b1;
                    crc_data[0]     <= rx_data;
                    /*
                    first��number���Ǵ�����ݰ���ţ�
                    firstÿ��һ�����ݰ���Ҫ���£�
                    numberֻ��Icache��Dcache�л�ʱ����
                    */
                    first           <= rx_data;
                    if(rx_data == 8'h0 || rx_data == 8'hff)
                            number  <= rx_data;
                end
                DATA0:    begin
                    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    if(rx_data_valid)begin
                        count       <= count+1;
                        data[31:24]   <= rx_data;
                        if(first == 8'h0 || first == 8'hff)
                            size    <= rx_data;
                    end
                    else if(valid)
                        data[31:24]   <= rx_data;
                end 
                DATA1:    begin
                    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    if(rx_data_valid)begin
                        count       <= count+1;
                        data[23:16]  <= rx_data;
                    end
                end
                DATA2:    begin
                    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    if (rx_data_valid) begin
                        count       <= count+1;
                        data[15:8] <= rx_data;
                    end
                end
                DATA3:    begin
                    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    if(rx_data_valid)begin
                        count       <= count+1;
                        data[7:0] <= rx_data;
                    end
                end
                SEND:     begin
                    //crc_data�ݴ����ݰ������Խ���CRCУ��
                    crc_data[rec_bytes_index] <= data[31:24];
                    crc_data[rec_bytes_index+1] <= data[23:16];
                    crc_data[rec_bytes_index+2] <= data[15:8];
                    crc_data[rec_bytes_index+3] <= data[7:0];
                    rec_bytes_index             <= rec_bytes_index+4;
                    valid                       <= rx_data_valid;
                    //���ݵ�ַ�жϷ���Icache����Dcache
                    //���жϷ��ͷ���number�������ж��Ƿ�Ϊ��һ����
                    if(number == 8'h0)begin
                        r_dbus_we     <= 1'b0;
                        r_ibus_addr_o <= addr_i;
                        r_ibus_data_o <= data;
                        if(first != 8'h0)
                          begin
                              r_ibus_we <= 1'b1;
                              addr_i    <= addr_i+4;
                          end
                        else
                          r_ibus_we <= 1'b0;
                    end
                    else if(number == 8'hff) begin
                        r_ibus_we     <= 1'b0;
                        r_dbus_addr_o <= addr_d;
                        r_dbus_data_o <=data;
                        if(first != 8'hff)
                          begin
                              r_dbus_we <= 1'b1;
                              addr_d    <= addr_d+4;
                          end
                        else
                          r_dbus_we <= 1'b0;
                    end
                    else begin                    
                        r_ibus_we     <= 1'b0;
                        r_ibus_addr_o <= 32'b0;
                        r_ibus_data_o <= 32'b0;
                        r_dbus_we     <= 1'b0;
                        r_dbus_addr_o <= 32'b0;
                        r_dbus_data_o <= 32'b0;
                        tx_data       <= 8'b0;
                        tx_data_valid <= 1'b0;
                        data          <= 32'b0;
                        count         <= 8'b0;
                    end
                    if(count < 8'd128)
                        count         <= count+1;
                end
                CRC1:     begin
				    r_ibus_we       <= 1'b0;
                    r_dbus_we       <= 1'b0;
                    r_crc_16[7:0]  <= rx_data;
                end
                CRC_START:begin
                    r_ibus_we      <= 1'b0;
                    r_dbus_we      <= 1'b0;
                    r_crc_16[15:8] <= rx_data;
                end
                SENDRSP:      begin
                    r_ibus_we     <= 1'b0;
                    r_dbus_we     <= 1'b0;
                    tx_data_valid <= 1'b1;
                    tx_data       <= (crc_result == r_crc_16)?UART_RESP_ACK:UART_RESP_NAK;
                end
                default:  begin
                    r_ibus_we     <= 1'b0;
                    r_ibus_addr_o <= 32'b0;
                    r_ibus_data_o <= 32'b0;
                    r_dbus_we     <= 1'b0;
                    r_dbus_addr_o <= 32'b0;
                    r_dbus_data_o <= 32'b0;
                    tx_data       <= 8'b0;
                    tx_data_valid <= 1'b0;
                    //data          <= 32'b0;//change
                    count         <= 8'b0;
                end 
            endcase
        end
    end
    //-----{ʱ���߼�����ÿ��״̬����������ж�}end

    assign o_ibusWe_1     = r_ibus_we;
    assign o_ibusAddr_32 = r_ibus_addr_o;
    assign o_ibusData_32 = r_ibus_data_o;
    assign o_dbusWe_1     = r_dbus_we;
    assign o_dbusAddr_32 = r_dbus_addr_o;
    assign o_dbusData_32 = r_dbus_data_o;
    
    //-----{CRC����}begin
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            need_to_rec_bytes <= 8'h0;
        end else begin
            need_to_rec_bytes <= UART_REMAIN_PACKET_LEN;
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            crc_result <= 16'h0;
        end else begin
            case (c_state)
                CRC_START: begin
                    crc_result <= 16'hffff;
                end
                CRC_CALC: begin
                    if (crc_bit_index == 4'h0) begin
                        crc_result <= crc_result ^ crc_data[crc_byte_index];
                    end else begin
                        if (crc_bit_index < 4'h9) begin
                            if (crc_result[0]) begin
                                crc_result <= {1'b0, crc_result[15:1]} ^ 16'ha001;
                            end else begin
                                crc_result <= {1'b0, crc_result[15:1]};
                            end
                        end
                    end
                end
            endcase
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            crc_bit_index <= 4'h0;
        end else begin
            case (c_state)
                CRC_START: begin
                    crc_bit_index <= 4'h0;
                end
                CRC_CALC: begin
                    if (crc_bit_index < 4'h9) begin
                        crc_bit_index <= crc_bit_index + 1'b1;
                    end else begin
                        crc_bit_index <= 4'h0;
                    end
                end
            endcase
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            crc_byte_index <= 8'h0;
        end else begin
            case (c_state)
                CRC_START: begin
                    crc_byte_index <= 8'h0;
                end
                CRC_CALC: begin
                    if (crc_bit_index == 4'h0) begin
                        crc_byte_index <= crc_byte_index + 1'b1;
                    end
                end
            endcase
        end
    end
    //-----{CRC����}end
    
uart_rx#
(
    .CLK_FRE(FREQ),
    .BAUD_RATE(115200)
) uart_rx_inst
(
    .clk                        (clk                      ),
    .rst                      (rst                     ),
    .o_rxData_8                    (rx_data                  ),
    .o_rxDataValid_1              (rx_data_valid            ),
    .i_rxDataReady_1              (1'b1                     ),
    .i_rxPin_1                     (i_uartRx_1                  )
);

uart_tx#
(
    .CLK_FRE(FREQ),
    .BAUD_RATE(115200)
) uart_tx_inst
(
    .clk                        (clk                      ),
    .rst                      (rst                     ),
    .i_txData_8                    (tx_data                  ),
    .i_txDataValid_1              (tx_data_valid            ),
    .o_txDataReady_1              (tx_data_ready            ),
    .o_txPin_1                     (o_uartTx_1                  )
);
reg r_init_1;
    assign o_initSig_1 = r_init_1;
    wire w_finish = first == size & number == 8'hff & c_state == WAITSEND & tx_data_ready;
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            r_init_1 <= 1'b1;
        end else begin
            if(w_finish) begin
                r_init_1 <= 1'b0;
            end else begin
                r_init_1 <= 1'b1;
            end
        end

    end
endmodule

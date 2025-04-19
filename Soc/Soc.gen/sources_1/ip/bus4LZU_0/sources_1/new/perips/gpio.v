`timescale 1ns / 1ps

module gpio
#(
    parameter GPIO_NUM = 16
)
(

    input         clk,
    input         rst,
    
     //�������ߵ��ź�
    input wire      i_cs_1,
    input wire      i_as_1,
    input wire      i_rw_1,
    
    //���������
    output reg      o_rdy_1,   
        
//    input         we_i,
    input  [31:0] i_addr_32,
    input  [31:0] i_data_32,
    output [31:0] o_data_32,

    output [31:0] o_gpioCtrl_32,
    output [31:0] o_gpioData_32,
               
    inout  [GPIO_NUM-1:0] io_ioPin_16
    );


    // GPIO���ƼĴ���
    localparam GPIO_CTRL = 4'h0;
    // GPIO���ݼĴ���
    localparam GPIO_DATA = 4'h4;

    // 1�����,0������
    reg[31:0] gpio_ctrl;
    // �����������
    reg[31:0] gpio_data;
    //gpio_data����
    
    reg write_reg_ctrl_en;
    reg write_reg_data_en;

    assign o_gpioCtrl_32 = gpio_ctrl;
    assign o_gpioData_32 = gpio_data;

    genvar i; 
   generate
       for(i=0;i<32;i=i+1)
       begin: io_ctrlpin
            assign io_ioPin_16[i] = gpio_ctrl[i] ? gpio_data[i] : 1'bz;
       end
    endgenerate

// ����ʹ���ź�
    // �����ڼ�һֱ��Ч
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            write_reg_ctrl_en<=1'b0;
            write_reg_data_en<=1'b0;
            o_rdy_1<=1'b1;
        end else begin
            /*�����ź�����*/
            if((i_cs_1 == 1'b0)&&(i_as_1==1'b0))begin//�Ķ�
                o_rdy_1<= 1'b0;
            end else begin
                o_rdy_1<=1'b1;
            end
            if ((i_cs_1==1'b0)&&(i_as_1==1'b0)) begin
                write_reg_ctrl_en<=i_rw_1 & (i_addr_32[3:0] == GPIO_CTRL);
                write_reg_data_en<=i_rw_1 & (i_addr_32[3:0] == GPIO_DATA);
            end else begin
                write_reg_ctrl_en<=1'b0;
                write_reg_data_en<=1'b0;
            end
        end
    end
    //gpio_data����
    generate
       for(i=0;i<GPIO_NUM;i=i+1)
       begin: io_ctrl
            always@(posedge clk or negedge rst) begin
                if(!rst) begin
                    gpio_data[i] <= 1'b0;
                end else begin
                    if(write_reg_data_en & gpio_ctrl[i]) begin
                        gpio_data[i] <= i_data_32[i];
                    end
                    if(~gpio_ctrl[i]) begin 
                        gpio_data[i] <= io_ioPin_16[i];
                        /*if(i_ioPin_16[i])
                            gpio_data[i] <= 1'b1;
                        else
                            gpio_data[i] <= 1'b0;*/
                    end 
 
                end    
             end
       end
    endgenerate

    // gpio_ctrl ����
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            gpio_ctrl <= 32'h0;
        end else begin
            if (write_reg_ctrl_en) begin
                  gpio_ctrl <= i_data_32;
            end 
            else begin 
                  gpio_ctrl <= gpio_ctrl;
            end
        end
    end

    assign o_data_32 = (i_addr_32[3:0] == GPIO_CTRL) ? gpio_ctrl:
                    (i_addr_32[3:0] == GPIO_DATA) ? gpio_data : 32'b0 ;

endmodule

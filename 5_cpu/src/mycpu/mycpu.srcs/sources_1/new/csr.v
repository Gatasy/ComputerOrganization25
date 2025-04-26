`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// �򻯰� csr.v������ԭ���쳣�߼���������·���жϣ�SWIO=0, Timer=11�������� ESTAT_IS[1:0] ��¼
//////////////////////////////////////////////////////////////////////////////////
module csr(
    input  wire        clk,             // ʱ��
    input  wire        rst_n,           // ����Ч��λ
    input  wire        exception,       // ���� decode ��ͬ���쳣
    input  wire        interrupt,       // ���� decode �����ж�����
    input  wire [7:0]  index,           // [3:0]=�쳣��, [7:4]=�жϺ� (0=SWIO,11=Timer)
    input  wire [31:0] pc,              // �����쳣/�ж�ʱ�� PC

    output wire [32:0] j_exception_addr // {1��b1, 32 λ��ת��ַ}
);

  // ------------------------------------------------------------------------
  // 1. CSR �ڲ��Ĵ���
  // ------------------------------------------------------------------------
  reg [31:0] ERA;        // ���ص�ַ (EPC)
  reg [31:0] EENTRY;     // �쳣/�ж���ڻ�ַ��LoongArch �򻯰�Ĭ��Ϊ 0x0��
  reg [1:0]  ESTAT_IS;   // ����λ��bit0=SWIO (int#0), bit1=Timer (int#11)

  // ------------------------------------------------------------------------
  // 2. ͨ��������ڼ��� (VS=0)
  // ------------------------------------------------------------------------
  wire        is_ertn = exception && (index[3:0] == 4'b1000);
  // ecode = �쳣 ? exc_code : �ж� ? (64 + int_number) : 0
  wire [6:0]  ecode = is_ertn    ? 7'd0
                     : exception  ? index[3:0]
                     : interrupt  ? (7'd64 + index[7:4])
                     : 7'd0;
  wire [31:0] offset = ecode << 2;  // *4

  assign j_exception_addr =
           is_ertn                         ? {1'b1, ERA}                      // ERTN ����
         : (exception || interrupt)        ? {1'b1, EENTRY + offset}          // �쳣/�ж����
         : 33'b0;

  // ------------------------------------------------------------------------
  // 3. ͬ���߼������� ERA��EENTRY��ESTAT_IS
  // ------------------------------------------------------------------------
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ERA        <= 32'b0;
      EENTRY     <= 32'b0;   // ��ַĬ��Ϊ 0x0
      ESTAT_IS   <= 2'b00;   // ��� SWIO/Timer��־
    end
    else if (is_ertn) begin
      // ERTN�������������жϱ�־
      ESTAT_IS   <= 2'b00;
    end
    else if (exception) begin
      // ͬ���쳣��������һ��ָ���ַ
      ERA        <= pc + 4;
      // EENTRY ���� 0x0
    end
    else if (interrupt) begin
      // ���жϣ����淵�ص�ַ������ ESTAT_IS ����Ӧλ
      ERA        <= pc + 4;
      // SWIO (int_number=0) �� ESTAT_IS[0], Timer (int_number=11) �� ESTAT_IS[1]
      ESTAT_IS[0] <= (index[7:4] == 4'd0);
      ESTAT_IS[1] <= (index[7:4] == 4'd11);
    end
    else begin
      // ���¼������ֲ���
      ERA        <= ERA;
      EENTRY     <= EENTRY;
      ESTAT_IS   <= ESTAT_IS;
    end
  end

endmodule

// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Tue May 28 11:12:57 2024
// Host        : hyt running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               f:/VCode/mycpu/mycpu.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]doutb;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.68295 mW" *) 
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_7 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[31:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jLV29U0rrfMIZhYJzdoUrPoqB9eHQ5NXmWyCdqnN3Wgm+GU4C3zthrN1m4QGiaj0thPCIynZbX+0
7yjtkv+T5ByJ6NhiofAwWseGLvPXlYu6ERAPvi4SAYpF2VUqQHtPAbPmnPubGdDRgIEpeobF7hsz
rEcpEru1pyiScUriyuo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vsoizVrOONWw/DhjRLEYrtRmtji+Ok63CbpSg/l9VnoKAi8tAzqRbQ57atGB2N6IGGbKHkbK2Uzh
EHgWvYZeyt4hE+bpQX91vc9PNxfjQMGzPoFD3jCWk30EmEk+AND39eWx+DhJ8xhFuucoOQ2GwyAk
B+Mjs15naPE7DvlHel8hnD4dfSdYhGKp96oozu8JeBto8aHG6poOuYkxSwaut7NCI+mabCkMxtMp
RrydgmRuTvhRTbJMyx5CxFSZTRDrS5aU1vaRlnMiqKCI7g2KY9pemYaJsFeVodBuo6IyKGynyEhs
wr+VtUhQDtaVhMkwB95WwmMoDk9F2L5Au1I+TQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
W081dPMCWhKs5YlQD7n3zvf7+PTcnb8eFWxoVs8+zHLkxDMA1klITbsfztGYvJFce8Yao5XQLLqZ
oUE5Pq2arq+zwICFUcLjdMsmP1WmL82znHOPHm83zNwrxWMloHkySAqzFbgJeHa973uZqj0M8ydc
sYmzCYVlGVjt0QX0xqA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Zpc3MmdLWaVOv+S4z2POuoyslYoAbWc+Npxq2UyQRtDwf566IId3uwAetolMAgfLo/G3ezuSOXMn
8NznS37h9XvmVrxA50SAux68P87WgkLtiUYqM3CMBKkxNlZ/TR8WzTuQyFdvzkOE9lp8HC7LXnk5
RDsnOM+su46FW7ysY01COslo9Xc7rhs6WFqx29+Xcqk8+ZMLSzaJfuwZdNmJFS3Q1vhlq3ZeYqMl
wMieB731KsPxjxp7VKNHpTbgFryC2isqc4ohBDOt52M/Bz4B/rIpFeHfZ7X3jWSiKtSuBsDN2NXf
EMjfAT248dlK7NxJ+NBNPhS5sLxTiGyQhta57A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rPMYqnkKhJKV1wltOfDrKos9ZbucaoX3WGTuqsdLkGpcKObzslHBwlGrKtWV7bZYmS2SM+QuEMfa
CE+tCUdsSiprp+n5BuSQlJa6BJ8mlqccjoo/JLw2QEmUhyMXQ3TLGomGGoZdeTmMPXhUBAOyLPea
Ddc8mgtTN8Kpy117GOTXDKP+IKJqW01fLrPJpgEhFiJCbyElLgtCRWmI94gX+y4XNVS0Cd1YwNw6
4nHgnEdC7fXARDKcYO3VsWC/pdzPQgursXloNLrVYa6i2xr+8E1V0+nSWwNYQZP7XUIVqXKMU8Ea
bT4acXrRCF/5tJJ5B9JparYI0zxXSbaakn1dIw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mfroTgL8g2pyIXQ/mGO9YHm19cd5mOlJ++qpusOYeVxGmkIhvF4aKx+AyIUz2yGGAeCtOzIasHty
pyqKgZhibSqxcpHgR0m6GOxXXOXJiHaK8NzxUzXeRJovcBI/WjtDhXeb1LRMI1J97jVBtJPJQH0Y
fGOD7jWvkvQwxnrZdyLp6kPWgSIcavHHDbO7iJv4gnyGp6W3/FCDo2RKWNLoW+SNjSdLZ6YRP8a+
ldaGU8TYvJ03KWlmik7repuN6AwxCjg2KeQ+x1sBAEXzROXomuSbvX3ZAo8UiIKAQY1SJumHLG3L
QI/S4Wbl1Hz6LDTsttMwP480gq6+tb6s1E4oWw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QJIabgm8dx/gVHbOQFwt8maOKVHFgkpZTPR6dzD8fqoGo9M9oGPTqBqchtPZWgv2UYFF2KEUSlV4
L3SDXBKrLs+NsAVTcICaEMiEi6j82zj/C1LsPkQfS8RLrg0ab8lbDMb5YqJ7lkHs3iM65x2iN1Mf
66cTgCbkAdl3rDpab75btpTQt5ZKiq5CSY3RZfyIW0uWbTGTELm6liuRKM9+K8BQwTU7A+FFFQBA
/9eJwQYzNNA/iwoYJ2WTPd6pBlzXriNLu9M+/2bYicNBSuH1PBR9v2ESrTB6k7EiV1zvBXV9NuG/
sFt4MumWMuSNwP2W38bQATxxW/l0IrmaXGOC/w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
lhKf/Vgj6pHpme1ji4HVe36BU8pMkam/2I9lFeyOiBnIbzgdEGfLJBcEvkL33A7s0hxa6LFbHnkT
upgMpPjmIghBz3xUQ13vpiY152thFec6qvlcdg1r+GTmnBOSFl6g/OfZ3eFUhfsve6ZjQHpXnKFo
a55hN2+eP1EG9+VxGeM7XkHaeFhEIry52qtnmg072KEFIwRiGs2d/TJ4AqupuIdIiP1kTN9k+oqa
2ta1vdtqPY0dDHqrf+5YSd0CejkhQeCqg/bauLP3755SwdOPRgooG5ANT8hUpTiFMFXtU+GC9NSp
evJtMHUy1NbgMmhFHO+w3URLEdjSaBxZPD7YLdWkF65jY526tJzoek+BzEKoBaGfCaY7O1nHKXm+
89k3rPUy0Xo4/0nHpno+N/Db09heJPbnGsCwN/l+KnR6Lz8kvWziBjZe0ijOkKI+T12y3T1VeOtY
H/aqtNlQt1mhFwrbw6ezaAiDPVbCQXnly6b4tbb8+nFsxWOGIGAfLozB

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PNsQ8uEcQYrl+GaDuBaq1tQ5br5aAdaqHnyrc0NVu/JnQUk53jaiLx8Oz5fNACvWelUUk2/C+P5I
b2rbU1bb/dC6TqC5J1N0yoMYRYw58u4Lrl8Kgqgt9Rlph5Qgzzfxp+oblXF/pO4mRyAXpZhpNkFT
0Ar9BUtPOTOtJ9/g53SRnZ6GjxzfeD+25J4fcXBNo2gCTgUkwiLSsJRwTB/cJmn+dZPwPdIOHEP9
TkfDK+OrbLYO3T+DFBTCMRNH2NB1J9sc5s+nPU8iYnjgPTo6HoGW+LIlCz6yNJMZzJzoeW708utc
0fJXkT7vLDVh7olvy3V9AAY8Do0YR1kiZlhVhQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
zAz8RnGHFebkJFAS+gjC+mXHW7m7We+JgSmIz15mS01u/4+9Ng0sJfkeXOClmVPTQ2Mp2Yuv6/6f
ehzUTcANilWsqLM6Q1FToCPNX/NTqodlcHirGM7b5R9yevouNT/aqH12nmbunBQmBHmehNutdCjG
r6Z7kZgeZ2ZE7MMOF0rTy1XHEPkqgMNTRoS8R/pPWPTW4/j+bn3aJj0Q/fTz4Gi3mbSUKWs2fREQ
UKiuolNJkN6DiDvhlVYHUyytXNJG44ikmBXehoQQRLapkYaxnQmMRT1ok9uY6pKoy71CtvJ3Mt2x
EQv1GU2i4qQyAOwa0mkEohWXduicU6tDz3zQwQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TK3eE9V+v1z2P1KjG4GrjhA1n3qDOpNzLGXdtjnjhF0QBFPSuhC+nmNqTPOb3p2a9r5KD0miY3Cd
+KpjH6Ao09E2/LD2Go4aLQh6vP+9BldlSKEwCGfx2NjBQrXWVH21lQR7IRjOvyTOclpd7SgtUJLw
dvebETyLiKr9C6RfnIBeptuCA3iJlXfwkh6I0JfzD5WBizQkotioZmmrXv5105pCXQ4Ta1WThFsA
2ll9dZeSjEDHUxxhfyfjryv9m4VL89ZDU/rGITsdptwB1BC1jLqmPDymY05lyECnjA6NIR5GGfI4
K2y2f4GfikKoN5r9IOvFzw963Wm82ZZPtXOKGg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20880)
`pragma protect data_block
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
8QNArZ80Q/lIbvsm0jp/E1Md
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

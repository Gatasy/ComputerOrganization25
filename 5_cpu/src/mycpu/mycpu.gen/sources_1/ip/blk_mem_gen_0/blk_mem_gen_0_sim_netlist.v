// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Tue May 28 11:11:33 2024
// Host        : hyt running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               f:/VCode/mycpu/mycpu.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [8:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire [0:0]wea;
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
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
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
  (* C_BYTE_SIZE = "9" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.64395 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
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
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_7 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
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
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19536)
`pragma protect data_block
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
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

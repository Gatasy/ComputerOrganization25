// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Wed Apr 23 21:15:19 2025
// Host        : DESKTOP-L1Ul0lBY running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/NItemp/25CourseComputerArchitecture/ComputerOrganization25/RV32VI_CPU_new/RV32VI_CPU.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_stub.v
// Design      : blk_mem_gen_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_8,Vivado 2024.1" *)
module blk_mem_gen_1(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="ena,addra[14:0],douta[31:0]" */
/* synthesis syn_force_seq_prim="clka" */;
  input clka /* synthesis syn_isclock = 1 */;
  input ena;
  input [14:0]addra;
  output [31:0]douta;
endmodule

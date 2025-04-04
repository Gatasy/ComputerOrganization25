## 时钟信号
# 时钟输入
set_property PACKAGE_PIN AC19 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## 复位信号
# 复位输入 (低电平有效)
set_property PACKAGE_PIN Y3 [get_ports resetn]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]

## 拨码开关 (input_sel[2:0])
# 拨码开关用于选择输入数
set_property PACKAGE_PIN AD24 [get_ports {input_sel[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_sel[0]}]

set_property PACKAGE_PIN AC21 [get_ports {input_sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_sel[1]}]

set_property PACKAGE_PIN AB21 [get_ports {input_sel[2]}]  # 添加 input_sel[2]
set_property IOSTANDARD LVCMOS33 [get_ports {input_sel[2]}]

## LED 指示灯 (led_overflow)
# LED 指示灯用于显示溢出标志
set_property PACKAGE_PIN H7 [get_ports led_overflow]
set_property IOSTANDARD LVCMOS33 [get_ports led_overflow]

## LCD 控制信号
# LCD 控制信号用于控制 LCD 显示
set_property PACKAGE_PIN J25 [get_ports lcd_rst]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rst]

set_property PACKAGE_PIN H18 [get_ports lcd_cs]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_cs]

set_property PACKAGE_PIN K16 [get_ports lcd_rs]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rs]

set_property PACKAGE_PIN L8 [get_ports lcd_wr]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_wr]

set_property PACKAGE_PIN K8 [get_ports lcd_rd]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rd]

set_property PACKAGE_PIN J15 [get_ports lcd_bl_ctr]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_bl_ctr]

## LCD 数据总线 (lcd_data_io[15:0])
# LCD 数据总线用于传输显示数据
set_property PACKAGE_PIN H9 [get_ports {lcd_data_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[0]}]

set_property PACKAGE_PIN K17 [get_ports {lcd_data_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[1]}]

set_property PACKAGE_PIN J20 [get_ports {lcd_data_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[2]}]

set_property PACKAGE_PIN M17 [get_ports {lcd_data_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[3]}]

set_property PACKAGE_PIN L17 [get_ports {lcd_data_io[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[4]}]

set_property PACKAGE_PIN L18 [get_ports {lcd_data_io[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[5]}]

set_property PACKAGE_PIN L15 [get_ports {lcd_data_io[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[6]}]

set_property PACKAGE_PIN M15 [get_ports {lcd_data_io[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[7]}]

set_property PACKAGE_PIN M16 [get_ports {lcd_data_io[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[8]}]

set_property PACKAGE_PIN L14 [get_ports {lcd_data_io[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[9]}]

set_property PACKAGE_PIN M14 [get_ports {lcd_data_io[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[10]}]

set_property PACKAGE_PIN F22 [get_ports {lcd_data_io[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[11]}]

set_property PACKAGE_PIN G22 [get_ports {lcd_data_io[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[12]}]

set_property PACKAGE_PIN G21 [get_ports {lcd_data_io[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[13]}]

set_property PACKAGE_PIN H24 [get_ports {lcd_data_io[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[14]}]

set_property PACKAGE_PIN J16 [get_ports {lcd_data_io[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_io[15]}]

## LCD 触摸接口
# LCD 触摸接口用于接收触摸输入
set_property PACKAGE_PIN L19 [get_ports ct_int]
set_property IOSTANDARD LVCMOS33 [get_ports ct_int]

set_property PACKAGE_PIN J24 [get_ports ct_sda]
set_property IOSTANDARD LVCMOS33 [get_ports ct_sda]

set_property PACKAGE_PIN H21 [get_ports ct_scl]
set_property IOSTANDARD LVCMOS33 [get_ports ct_scl]

set_property PACKAGE_PIN G24 [get_ports ct_rstn]
set_property IOSTANDARD LVCMOS33 [get_ports ct_rstn]

vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/blk_mem_gen_v8_4_8
vlib modelsim_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_8 modelsim_lib/msim/blk_mem_gen_v8_4_8
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_8  -incr -mfcu  "+incdir+../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/header" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/header" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/ip/Sram/sim/Sram.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/bus_addr_decoder.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/bus_slave_mux.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/bus_top.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/data_init.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/data_mux.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/gpio.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/slot/memory_slot.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/spi.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/timer.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/uart_rx.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/uart_top.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/perips/uart_tx.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sources_1/new/soc_core.v" \
"../../../../Soc.gen/sources_1/ip/bus4LZU_0/sim/bus4LZU_0.v" \

vlog -work xil_defaultlib \
"glbl.v"


transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+bus4LZU_0  -L blk_mem_gen_v8_4_8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.bus4LZU_0 xil_defaultlib.glbl

do {bus4LZU_0.udo}

run 1000ns

endsim

quit -force

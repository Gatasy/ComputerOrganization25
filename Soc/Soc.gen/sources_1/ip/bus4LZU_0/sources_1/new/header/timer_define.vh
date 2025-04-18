`define TIMER_ADDR_W 2
`define TimerAddrBus 1:0
`define TimerAddrLoc 1:0
`define TIMER_ADDR_CTRL 2'h0
`define TIMER_ADDR_INTR 2'h1
`define TIMER_ADDR_EXPR 2'h2
`define TIMER_ADDR_COUNTER 2'h3
`define TimerStartLoc 0
`define TimerModeLoc 1
`define TIMER_MODE_ONE_SHOT 1'b0
`define TIMER_MODE_PERIODIC 1'b1
`define TimerIrqLoc 0


`define ENABLE 1'b1
`define ENABLE_ 1'b0
`define DISABLE 1'b0
`define DISABLE_ 1'b1
`define RESET_ENABLE 1'b0
`define RESET_EDGE 1'b0
`define WORD_DATA_W 32


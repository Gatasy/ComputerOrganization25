
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:062

00:00:062	
531.4142	
199.633Z17-268h px� 
�
Command: %s
1870*	planAhead2l
jread_checkpoint -auto_incremental -incremental E:/NItemp/ALU1/ALU.srcs/utils_1/imports/synth_1/display.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2=
;E:/NItemp/ALU1/ALU.srcs/utils_1/imports/synth_1/display.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
d
Command: %s
53*	vivadotcl23
1synth_design -top display -part xc7a200tfbg676-2LZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a200tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a200tZ17-349h px� 
F
Loading part %s157*device2
xc7a200tfbg676-2LZ21-403h px� 
\
$Part: %s does not have CEAM library.966*device2
xc7a200tfbg676-2LZ21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
15020Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1442.301 ; gain = 449.895
h px� 
�
.redeclaration of ANSI port '%s' is not allowed7382*oasys2
judge2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
3058@Z8-11121h px� 
�
synthesizing module '%s'%s4497*oasys2	
display2
 23
/E:/NItemp/ALU1/ALU.srcs/sources_1/new/display.v2
18@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
ALU2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
5598@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
CLA_add_32bit2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1558@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
Adder_16bit2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1068@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
CLA_add_4bit2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
598@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	fullAdder2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
228@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	fullAdder2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
228@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

CLA_4bit2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
378@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

CLA_4bit2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
378@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
CLA_add_4bit2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
598@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
Adder_16bit2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1068@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
CLA_add_32bit2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1558@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
AND322
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1938@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
AND322
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
1938@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OR322
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2068@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OR322
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2068@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
XOR322
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2198@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
XOR322
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2198@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
NOT322
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2328@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
NOT322
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2328@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	shifter322
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2458@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	shifter322
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2458@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
Truncate_32bit2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
4968@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
Cut_decoder2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
Cut_decoder2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
2928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
CutL2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
3408@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
CutL2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
3408@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
CutR2
 2/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
4188@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
CutR2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
4188@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
Truncate_32bit2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
4968@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ALU2
 2
02
12/
+E:/NItemp/ALU1/ALU.srcs/sources_1/new/ALU.v2
5598@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

lcd_module2
 2`
\E:/NItemp/ALU1/ALU.runs/synth_1/.Xil/Vivado-13396-DESKTOP-Q2UBS45/realtime/lcd_module_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

lcd_module2
 2
02
12`
\E:/NItemp/ALU1/ALU.runs/synth_1/.Xil/Vivado-13396-DESKTOP-Q2UBS45/realtime/lcd_module_stub.v2
68@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
display2
 2
02
123
/E:/NItemp/ALU1/ALU.srcs/sources_1/new/display.v2
18@Z8-6155h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[2]2	
displayZ8-7129h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[1]2	
displayZ8-7129h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[0]2	
displayZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1567.125 ; gain = 574.719
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1567.125 ; gain = 574.719
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1567.125 ; gain = 574.719
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0182

1567.1252
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
r
Parsing XDC File [%s]
179*designutils21
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc8Z20-179h px� 
�
.Invalid option value '%s' specified for '%s'.
161*common2
#2	
objects21
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc2
198@Z17-161h px�
�
No ports matched '%s'.
584*	planAhead2
led_overflow21
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc2
248@Z12-584h px�
�
No ports matched '%s'.
584*	planAhead2
led_overflow21
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc2
258@Z12-584h px�
{
Finished Parsing XDC File [%s]
178*designutils21
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc8Z20-178h px� 
�
�One or more constraints failed evaluation while reading constraint file [%s] and the design contains unresolved black boxes. These constraints will be read post-synthesis (as long as their source constraint file is marked as used_in_implementation) and should be applied correctly then. You should review the constraints listed in the file [%s] and check the run log file to verify that these constraints were correctly applied.301*project2/
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc2
.Xil/display_propImpl.xdcZ1-498h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2/
-E:/NItemp/ALU1/ALU.srcs/constrs_1/new/ALU.xdc2
.Xil/display_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1585.6482
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0042

1585.6482
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Loading part: xc7a200tfbg676-2L
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 31    
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   3 Input      1 Bit         XORs := 32    
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 32    
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               40 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 2     
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   38 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input   38 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input   32 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 64    
h p
x
� 
F
%s
*synth2.
,	   9 Input    1 Bit        Muxes := 1     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
s
%s
*synth2[
YPart Resources:
DSPs: 740 (col length:100)
BRAMs: 730 (col length: RAMB18 100 RAMB36 50)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[2]2	
displayZ8-7129h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[1]2	
displayZ8-7129h px� 
v
9Port %s in module %s is either unconnected or has no load4866*oasys2
input_sel[0]2	
displayZ8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:14 ; elapsed = 00:00:14 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|      |BlackBox name |Instances |
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|1     |lcd_module    |         1|
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
6
%s*synth2
+------+-----------+------+
h px� 
6
%s*synth2
|      |Cell       |Count |
h px� 
6
%s*synth2
+------+-----------+------+
h px� 
6
%s*synth2
|1     |lcd_module |     1|
h px� 
6
%s*synth2
|2     |BUFG       |     1|
h px� 
6
%s*synth2
|3     |LUT1       |     1|
h px� 
6
%s*synth2
|4     |LUT2       |     1|
h px� 
6
%s*synth2
|5     |LUT6       |     5|
h px� 
6
%s*synth2
|6     |FDCE       |     6|
h px� 
6
%s*synth2
|7     |IBUF       |     2|
h px� 
6
%s*synth2
|8     |OBUF       |     8|
h px� 
6
%s*synth2
+------+-----------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 4 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:15 ; elapsed = 00:00:20 . Memory (MB): peak = 1585.648 ; gain = 574.719
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1585.648 ; gain = 593.242
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1585.6482
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1585.6482
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

1d640664Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
542
112
12
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:252

00:00:272

1585.6482

1049.461Z17-268h px� 
c
%s6*runtcl2G
ESynthesis results are not added to the cache due to CRITICAL_WARNING
h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0012

1585.6482
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2-
+E:/NItemp/ALU1/ALU.runs/synth_1/display.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2Y
Wreport_utilization -file display_utilization_synth.rpt -pb display_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Dec 12 12:58:52 2024Z17-206h px� 


End Record
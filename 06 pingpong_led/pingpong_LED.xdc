### Clock Source
#set_property PACKAGE_PIN Y9 [get_ports {clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_IBUF]

## buttom
#set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports {reset}]
#set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {btn1}]
#set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {btn2}]

## sw
#set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
#set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
#set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
#set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]
 
## led
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
#set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {led[6]}] 
#set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS33} [get_ports {led[5]}] 
#set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
#set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {led[3]}]  
#set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {led[2]}] 
#set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33}  [get_ports {led[1]}] 
#set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {led[0]}] 

## PL1_ssd (a to g) pin 13 15 19 21 23 29 31
#set_property -dict {PACKAGE_PIN AB9 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[6]}] 
#set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[5]}] 
#set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[4]}]
#set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[3]}]  
#set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[2]}] 
#set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVCMOS33}  [get_ports {PL1_ssd[1]}] 
#set_property -dict {PACKAGE_PIN AA4 IOSTANDARD LVCMOS33} [get_ports {PL1_ssd[0]}] 

## PL2_ssd (a to g) pin 8 10 12 16 18 22 24
#set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[6]}]  
#set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[5]}]  
#set_property -dict {PACKAGE_PIN AA7 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[4]}] 
#set_property -dict {PACKAGE_PIN AB2 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[3]}] 
#set_property -dict {PACKAGE_PIN AB1 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[2]}] 
#set_property -dict {PACKAGE_PIN AB5 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[1]}] 
#set_property -dict {PACKAGE_PIN AB4 IOSTANDARD LVCMOS33} [get_ports {PL2_ssd[0]}] 



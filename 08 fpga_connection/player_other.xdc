# set_property PACKAGE_PIN Y9 [get_ports {clk_100MHz}] 
# set_property IOSTANDARD LVCMOS25 [get_ports {clk_100MHz}] 
# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_IBUF]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVCMOS25} [get_ports {clk_100MHz_in}]
set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS25} [get_ports {sw_start}]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS25} [get_ports {pl2}]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS25} [get_ports {ledout[0]}]
set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS25} [get_ports {ledout[1]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS25} [get_ports {ledout[2]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS25} [get_ports {ledout[3]}]
set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS25} [get_ports {ledout[4]}]
set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS25} [get_ports {ledout[5]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS25} [get_ports {ledout[6]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS25} [get_ports {ledout[7]}]
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS25} [get_ports {sda}]
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS25} [get_ports {reset_in}]



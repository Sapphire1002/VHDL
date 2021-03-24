set_property PACKAGE_PIN Y9 [get_ports {clk_100MHz}] 
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100MHz}] 
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_IBUF]
set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports {reset}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports {mode_sw}]


set_property -dict {PACKAGE_PIN AA4 IOSTANDARD LVCMOS33} [get_ports {video_clk}
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {video_sda}
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {video_scl}
set_property -dict {PACKAGE_PIN Y5 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[0]}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[2]}]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[4]}]
set_property -dict {PACKAGE_PIN AB9 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[6]}]
set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[1]}]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[3]}]
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[5]}]
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports {video_data_i2c[7]}]



set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS33} [get_ports {hsync}]
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {vsync}]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {led1}]
set_property PACKAGE_PIN Y9 [get_ports {clk}]
set_property IOSTANDARD LVCMOS25 [get_ports {clk}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_IBUF]

set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS25} [get_ports {reset}]

set_property -dict {PACKAGE_PIN Y5 IOSTANDARD LVCMOS25} [get_ports {h_sync}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS25} [get_ports {v_sync}]

set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS25} [get_ports {b}]
set_property -dict {PACKAGE_PIN AB9 IOSTANDARD LVCMOS25} [get_ports {g}]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS25} [get_ports {r}]
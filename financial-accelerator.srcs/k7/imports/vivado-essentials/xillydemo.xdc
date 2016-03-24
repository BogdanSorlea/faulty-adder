create_clock -name sys_clk -period 10 [get_pins -match_style ucf */pcieclk_ibuf/O]

set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]
set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S1]
set_case_analysis 1 [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]
set_case_analysis 0 [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S1]

set_property DONT_TOUCH true [get_cells -of [get_nets -of [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]]]
set_property DONT_TOUCH true [get_cells -hier -filter {name=~*/pipe_clock/pclk_sel*}]

set_false_path -from [get_ports PCIE_PERST_B_LS]

set_property LOC IBUFDS_GTE2_X0Y1 [get_cells -match_style ucf */pcieclk_ibuf]

set_property -dict "LOC L17 IOSTANDARD LVCMOS33 PULLUP true" [get_ports PCIE_PERST_B_LS]

set_property -dict "LOC E17 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[0]"]
set_property -dict "LOC AF14 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[1]"]
set_property -dict "LOC F17 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[2]"]
set_property -dict "LOC W19 IOSTANDARD LVCMOS18" [get_ports "GPIO_LED[3]"]

set_property LOC J4 [get_ports PCIE_RX_P[0]]
set_property LOC L4 [get_ports PCIE_RX_P[1]]
set_property LOC N4 [get_ports PCIE_RX_P[2]]
set_property LOC R4 [get_ports PCIE_RX_P[3]]
set_property LOC J3 [get_ports PCIE_RX_N[0]]
set_property LOC L3 [get_ports PCIE_RX_N[1]]
set_property LOC N3 [get_ports PCIE_RX_N[2]]
set_property LOC R3 [get_ports PCIE_RX_N[3]]
set_property LOC H2 [get_ports PCIE_TX_P[0]]
set_property LOC K2 [get_ports PCIE_TX_P[1]]
set_property LOC M2 [get_ports PCIE_TX_P[2]]
set_property LOC P2 [get_ports PCIE_TX_P[3]]
set_property LOC H1 [get_ports PCIE_TX_N[0]]
set_property LOC K1 [get_ports PCIE_TX_N[1]]
set_property LOC M1 [get_ports PCIE_TX_N[2]]
set_property LOC P1 [get_ports PCIE_TX_N[3]]

set_property LOC H6 [get_ports PCIE_REFCLK_P]
set_property LOC H5 [get_ports PCIE_REFCLK_N]

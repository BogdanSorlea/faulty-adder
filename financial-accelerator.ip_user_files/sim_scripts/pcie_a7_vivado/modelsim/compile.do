vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_core_top.vhd" \

vlog -work xil_defaultlib -64 -incr \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_drp.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_eq.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_rate.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_reset.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_sync.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gtp_pipe_rate.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gtp_pipe_drp.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gtp_pipe_reset.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_user.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pipe_wrapper.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_qpll_drp.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_qpll_reset.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_qpll_wrapper.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_rxeq_scan.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_rx_null_gen.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_rx_pipeline.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_rx.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_top.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_tx_pipeline.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_tx_thrtl_ctl.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_axi_basic_tx.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_7x.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_bram_7x.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_bram_top_7x.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_brams_7x.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_pipe_lane.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_pipe_misc.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_pipe_pipeline.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gt_rx_valid_filter_7x.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gt_top.vhd" \

vlog -work xil_defaultlib -64 -incr \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gt_wrapper.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gt_common.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gtp_cpllpd_ovrd.v" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_gtx_cpllpd_ovrd.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie_top.vhd" \
"../../../ip/pcie_a7_vivado/source/pcie_a7_vivado_pcie2_top.vhd" \
"../../../ip/pcie_a7_vivado/sim/pcie_a7_vivado.vhd" \

vlog -work xil_defaultlib "glbl.v"


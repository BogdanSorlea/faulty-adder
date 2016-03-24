onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pcie_a7_vivado_opt

do {wave.do}

view wave
view structure
view signals

do {pcie_a7_vivado.udo}

run -all

quit -force

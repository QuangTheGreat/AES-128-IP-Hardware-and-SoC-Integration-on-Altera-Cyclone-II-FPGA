onerror {quit -f}
vlib work
vlog -work work AES_128.vo
vlog -work work AES_128.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.AES_Top_vlg_vec_tst
vcd file -direction AES_128.msim.vcd
vcd add -internal AES_Top_vlg_vec_tst/*
vcd add -internal AES_Top_vlg_vec_tst/i1/*
add wave /*
run -all

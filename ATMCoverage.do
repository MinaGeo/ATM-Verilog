vlib work
vlog ATM.v ATMTestBench.v +cover -covercells
vsim -voptargs=+acc work.ATMTestBench -cover
add wave *
coverage save ATMCoverage.ucdb -onexit
run -all
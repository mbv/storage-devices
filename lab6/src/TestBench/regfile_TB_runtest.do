SetActiveLib -work
comp -include "$dsn\src\RegFile.vhd" 
comp -include "$dsn\src\TestBench\regfile_TB.vhd" 
asim +access +r TESTBENCH_FOR_regfile 
wave 
wave -noreg INIT
wave -noreg WDP
wave -noreg WA
wave -noreg RA
wave -noreg WE
wave -noreg RDP

run 1 us
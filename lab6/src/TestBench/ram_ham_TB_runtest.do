SetActiveLib -work
comp -include "$dsn\src\RAM_Ham.vhd" 
comp -include "$dsn\src\TestBench\ram_ham_TB.vhd" 
asim +access +r TESTBENCH_FOR_ram_ham 
wave 
wave -noreg CLK
wave -noreg WR
wave -noreg AB
wave -noreg DB
wave -noreg ER				 

run 100 ns

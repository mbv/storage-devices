SetActiveLib -work
comp -include "$dsn\src\LIFO.vhd" 
comp -include "$dsn\src\TestBench\lifo_TB.vhd" 
asim +access +r TESTBENCH_FOR_lifo 
wave 
wave -noreg CLK
wave -noreg WR
wave -noreg DB
wave -noreg EMPTY
wave -noreg FULL

run 100 ns

SetActiveLib -work
comp -include "$dsn\src\RAM.vhd" 
comp -include "$dsn\src\TestBench\ram_TB.vhd" 
asim +access +r TESTBENCH_FOR_ram 
wave 
wave -noreg CLK
wave -noreg WR
wave -noreg AB
wave -noreg DB

run 100 ns

library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity regfile_tb is
		generic(
		INITREG : STD_LOGIC_VECTOR := "0000";
		n : INTEGER := 2 );
end regfile_tb;

architecture TB_ARCHITECTURE of regfile_tb is
	component regfile
		generic(
		INITREG : STD_LOGIC_VECTOR := "0000";
		n : INTEGER := 2 );
	port(
		INIT : in STD_LOGIC;
		WDP : in STD_LOGIC_VECTOR(INITREG'range);
		WA : in STD_LOGIC_VECTOR(n-1 downto 0);
		RA : in STD_LOGIC_VECTOR(n-1 downto 0);
		WE : in STD_LOGIC;
		RDP : out STD_LOGIC_VECTOR(INITREG'range) );
	end component;


	signal INIT : STD_LOGIC := '0';
	signal WDP : STD_LOGIC_VECTOR(INITREG'range):= "0000";
	signal WA : STD_LOGIC_VECTOR(n-1 downto 0) := "00";
	signal RA : STD_LOGIC_VECTOR(n-1 downto 0) := "00";
	signal WE : STD_LOGIC := '0';

	signal RDP : STD_LOGIC_VECTOR(INITREG'range);

	constant WAIT_Period: time := 10 ns;
begin
	UUT : regfile
		generic map (
			INITREG => INITREG,
			n => n
		)

		port map (
			INIT => INIT,
			WDP => WDP,
			WA => WA,
			RA => RA,
			WE => WE,
			RDP => RDP
		);	 
		
		
   main: process
	begin
		wait for wait_period;
		init <= '1';
		wait for wait_period / 2;
		init <= '0';
		wdp <= "1100";
		wa <= "00";
		we <= '1';
		wait for wait_period / 2;
		we <= '0';
		wdp <= "1010";
		wa <= "01";
		wait for wait_period / 2;
		we <= '1';
		wait for wait_period / 2;
		we <= '0';
		wait for wait_period / 2;
		ra <= "00";
		wait for wait_period;
		ra <= "01";
		wait;
	end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_regfile of regfile_tb is
	for TB_ARCHITECTURE
		for UUT : regfile
			use entity work.regfile(beh);
		end for;
	end for;
end TESTBENCH_FOR_regfile;


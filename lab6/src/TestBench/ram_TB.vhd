library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity ram_tb is
		generic(
		M : INTEGER := 2;
		N : INTEGER := 2 );
end ram_tb;

architecture TB_ARCHITECTURE of ram_tb is
	component ram
		generic(
		M : INTEGER := 2;
		N : INTEGER := 2 );
	port(
		CLK : in STD_LOGIC;
		WR : in STD_LOGIC;
		AB : in STD_LOGIC_VECTOR(M-1 downto 0);
		DB : inout STD_LOGIC_VECTOR(N-1 downto 0) );
	end component;

	signal CLK : STD_LOGIC := '0';
	signal WR : STD_LOGIC := '0';
	signal AB : STD_LOGIC_VECTOR(M-1 downto 0);
	signal DB : STD_LOGIC_VECTOR(N-1 downto 0);	  
	
	constant CLK_period: time := 10 ns;
begin
	UUT : ram
		generic map (
			M => M,
			N => N
		)

		port map (
			CLK => CLK,
			WR => WR,
			AB => AB,
			DB => DB
		);
		
	process
	begin
		CLK <= '0';
		wait for CLK_Period/2;
		CLK <= '1';
		wait for CLK_Period/2;
	end process;
	
	main: process
	begin
		wait for CLK_Period;
		AB <= "01";
		DB <= "10";
		wait for CLK_Period;
		AB <= "10";
		DB <= "11";
		wait for CLK_Period;
		WR <= '1';
		DB <= "ZZ";
		AB <= "01";
		wait for CLK_Period;
		DB <= "ZZ";
		AB <= "10";
		wait for CLK_Period;
		
		
		
		AB <= "11";
		DB <= "01";	
		WR <= '0';
		wait for CLK_Period/4;
		DB <= "ZZ";	 
		WR <= '1';
		wait for CLK_Period;		  
		AB <= "11";
		DB <= "01";	
		WR <= '0';
		wait for CLK_Period/2;
		DB <= "ZZ";	 
		WR <= '1';
		wait;
	end process;



end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ram of ram_tb is
	for TB_ARCHITECTURE
		for UUT : ram
			use entity work.ram(beh);
		end for;
	end for;
end TESTBENCH_FOR_ram;


library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram_ham_tb is
		generic(
		m : INTEGER := 2;
		n : INTEGER := 4 );
end ram_ham_tb;

architecture TB_ARCHITECTURE of ram_ham_tb is
	component ram_ham
		generic(
		m : INTEGER := 2;
		n : INTEGER := 4 );
	port(
		CLK : in STD_LOGIC;
		WR : in STD_LOGIC;
		AB : in STD_LOGIC_VECTOR(M-1 downto 0);
		DB : inout STD_LOGIC_VECTOR(N-1 downto 0);
		ER : out STD_LOGIC );
	end component;

	signal CLK : STD_LOGIC := '0';
	signal WR : STD_LOGIC := '0';
	signal AB : STD_LOGIC_VECTOR(M-1 downto 0);
	signal DB : STD_LOGIC_VECTOR(N-1 downto 0);			   
	
	signal ER : STD_LOGIC := '0';

    constant CLK_period: time := 10 ns;
begin
	UUT : ram_ham
		generic map (
			m => m,
			n => n
		)

		port map (
			CLK => CLK,
			WR => WR,
			AB => AB,
			DB => DB,
			ER => ER
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
		DB <= "1000";
		wait for CLK_Period;
		AB <= "10";
		DB <= "1100";
		wait for CLK_Period;
		WR <= '1';
		DB <= "ZZZZ";
		AB <= "01";
		wait for CLK_Period;
		DB <= "ZZZZ";
		AB <= "10";
		wait for CLK_Period;
		
		
		AB <= "11";
		DB <= "0100";	
		WR <= '0';
		wait for CLK_Period/4;
		DB <= "ZZZZ";	 
		WR <= '1';
		wait for CLK_Period;		  
		AB <= "11";
		DB <= "0100";	
		WR <= '0';
		wait for CLK_Period/2;
		DB <= "ZZZZ";	 
		WR <= '1';
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ram_ham of ram_ham_tb is
	for TB_ARCHITECTURE
		for UUT : ram_ham
			use entity work.ram_ham(beh);
		end for;
	end for;
end TESTBENCH_FOR_ram_ham;


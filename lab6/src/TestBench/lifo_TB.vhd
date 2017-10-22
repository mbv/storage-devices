library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity lifo_tb is
		generic(
		M : INTEGER := 2;
		N : INTEGER := 2 );
end lifo_tb;

architecture TB_ARCHITECTURE of lifo_tb is
	component lifo
		generic(
		M : INTEGER := 2;
		N : INTEGER := 2 );
	port(
		CLK : in STD_LOGIC;
		WR : in STD_LOGIC;
		DB : inout STD_LOGIC_VECTOR(N-1 downto 0);
		EMPTY : out STD_LOGIC;
		FULL : out STD_LOGIC );
	end component;


	signal CLK : STD_LOGIC := '0';
	signal WR : STD_LOGIC := '0';
	signal DB : STD_LOGIC_VECTOR(N-1 downto 0);

	signal EMPTY : STD_LOGIC;
	signal FULL : STD_LOGIC;

    constant CLK_Period: time := 10 ns;
begin
	UUT : lifo
		generic map (
			M => M,
			N => N
		)

		port map (
			CLK => CLK,
			WR => WR,
			DB => DB,
			EMPTY => EMPTY,
			FULL => FULL
		);

	CLK_Process: process
	begin
		CLK <= '0';
		wait for CLK_Period/2;
		CLK <= '1';
		wait for CLK_Period/2;
	end process;
	
	main: process
	begin
		wait for CLK_Period;
		WR <= '0';
		DB <= "11";
		wait for CLK_Period;
		DB <= "10";
		wait for CLK_Period;
		DB <= "01";
		wait for CLK_Period;
		WR <= '1';
		DB <= "ZZ";
		wait for CLK_Period;
		DB <= "ZZ";
		wait for CLK_Period;
		DB <= "ZZ";
		wait for clk_period;
		DB <= "ZZ";
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_lifo of lifo_tb is
	for TB_ARCHITECTURE
		for UUT : lifo
			use entity work.lifo(beh);
		end for;
	end for;
end TESTBENCH_FOR_lifo;


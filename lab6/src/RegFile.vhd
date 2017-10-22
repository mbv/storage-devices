library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity RegFile is
	generic (
		INITREG: std_logic_vector := "0000";
		N: integer := 2);
	port (
		INIT: in std_logic;				 
		WDP: in std_logic_vector(INITREG'range);
		WA: in std_logic_vector(N - 1 downto 0);
		RA: in std_logic_vector(N - 1 downto 0);
		WE: in std_logic;
		RDP: out std_logic_vector(INITREG'range));
end RegFile;

architecture Beh of RegFile is
	component RegN is 
		generic (
			INITREG: std_logic_vector := "1001");
		port (
			Din: in std_logic_vector(initreg'range);
			EN: in std_logic;
			INIT: in std_logic;
			CLK: in std_logic;
			OE: in std_logic;
			Dout: out std_logic_vector(initreg'range));
	end component;
	signal wEn: std_logic_vector(2**N - 1 downto 0);
	signal rEn: std_logic_vector(2**N - 1 downto 0);
	signal readd: std_logic_vector (initreg'range);
Begin
	WAD: process (WA)
	begin
		for i in 0 to 2**N - 1 	loop  
			if i = conv_integer(WA) then
				wEn (i) <= '1';
			else 
				wEn (i) <= '0';
			end if;
		end loop;
	end process;
	
	RAD: process (RA)
	begin
		for i in 0 to 2**N - 1 	loop
			if i = conv_integer(RA) then
				rEn (i) <= '1';
			else 
				rEn (i) <= '0';
			end if;
		end loop;
	end process;
	
	Regi: for i in 2**N - 1 downto 0 generate
		Regi: RegN generic map (initreg)
		port map (WDP, wEn(i), init, WE, rEn(i), readd);
	end generate;
	
	RDP <= readd;
End Beh;
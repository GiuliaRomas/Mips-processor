library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataMemory is
	generic(constant addr_b: integer := 5;
			  constant word  : integer := 31);
	port(WE, clk : in  std_logic;
		  A		 : in  std_logic_vector(addr_b downto 0);
		  WD		 : in  std_logic_vector(word   downto 0);
		  RD 		 : out std_logic_vector(word   downto 0));
end dataMemory;

architecture synth of dataMemory is 
	type   mem_type is array ((2**(addr_b + 1))-1 downto 0) of std_logic_vector(word downto 0);
	signal data_memory: mem_type := ((others => x"00000000"));
begin

	process(clk, WE, A, WD)
	begin
		if (rising_edge(clk) and WE = '1') then
			data_memory(to_integer(unsigned(A))) <= WD;
		end if;		
	end process;
	
	RD <= data_memory(to_integer(unsigned(A))) when WE = '0';
	
	
end synth;

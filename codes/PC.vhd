library ieee; 
use ieee.std_logic_1164.all;

entity PC is
	port(din : in  std_logic_vector(31 downto 0);  -- entrada
	     clk : in  std_logic;                      -- clock
	     clr : in  std_logic;                      -- clear
	     dout: out std_logic_vector(31 downto 0)); -- saída
end PC;

architecture synth of PC is
begin
	process(clk, clr, din)
	begin  
	
		if (clr = '1') then          -- se clear = 1
			dout <= x"00000000"; -- a saida recebe 0
		elsif rising_edge(clk) then  -- na borda de subida do clock
			dout <= din;	     -- a saida recebe a entrada
		end if;
		
	end process;
end synth;

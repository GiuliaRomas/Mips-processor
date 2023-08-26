library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port (WD3:        in  std_logic_vector(31 downto 0);  -- dado que sera gravado
			A1, A2, A3: in  std_logic_vector( 4 downto 0);  -- enderecam as localizacoes
			clk, WE3:   in  std_logic; 						   -- clock e habilitacao de escrita
			RD1, RD2:   out std_logic_vector(31 downto 0)); -- dados lidos
end register_file;

architecture synth of register_file is
	type reg is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal registers: reg := ((others=> x"00000000"));
begin

	--------------- gravacao de dados ---------------
	
	process(WD3, WE3, clk) 
	begin
		if rising_edge(clk) then
			if (WE3 = '1') then
				registers(to_integer(unsigned(A3))) <= WD3;
			end if;
		end if;
	end process;
	
	--------------- leitura de dados ----------------
	
	RD1 <= registers(to_integer(unsigned(A1)));
	RD2 <= registers(to_integer(unsigned(A2)));

end synth;

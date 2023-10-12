library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port (WD3:        	  in  std_logic_vector(31 downto 0);  -- dado que sera gravado
			A1, A2, A3: 	  in  std_logic_vector( 4 downto 0);  -- enderecam as localizacoes
			clk, WE3, clr:   in  std_logic; 						     -- clock e habilitacao de escrita
			RD1, RD2:   	  out std_logic_vector(31 downto 0)); -- dados lidos
end register_file;

architecture synth of register_file is
	type reg is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal registers: reg := ((others => x"00000000"));
begin

	--------------- gravacao de dados ---------------
	
	process(WD3, WE3, clk, clr) 
	begin
		if (clr = '0') then
			if rising_edge(clk) then
				if (WE3 = '1') then
					registers(to_integer(unsigned(A3))) <= WD3;
				end if;
			end if;
		else 
			registers <= ((others => x"00000000"));
		end if;
	end process;
	
	--------------- leitura de dados ----------------
	
	process(A1, A2, A3, WD3, WE3, clk, clr) 
	begin
		if (to_integer(unsigned(A1)) = 0) then 
			RD1 <= X"00000000";
		else 
			RD1 <= registers(to_integer(unsigned(A1)));
		end if;
		
		if (to_integer(unsigned(A2)) = 0) then 
			RD2 <= X"00000000";
		else 
			RD2 <= registers(to_integer(unsigned(A2)));
		end if;
	 end process;

end synth;

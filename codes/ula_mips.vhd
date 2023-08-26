library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_mips is
	port(A, B:   in  std_logic_vector(31 downto 0); -- operandos
		  AluOp:  in  std_logic_vector(3  downto 0); -- operacao
		  Result: out std_logic_vector(31 downto 0); -- saida
		  Zero:   out std_logic); -- saida para verificar se o result eh 0
end ula_mips;

architecture synth of ula_mips is
	-- sinais que representarao a saida de cada um dos modulos (logico e aritmetico)
	signal AddOut, LogicOut: std_logic_vector(31 downto 0);
begin
	
	-- instanciando a parte logica
	logic_part: entity work.logic_part(synth)
	port map(A => A, B => B, AluOp => AluOp, LogicOut => LogicOut);
	
	-- instanciando a parte aritmetica
	arithmetic_part: entity work.arithmetic_part(synth)
	port map(A => A, B => B, AluOp => AluOp, AddOut => AddOut);
	
	process(AluOp, A, B, AddOut, LogicOut)
	begin
		-- multiplexador para escolher operacao aritmetica ou logica
		
		if (AluOp(2) = '1') then -- operacoes logicas
			Result <= LogicOut; -- resultado recebe a saida da parte logica
	
			-- verifica se a saida e zero ou nao
			if (LogicOut = x"00000000") then
				Zero <= '1';
			else
				Zero <= '0';
			end if;
			
		elsif (AluOp(2) = '0') then -- operacoes aritmeticas
			Result <= AddOut; -- resultado recebe a saida da parte aritmetica
	
			-- verifica se a saida e zero ou nao
			if (AddOut = x"00000000") then
				Zero <= '1';
			else
				Zero <= '0';
			end if;
			
		end if;
		
		-- fim do multiplexador op. aritmetica ou logica
	end process;
	
end synth;

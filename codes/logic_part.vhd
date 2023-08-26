library ieee;
use ieee.std_logic_1164.all;

entity logic_part is
	port(A, B:     in  std_logic_vector(31 downto 0); -- operandos
		  AluOp:    in  std_logic_vector(3  downto 0); -- operacao
		  LogicOut: out std_logic_vector(31 downto 0)); -- saida
end logic_part;

architecture synth of logic_part is
begin
	
	process(AluOp, A, B) -- executa sempre que a operacao mudar
	begin
		-- multiplexador que seleciona uma operacao logica conforme os dois bits menos significativos da entrada AluOp 
		
		case AluOp(1 downto 0) is 
			when "00" => LogicOut <= (A and B);
			when "01" => LogicOut <= (A or  B);
			when "10" => LogicOut <= (A xor B);
			when others => LogicOut <= (A nor B);
		end case;	
		
	end process;
	
end synth;

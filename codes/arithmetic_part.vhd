library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_part is
	port(A, B:   in  std_logic_vector(31 downto 0);  -- operandos
		  AluOp:  in  std_logic_vector(3  downto 0);  -- operacao
		  AddOut: out std_logic_vector(31 downto 0)); -- saida
end arithmetic_part;

architecture synth of arithmetic_part is
	signal AddSignal: std_logic_vector(31 downto 0);
begin
	
	process(AluOp, A, B, AddSignal)
	begin
		if (AluOp(1) = '1') then -- subtracao ou slt
			AddSignal <= std_logic_vector(signed(A) - signed(B));
		elsif (AluOp(1) = '0') then -- adicao
			AddSignal <= std_logic_vector(signed(A) + signed(B));
		end if;
			
		if (AluOp(3) = '0') then -- se a operacao for add ou sub, a saida recebe o sinal de 32 bits
			AddOut <= AddSignal;
		elsif (AluOp(3) = '1') then -- se a operacao for slt, a saida recebe o bit mais significativo do sinal e estende ele para 32 bits
			AddOut <= (0 => AddSignal(31), others => '0');
		end if;
	end process;

end synth;

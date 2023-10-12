library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is
	generic(tam: integer);
	port(A, B:     in  std_logic_vector(tam-1 downto 0); -- operandos
		  Selector: in  std_logic; -- operacao
		  MuxOut:   out std_logic_vector(tam-1 downto 0)); -- saida
end mux2_1;

architecture synth of mux2_1 is
begin
	
	with Selector select
	MuxOut <= A  when '0',
				 B  when others;
	
end synth;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtend is
	port(A:   	  in  std_logic_vector(15 downto 0);  -- operandos
		  SignImm: out std_logic_vector(31 downto 0)); -- saida
end SignExtend;

architecture synth of SignExtend is
begin

	SignImm(15 downto 0) <= A;
	
	with A(15) select 
	SignImm (31 downto 16) <= x"0000" when '0',
									  x"FFFF" when others;

end synth;

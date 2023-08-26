library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic(tam1: integer;
			  tam2: integer);
	port(A:   	 in  std_logic_vector(tam1-1 downto 0);  -- operandos
		  B:   	 in  std_logic_vector(tam2-1 downto 0);
		  AddOut: out std_logic_vector(tam1-1 downto 0)); -- saida
end adder;

architecture synth of adder is
begin

	AddOut <= std_logic_vector(signed(A) + signed(B));

end synth;

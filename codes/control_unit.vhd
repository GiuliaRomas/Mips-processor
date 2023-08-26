library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
	port(Opcode, Funct 			 	 : in  std_logic_vector(5 downto 0);
		  ALUControl 					 : out std_logic_vector(3 downto 0);
		  RegDst, Jump, PCSrc		 : out std_logic;
		  MemtoReg, Zero  			 : out std_logic;
		  MemWrite, ALUSrc, RegWrite: out std_logic);		  
end control_unit;

architecture synth of control_unit is 
begin
	
end synth;

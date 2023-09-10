library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_control is
	port(Opcode						 	      : in  std_logic_vector(5 downto 0);					
		  ALUControl 					      : out std_logic_vector(1 downto 0); 
		  RegDst, Jump       		    : out std_logic; 
		  MemtoReg, Branch, MemRead : out std_logic;
		  MemWrite, ALUSrc, RegWrite: out std_logic);		  
end main_control;

architecture synth of main_control is 
	signal controls: std_logic_vector(9 downto 0);
begin
	process(Opcode) 
	begin
		case Opcode is
			when "000000" => controls <= "1001000010"; -- R-type
			when "100011" => controls <= "0111100000"; -- lw
			when "101011" => controls <= "0100010000"; -- sw
			when "000100" => controls <= "0000001001"; -- beq
			when "001000" => controls <= "0101000000"; -- addi
			when "000010" => controls <= "0000000100"; -- j
			when  others  => controls <= "XXXXXXXXXX"; 
		end case;
	end process;
	
	RegDst <= controls(9); ALUSrc <= controls(8); MemtoReg <= controls(7);
	RegWrite <= controls(6); MemRead <= controls(5); MemWrite <= controls(4);
	Branch <= controls(3);Jump <= controls(2);
	ALUControl(1 downto 0) <= controls(1 downto 0);
	
end synth;

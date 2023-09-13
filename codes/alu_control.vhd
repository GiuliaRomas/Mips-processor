library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is
	port(Funct		  : in  std_logic_vector(5 downto 0);					
		   ALUControl : in  std_logic_vector(1 downto 0); 
		   AluOp      : out std_logic_vector(3 downto 0));		  
end alu_control;

architecture synth of alu_control is 
begin
	process(ALUControl) 
	begin
		case ALUControl is
			when "00" => AluOp <= "0000"; -- lw, sw, addi (add)
			when "01" => AluOp <= "0010"; -- beq (sub)
			when others => case Funct is 	-- R-type
				when "100000" => AluOp <= "0000"; -- add
				when "100010" => AluOp <= "0010"; -- sub
				when "100100" => AluOp <= "0100"; -- and
				when "100101" => AluOp <= "0101"; -- or
				when "101010" => AluOp <= "1010"; -- slt
				when  others  => AluOp <= "XXXX";
			end case;
		end case;
	end process;
end synth;

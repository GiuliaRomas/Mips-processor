library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
	port(Opcode, Funct 		    : in  std_logic_vector(5 downto 0);
		  Zero			    : in  std_logic;								
		  AluOp		 	    : out std_logic_vector(3 downto 0);
		  RegDst, Jump, PCSrc	    : out std_logic;
		  MemtoReg, MemRead 	    : out std_logic;
		  MemWrite, ALUSrc, RegWrite: out std_logic);		  
end control_unit;

architecture synth of control_unit is 
	signal Branch: std_logic;
	signal ALUControl: std_logic_vector(1 downto 0);
begin
	-- main control unit
	mainControl: entity work.main_control(synth)
	port map(Opcode => Opcode, ALUControl => ALUControl, RegDst => RegDst, 
	Jump => Jump, MemtoReg => MemtoReg, Branch => Branch, MemRead => MemRead,
	MemWrite => MemWrite, ALUSrc => ALUSrc, RegWrite => RegWrite);
	
	-- alu control
	controlAlu: entity work.alu_control(synth)
	port map(Funct => Funct, ALUControl => ALUControl, AluOp => AluOp);
	
	-- pcsrc (beq)
	PCSrc <= Branch and Zero;
	
end synth;

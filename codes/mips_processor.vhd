library ieee;
use ieee.std_logic_1164.all;


entity mips_processor is
	port(clk, clr					  : in 	  std_logic;
		  MemWrite					  : out 	  std_logic;
		  MemRead					  : buffer std_logic;
		  Instr, ReadData         : in  	  std_logic_vector(31 downto 0);
		  ALUResult, PC, WriteData: out 	  std_logic_vector(31 downto 0));
end mips_processor;

architecture synth of mips_processor is
	-- sinais de controle --
	signal AluOp: std_logic_vector(3 downto 0);
	signal PCSrc, MemtoReg, Jump, ALUSrc: std_logic; 
	signal RegDst, RegWrite: std_logic;
	
	-- sinais gerais --
	signal Zero: std_logic;
begin
	-- datapath --
	data_path: entity work.dataPath(synth)
	port map(clk => clk, clr => clr, Zero => Zero, PC => PC, Instr => Instr, 
	ReadData => ReadData, ALUResult => ALUResult, WriteData => WriteData,
	AluOp => AluOp, Jump => Jump, PCSrc => PCSrc, MemtoReg => MemtoReg, ALUSrc => ALUSrc,
	RegDst => RegDst, RegWrite => RegWrite, MemRead => MemRead);
	
	-- unidade de controle --
	controlUnit: entity work.control_unit(synth)
	port map(Funct => Instr(5 downto 0), Opcode => Instr(31 downto 26), 
	AluOp => AluOp, Jump => Jump, PCSrc => PCSrc, Zero => Zero, MemtoReg => MemtoReg,
	ALUSrc => ALUSrc, RegDst => RegDst, RegWrite => RegWrite, MemWrite => MemWrite, MemRead => MemRead);
	
end synth;

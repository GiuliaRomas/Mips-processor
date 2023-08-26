library ieee;
use ieee.std_logic_1164.all;


entity mips_processor is
	port(clk, clr: in std_logic);
end mips_processor;

architecture synth of mips_processor is
	-- sinais de controle --
	signal ALUControl: std_logic_vector(3 downto 0);
	signal PCSrc, MemtoReg, Jump, ALUSrc: 	  std_logic; 
	signal RegDst, RegWrite, MemWrite: std_logic;
	
	-- sinais gerais --
	signal Zero: std_logic;
	signal PC: std_logic_vector(31 downto 0);
	signal ALUResult, WriteData, ReadData, Instr: std_logic_vector(31 downto 0);
begin
	-- unidade de controle --
	controlUnit: entity work.control_unit(synth)
	port map(Funct => Instr(5 downto 0), Opcode => Instr(31 downto 26), 
	ALUControl => ALUControl, Jump => Jump, PCSrc => PCSrc, Zero => Zero, MemtoReg => MemtoReg,
	ALUSrc => ALUSrc, RegDst => RegDst, RegWrite => RegWrite, MemWrite => MemWrite);
	
	-- datapath --
	data_path: entity work.dataPath(synth)
	port map(clk => clk, clr => clr, Zero => Zero, PC => PC, Instr => Instr, 
	ReadData => ReadData, ALUResult => ALUResult, WriteData => WriteData,
	ALUControl => ALUControl, Jump => Jump, PCSrc => PCSrc, MemtoReg => MemtoReg, ALUSrc => ALUSrc,
	RegDst => RegDst, RegWrite => RegWrite, MemWrite => MemWrite);
	
	-- memoria de instrucoes --
	instr_mem: entity work.instructionMemory(synth)
	port map(A => PC(5 downto 0), RD => Instr);
	
	-- memoria de dados --
	data_mem: entity work.dataMemory(synth)
	port map(A => ALUResult(5 downto 0), WD => WriteData, RD => ReadData, WE => MemWrite, clk => clk);

end synth;

library ieee;
use ieee.std_logic_1164.all;

entity processor is
	port(clk, clr: 					 in     std_logic;
		  MemWrite:   					 buffer std_logic; -- habilita escrita memoria de dados
		  ALUResult, WriteData, PC, ReadData, Instr: buffer std_logic_vector(31 downto 0));
end processor;

architecture synth of processor is	
	-- sinais gerais --
	signal MemRead: 			std_logic;
begin
	-- processador mips --
	mips_proc: entity work.mips_processor(synth)
	port map(clk => clk, clr => clr, MemWrite => MemWrite, Instr => Instr, ReadData => ReadData, ALUResult => ALUResult, PC => PC, WriteData => WriteData);
	
	-- memoria de instrucoes --
	instr_mem: entity work.instructionMemory(synth)
	port map(A => PC(7 downto 2), RD => Instr);
	
	-- memoria de dados --
	data_mem: entity work.dataMemory(synth)
	port map(A => ALUResult(5 downto 0), WD => WriteData, RD => ReadData, WE => MemWrite, clk => clk, MemRead => MemRead);
	
end synth;

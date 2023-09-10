library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataPath is
	port(clk, clr: in std_logic;
		  PC		        : buffer std_logic_vector(31 downto 0);
		  WriteData, ALUResult	: buffer std_logic_vector(31 downto 0);
		  AluOp     		     : in std_logic_vector(3  downto 0);
		  Instr, ReadData	     : in std_logic_vector(31 downto 0);
		  RegDst, Jump, PCSrc	     : in std_logic;
		  MemtoReg, MemRead	     : in std_logic;
		  MemWrite, ALUSrc, RegWrite : in std_logic;
		  Zero: out std_logic);		  
end dataPath;

architecture synth of dataPath is 
	signal PCPlus4, PCmuxout1, PCmuxout2, PCBranch, PCJump: std_logic_vector(31 downto 0);
	signal WriteReg: std_logic_vector(4  downto 0);
	signal SignImm:  std_logic_vector(31 downto 0);
	signal SrcA, SrcB, Result: std_logic_vector(31 downto 0);
	
begin
	------- componentes -------
	
	reg_file: entity work.register_file(synth)
	port map(A1 => Instr(25 downto 21), A2 => Instr(20 downto 16), A3 => WriteReg, WD3 => Result, WE3 => RegWrite, RD1 => SrcA, RD2 => WriteData, clk => clk);
	
	ula: entity work.ula_mips(synth)
	port map(A => SrcA, B => SrcB, Zero => Zero, Result => AluResult, AluOp => AluOp);
	
	pc_reg: entity work.PC(synth)
	port map(clk => clk, clr => clr, din => PCmuxout2, dout => PC);
	
	sign_extend: entity work.SignExtend(synth)
	port map(A => Instr(15 downto 0), SignImm => SignImm);
	
	------ multiplexadores ------
	
	---------- mux pc1 ----------
	mux_pc1: entity work.mux2_1(synth)
	generic map(tam => 32) port map(A => PCPlus4, B => PCBranch, Selector => PCSrc, MuxOut => PCmuxout1);
	
	---------- mux pc2 ----------
	mux_pc2: entity work.mux2_1(synth)
	generic map(tam => 32) port map(A => PCmuxout1, B => PCJump, Selector => Jump, MuxOut => PCmuxout2);
	
	-------- mux writereg -------
	mux_wreg: entity work.mux2_1(synth)
	generic map(tam => 5) port map(A => Instr(20 downto 16), B => Instr(15 downto 11), Selector => RegDst, MuxOut => WriteReg);
	
	---------- mux ula ----------
	mux_ula: entity work.mux2_1(synth)
	generic map(tam => 32) port map(A => WriteData, B => SignImm, Selector => ALUSrc, MuxOut => SrcB);
	
	-------- mux result ---------
	mux_result: entity work.mux2_1(synth)
	generic map(tam => 32) port map(A => ALUResult, B => ReadData, Selector => MemtoReg, MuxOut => Result);
	
	--------- somadores ---------
	
	------- adder pcplus4 -------
	adder_pcplus: entity work.adder(synth)
	generic map(tam1 => 32, tam2 => 3) port map(A => PC, B => "100", AddOut => PCPlus4);
	
	------- adder pcbranch ------
	adder_pcbranch: entity work.adder(synth)
	generic map(tam1 => 32, tam2 => 32) port map(A => SignImm(29 downto 0) & "00", B => PCPlus4 , AddOut => PCBranch);
	
	
	---------- pc jump ----------
	PCJump <= PCPlus4(31 downto 28) & Instr(25 downto 0) & "00";
	
	
end synth;

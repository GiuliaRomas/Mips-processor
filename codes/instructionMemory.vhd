library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity instructionMemory is
	generic(addr_b: integer := 5;
			  word  : integer := 31);
   port(A : in  std_logic_vector(addr_b downto 0); -- endereço
		  RD: out std_logic_vector(word 	 downto 0)); -- saída
end instructionMemory;

architecture synth of instructionMemory is
	-- cria um tipo que eh uma matriz de 64 posicoes, cada uma com 32 bits
	type mem_type is array (2**(addr_b + 1)-1 downto 0) of std_logic_vector(word downto 0);
	
	-- funcao para inicializar a memoria (le as instrucoes de um arquivo txt)
	impure function inicializa(nome_arq : in string) return mem_type is
		file     arquivo  : text open read_mode is nome_arq;
	   variable linha    : line;
	   variable instruction : std_logic_vector(31 downto 0); 
	   variable temp_mem : mem_type; -- matriz de memoria temporaria
	   begin
			for i in 0 to 63 loop -- le as 64 localizacoes
				
				-- se o arquivo ainda nao acabou
				
				if (not endfile(arquivo)) then 
					readline(arquivo, linha);  -- le uma linha
					hread(linha, instruction); -- armazena a instrucao em uma variavel 
					-- armazena a instrucao lida na matriz temporaria
					temp_mem(i)(31 downto 0) := instruction(31 downto 0); 
					
				else -- se o arquivo acabou
					next;
				end if;
				
			end loop;
			
			return temp_mem; -- retorna a matriz temporaria
	  end;
		
	-- declara uma constante do tipo mem_type e inicializa com as instrucoes de um arquivo	
	constant instruction_memory: mem_type := inicializa("instructions.txt");
	
begin
	
	-- le o dado da memoria armazenado na posicao enderecada por A
	RD <= instruction_memory(to_integer(unsigned(A))); 
	
end synth;


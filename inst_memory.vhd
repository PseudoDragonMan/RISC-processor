library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity inst_memory is
port(	mem_read:in std_logic;
		mem_A:in std_logic_vector(15 downto 0);
		mem_O: out std_logic_vector(15 downto 0));
end inst_memory;

architecture a of inst_memory is
	type mem is array (0 to 65535) of std_logic_vector(15 downto 0);
	signal mem_data:mem:= (
	0=>"0001001100010000",
   1=>"0000000101011000",
   2=>"0110010010101010",
   3=>"0011010001010101",
   4=>"0000000001101000",
   5=>"0000101100110000",
   6=>"0000001010011000",
others=>"1110000000000000");

	begin
	
	process(mem_A)
	begin
		if (mem_read='1') then
			  mem_O<=mem_data(to_integer(unsigned(mem_A)));
		 end if;	
		 
		 end process;
	
	
end a;

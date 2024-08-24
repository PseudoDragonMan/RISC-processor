library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU1 is 
port (
      A: in std_logic_vector(15 downto 0);--PC here
		en:in std_logic;--Enable signal
		Y: out std_logic_vector(15 downto 0)); 
end entity ALU1;


architecture behav of ALU1 is
signal A_int,Y_int: integer;


begin
process(A,A_int,Y_int)
begin

if en='1' then
A_int<=to_integer(unsigned(A));
Y_int<=(A_int+1);
Y<=std_logic_vector(to_unsigned(Y_int,16));
end if;
end process;
end behav;

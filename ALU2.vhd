library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU2 is 
port (
      A,IMM: in std_logic_vector(15 downto 0);--PC here
		en:in std_logic;--Enable signal
		Y: out std_logic_vector(15 downto 0)); 
end entity ALU2;


architecture behav of ALU2 is
signal A_int,IMM_int,Y_int: integer;


begin
process(A,IMM_int,A_int,Y_int)
begin

if en='1' then
A_int<=to_integer(unsigned(A));
IMM_int<=to_integer(unsigned(IMM));
Y_int<=(A_int+IMM_int);
Y<=std_logic_vector(to_unsigned(Y_int,16));

else 
Y<="0000000000000000";
end if;

end process;
end behav;

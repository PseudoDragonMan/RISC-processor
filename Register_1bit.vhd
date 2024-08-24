library ieee;
use ieee.std_logic_1164.all;

entity Register_1bit is
    port (
        clk, reset : in std_logic;
        din,wrt : in std_logic;
        dout : out std_logic
    );
end entity Register_1bit;

architecture behavioral of Register_1bit is

signal data:std_logic;
begin
 dout<= data;
    process (clk, reset)
    begin
        if reset = '1' then  -- Synchronous reset
            data <= '0';     -- Reset the output to '0'
        elsif rising_edge(clk) then  -- Rising edge of the clock
		  if (wrt ='1') then
            data <= din;     -- Store the input data on the rising edge
				end if;
        end if;
    end process;
end architecture behavioral;

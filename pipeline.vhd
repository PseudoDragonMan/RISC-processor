library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity pipeline is
	port(
    pipeout: out std_logic_vector(15 downto 0);
    pipein: in  std_logic_vector(15 downto 0);
    pipe_write,clk,rst: in  std_logic);
end entity pipeline;

architecture arc of pipeline is
	signal data: std_logic_vector(15 downto 0);
begin
	pipeout<=data;
	process(clk) 
	begin
		if rst='1' then
		    data<="1110000000000000";
		elsif(rising_edge(clk)) then
			if(pipe_write='1') then
				data<=pipein;
			end if;
		end if;
		
	end process;
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity pipe8 is
    port(
        pipeout0,pipeout1,pipeout2,pipeout3,pipeout4,pipeout5,pipeout6,pipeout7: out std_logic_vector(15 downto 0);
        pipein0,pipein1,pipein2,pipein3,pipein4,pipein5,pipein6,pipein7: in std_logic_vector(15 downto 0);
        pipe_write, clk, rst: in std_logic
    );
end entity pipe8;

architecture arc of pipe8 is
    type arr is array (0 to 7) of std_logic_vector(15 downto 0);

    signal data: arr:=(others=>"0000000000000000");
begin
    pipeout0 <= data(0);
	 pipeout1 <= data(1);
	 pipeout2 <= data(2);
	 pipeout3 <= data(3);
	 pipeout4 <= data(4);
	 pipeout5 <= data(5);
	 pipeout6 <= data(6);
	 pipeout7 <= data(7);


    process(clk) 
    begin
        if rst = '1' then
            for i in 0 to 7 loop
                data(i) <= "0000000000000000";
            end loop;
        elsif rising_edge(clk) then
            if pipe_write = '1' then
                    data(0) <= pipein0;
						  data(1) <= pipein1;
						  data(2) <= pipein2;
						  data(3) <= pipein3;
						  data(4) <= pipein4;
						  data(5) <= pipein5;
						  data(6) <= pipein6;
						  data(7) <= pipein7;
            end if;
        end if;
    end process;
end architecture;

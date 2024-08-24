library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port (
        multi, mem_write, mem_read: in std_logic;
        imm: in std_logic_vector(7 downto 0);
        multi_in0,multi_in1,multi_in2,multi_in3,multi_in4,multi_in5,multi_in6,multi_in7: in std_logic_vector(15 downto 0);
        mem_A: in std_logic_vector(15 downto 0);
        mem_I: in std_logic_vector(15 downto 0);
        mem_O: out std_logic_vector(15 downto 0);
        multi_out0,multi_out1,multi_out2,multi_out3,multi_out4,multi_out5,multi_out6,multi_out7: out std_logic_vector(15 downto 0);
        clk, rst: in std_logic
    );
end entity data_memory;

architecture a of data_memory is
    type arr is array (0 to 7) of std_logic_vector(15 downto 0);
    type mem is array (0 to 255) of std_logic_vector(15 downto 0);
    signal mem_data: mem := (others => (others => '0'));
    signal muli, mulo: arr;
    
begin
    muli(0) <= multi_in0;
    muli(1) <= multi_in1;
    muli(2) <= multi_in2;
    muli(3) <= multi_in3;
    muli(4) <= multi_in4;
    muli(5) <= multi_in5;
    muli(6) <= multi_in6;
    muli(7) <= multi_in7;
    
    multi_out0 <= mulo(0);
    multi_out1 <= mulo(1);
    multi_out2 <= mulo(2);
    multi_out3 <= mulo(3);
    multi_out4 <= mulo(4);
    multi_out5 <= mulo(5);
    multi_out6 <= mulo(6);
    multi_out7 <= mulo(7);
    
    process (clk, rst)
	 variable j: integer := 0;
    begin
	 
	 				if mem_read = '1' and multi = '0' then
					mem_O <= mem_data(to_integer(unsigned(mem_A)));

            
            elsif mem_read = '1' and multi = '1' then
                for i in 0 to 7 loop
                    mulo(i) <= mem_data(to_integer(unsigned(mem_A)) + i);
                end loop;
            end if;
				
        if rst = '1' then
            mem_data <= (others => (others => '0'));
            
	
				
			elsif rising_edge(clk) then
				if mem_write ='1' and multi = '0' then
					 mem_data(to_integer(unsigned(mem_A))) <= mem_I;
			
			

            elsif mem_write = '1' and multi = '1' then
				j := 0;
                for i in 0 to 7 loop
                    if imm(i) = '1' then
                        mem_data(to_integer(unsigned(mem_A)) + j) <= muli(7-i);
                        j := j + 1;
                    end if;
                end loop;
            end if;

				end if;

  
    end process;
end architecture a;

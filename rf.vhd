library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rf is
    port (
        multi, rf_write, rf_read,pcwr: in std_logic;
        imm: in std_logic_vector(7 downto 0);
        rf_in0, rf_in1, rf_in2, rf_in3, pcin,rf_in4, rf_in5, rf_in6, rf_in7, rin: in std_logic_vector(15 downto 0);
        ra1, ra2,rain: in std_logic_vector(2 downto 0);
        rdata1, rdata2: out std_logic_vector(15 downto 0);
        rf_out0, rf_out1, rf_out2, rf_out3, pcout,rf_out4, rf_out5, rf_out6, rf_out7: out std_logic_vector(15 downto 0);
        clk, rst: in std_logic
    );
end entity rf;

architecture a of rf is
    type mem is array (0 to 7) of std_logic_vector(15 downto 0);
    signal rf_in: mem := (others => (others => '0'));
	 signal rf_data: mem := (
	0=>"0001001100010000",
   1=>"0000000000000111",
   2=>"0000000000000011",
   3=>"0000000010100000",
   4=>"0000000001101000",
   5=>"0000000000110000",
   6=>"0000000010011000",
	7=>"0000000000000000"
	);

begin
	
	rf_in(0)<= rf_in0; 
	rf_in(1)<= rf_in1; 
	rf_in(2)<= rf_in2; 
	rf_in(3)<= rf_in3;
	rf_in(4)<= rf_in4; 
	rf_in(5)<= rf_in5; 
	rf_in(6)<= rf_in6; 
	rf_in(7)<= rf_in7;
	
	 rf_out0 <= rf_data(0);
    rf_out1 <= rf_data(1);
    rf_out2 <= rf_data(2);
    rf_out3 <= rf_data(3);
    rf_out4 <= rf_data(4);
    rf_out5 <= rf_data(5);
    rf_out6 <= rf_data(6);
    rf_out7 <= rf_data(7);
	 pcout <= rf_data(0);


    process (clk, rst, ra1, ra2)
	 variable j: integer := 0;
    begin
	 
			if rf_Read = '1' then
				rdata1 <= rf_data(to_integer(unsigned(ra1)));
				rdata2 <= rf_data(to_integer(unsigned(ra2)));
				end if;
        if rst = '1' then
          rf_data(0) <= "0000000000000000";
			 rf_data(1) <= "0000000000000000";
			 rf_data(2) <= "0000000000000000";
			 rf_data(3) <= "0000000000000000";
			 rf_data(4) <= "0000000001101000";
			 rf_data(5) <= "0000000000110000";
			 rf_data(6) <= "0000000010011000";
			 rf_data(7) <= "0000000000000000";
            
	
				
			elsif rising_edge(clk) then
				if rf_write ='1' and multi = '0' then
					 rf_data(to_integer(unsigned(rain))) <= rin;
			
			

            elsif rf_write = '1' and multi = '1' then
				j := 0;
                for i in 0 to 7 loop
                    if imm(i) = '1' then
                        rf_data(7-i) <= rf_in(j);
                        j := j + 1;
                    end if;
                end loop;
            end if;
				
				if pcwr = '1' then
					rf_data(0) <= pcin;
				end if;

				end if;

  
    end process;
end architecture a;
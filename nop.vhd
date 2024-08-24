library ieee;
use ieee.std_logic_1164.all;

entity nop is 
      port(Clk,Rst,C_Curr,Z_curr,nop4: in std_logic;
		     ir3_in, ir2_in, ir1_in: in std_logic_vector(15 downto 0);			  
			  ir1_out,ir2_out,ir3_out: out std_logic_vector(15 downto 0)
			 ); 
end entity nop;

architecture a1 of nop is
     signal NOP:std_logic_vector(15 downto 0):="1110000000000000";
	  signal opcode: std_logic_vector(3 downto 0);
begin 
     process(ir3_in,clk,ir1_in,ir2_in,ir3_in)
	    begin
	          opcode<=ir3_in(15 downto 12);
	  end process;
	 
	  process(opcode,clk,C_curr,Z_CURR,rst,ir1_in,ir2_in,ir3_in) 
	      begin	         
				if(rst='1') then
			       ir1_out<="1110000000000000";
					 ir2_out<="1110000000000000";
					 ir3_out<="1110000000000000";
				else 
				    case opcode is 
					        when "1000" => 
							    if(Z_curr='1') then
								   ir1_out<=NOP;
							      ir2_out<=NOP;
							      ir3_out<=NOP;
								 else 
								   ir1_out<=ir1_in;
									ir2_out<=ir2_in;
									ir3_out<=ir3_in;
								end if;								 
							  when "1001" =>
							    if(C_curr='1') then 
								   ir1_out<=NOP;
									ir2_out<=NOP;
									ir3_out<=NOP;
								 else 
								   ir1_out<=ir1_in;
									ir2_out<=ir2_in;
									ir3_out<=ir3_in;
								end if;
								when "1010" =>
								  if(C_curr='1'or Z_curr='1') then 
								   ir1_out<=NOP;
									ir2_out<=NOP;
									ir3_out<=NOP;
								 else 
								   ir1_out<=ir1_in;
									ir2_out<=ir2_in;
									ir3_out<=ir3_in;
	                     end if;
					  
					        when  "1100" | "1101" | "1111" =>
							   ir1_out<=NOP;
							   ir2_out<=NOP;
							   ir3_out<=NOP;
								
								when "0100" =>
									if nop4 = '1' then
										ir1_out<=NOP;
										ir2_out<=NOP;
										ir3_out<=NOP;
									end if;
									
								when "1110"=>
							   ir1_out<=ir1_in;
								ir2_out<=ir2_in;
								ir3_out<=ir3_in;
								
							  when others=>
							   ir1_out<=ir1_in;
								ir2_out<=ir2_in;
								ir3_out<=ir3_in;
					 end case;
				end if;
	  end process;
end a1;
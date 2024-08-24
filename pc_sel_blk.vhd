library ieee;
use ieee.std_logic_1164.all;

entity pc_sel_blk is 
    port(rst,clk,stall:in std_logic;
	      ALU2_out,ALU3_out:in std_logic_vector(15 downto 0);
			P7:in std_logic_vector(15 downto 0);  
			PC_3,ir3:in std_logic_vector(15 downto 0);
			C_curr,Z_curr:in std_logic;
			PC1_3:IN std_logic_vector(15 downto 0); --gives PC+1
			PC_new:out std_logic_vector(15 downto 0)
			);
end entity pc_sel_blk;

architecture a1 of pc_sel_blk is 
      signal opcode:std_logic_vector(3 downto 0);
		
begin

     process (ir3,clk)
	    begin
	     opcode<=ir3(15 downto 12);
		end process;
	 
	 process (opcode, rst, clk, C_curr, Z_curr)
	   begin 
		   case opcode is 
			      when "0001" | "0000" | "0010" | "0011" | "0100" | "0101" | "0110" | "0111" =>
					 PC_new<=PC1_3;					 
					
					when "1000" =>	
	             if(Z_curr='1') then 
					  PC_new<=ALU2_out;
					 else
					  PC_new<=PC_3;
					 end if;
					 
					when "1001" =>
				    if(C_curr='1') then 
					  PC_new<=ALU2_out;
					 else
					  PC_new<=PC_3;
					 end if;
					 
               when "1010" =>
                if(C_curr='1' OR Z_curr='1') then 
	              PC_new<=ALU2_out;
		          else 
	              PC_new<=PC_3;
	             END IF;
					 
					when "1101"=>
					 PC_new<=P7;
					
					when "1111"=>
					 PC_new<=ALU3_out;
					 
					when others =>
					PC_new<=PC1_3;
			end case;
		
	end process;
	
end a1;
					
		
	 
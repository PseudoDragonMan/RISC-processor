library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU3 is 
    port (A,B: in std_logic_vector(15 downto 0);
	 C: in std_logic_vector(0 downto 0);
	 en:in std_logic;
	 sel: in std_logic_vector(2 downto 0);
	 C_flag: out std_logic;
	 Z_flag: out std_logic;
	 Y: out std_logic_vector(15 downto 0));
end entity ALU3;


architecture behav of ALU3 is
  signal A_integer,B_integer,op,Y_test,C_int: integer;
begin
  alu_proc: process(A,B,sel,A_integer,B_integer,op,en,sel,C,C_int)
begin

if en='1' then 
  if(sel="000") then --add
     A_integer<=to_integer(unsigned(A));
     B_integer<=to_integer(unsigned(B));
     op<=(A_integer+B_integer);
	  if (op>65535) then 
	   C_flag <= '1';
		else 
		C_flag <= '0';
	  end if;
	  if (op =0 or op = 65536) then
	    Z_flag <= '1';
	else 
       Z_flag <='0';
	end if;	 
	  Y<=std_logic_vector(to_unsigned(op,16));
	  
  elsif(sel="001") then --add with C
     A_integer<=to_integer(unsigned(A));
     B_integer<=to_integer(unsigned(B));
	  C_int<=to_integer(unsigned(C));
	  
     op<=(A_integer+B_integer+ C_int);
	  if (op>65535) then 
	   C_flag <= '1';
		else
		C_flag <= '0';
	  end if;
	  if (op =0 or op = 65536) then
	    Z_flag <= '1';
	else
       Z_flag <='0';
	end if;	 
	  Y<=std_logic_vector(to_unsigned(op,16));
	 
  elsif(sel="010") then --add A + ~B
     A_integer<=to_integer(unsigned(A));
     B_integer<=to_integer(unsigned(not(B)));
     op<=(A_integer+B_integer);
	  if (op>65535) then 
	   C_flag <= '1';
		else
		C_flag <= '0';
	  end if;
	  if (op = 0 or op = 65536) then
	    Z_flag <= '1';
	else 
       Z_flag <='0';
	end if;	 
	  Y<=std_logic_vector(to_unsigned(op,16));	 
	
  elsif(sel="011") then --add A + ~B with C
     A_integer<=to_integer(unsigned(A));
     B_integer<=to_integer(unsigned(not(B)));
	  C_int<=to_integer(unsigned(C));
	  
     op<=(A_integer+B_integer+ C_int);
	  if (op>65535) then 
	   C_flag <= '1';
		else 
		C_flag <= '0';
	  end if;
	 if (op = 0 or op = 65536) then
	    Z_flag <= '1';
	else 
       Z_flag <='0';
	end if;	 
	  Y<=std_logic_vector(to_unsigned(op,16));
	 
	elsif(sel="100") then --nand
     Y<= not(A and B);
	  	 if (not(A and B)="0000000000000000") then
	    Z_flag <= '1';
	   else 
       Z_flag <='0';
	   end if;	
 
	  
	 elsif(sel ="101") then-- LLI
	 Y<= B and "0000000111111111";
	 
	 elsif(sel="110") then --BEQ
     A_integer<=to_integer(unsigned(A));
     B_integer<=to_integer(unsigned(B));
     op<=(A_integer - B_integer);
	  if (op =0) then
	    Z_flag <= '1';
	else 
       Z_flag <='0';
	end if;
	  if (op>65535 or op< 0) then 
	   C_flag <= '1';
		else 
		C_flag <= '0';
	  end if;	
	  Y<=std_logic_vector(to_unsigned(op,16));
	  
	  
	elsif(sel="111") then --nand
     Y<= not(A and not(B));
	  	 if (not(A and not(B))="0000000000000000") then
	    Z_flag <= '1';
	   else 
       Z_flag <='0';
	   end if;		  
end if;
else 

Y <= "0000000000000000";

end if;
end process;
end behav;

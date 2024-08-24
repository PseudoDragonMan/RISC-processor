library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control1 is 

  port(rst:in std_logic;
		ir_write,pc_write,alu_en,pc_pipe,pc1_pipe:out std_logic
      );
		
		
end entity;

architecture a of control1 is
begin

process(rst)
begin

if rst = '1' then  --will have this for stalling
	ir_write <= '0';
	pc_write <= '0';
	alu_en <= '0';
	pc_pipe <= '0';
	pc1_pipe <= '0';
	

else

	ir_write <= '1';
	pc_write <= '1';
	alu_en <= '1';
	pc_pipe <= '1';
	pc1_pipe <= '1';
	
end if;

end process;
end architecture;
	
	
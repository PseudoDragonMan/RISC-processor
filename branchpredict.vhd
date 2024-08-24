library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branchpredict is 
    port(ir1,ir4,jmp: in std_logic_Vector(15 downto 0);c,z,rst,clk:in std_logic;
			pc:out std_logic_Vector(15 downto 0));
			
end entity;

architecture a of branchpredict is

type arr is array (0 to 20) of std_logic_vector(15 downto 0);
type harr is array (0 to 20) of std_logic_vector(0 downto 0);
signal inp,op: arr := (others=>(others=>'0'));
signal h: harr := (others=>(others=>'0'));

begin

process(clk, rst)
variable j: integer := 0;
begin



	if rst = '1' then
		pc<=(others=>'0');
	elsif rising_edge(clk) then
		pc<=(others=>'0');

	for i in 0 to 20 loop
		if ir1=inp(i) then
			if h(i) = '1' then		
				pc<=op(i);			
			end if;
		exit;
		end if;
		end loop;

		
	if pc=(others=>'0') then
		case ir4(15 downto 12) is
			when "1000" | "1001" | "1010" =>
			
				for i in 0 to 20 loop
				
				if inp(i)=(others=>'0') then
					
					inp(i)<=ir4;
					j := i;
					
					exit;
					end if;
					end loop;
					
				
			when others =>
			null;
			end case;
		end if;

		if j /= 0 then
			case ir4(15 downto 12) is
			
				when "1000" =>
				
					if zflag='1' then
					op(j)<=jmp;
					h(j)<='1';
					pc<=jmp;
					end if;
					
				when "1001" =>
				
					if cflag='1' then
					op(j)<=jmp;
					h(j)<='1';
					pc<=jmp;
					end if;
					
				when "1010" =>
				
					if cflag='1' or zflag='1' then
					op(j)<=jmp;
					h(j)<='1';
					pc<=jmp;
					end if;
					
		when others =>
		null;
		end case;
		end if;
		end if;
		end process;

		end architecture a;

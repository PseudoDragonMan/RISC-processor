library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ddblock is 
    port(
        rst,clk: in std_logic;
        ir2, ir3, ir4, ir5, rf1, rf2, pc13, pc14, pc15, s4, s5, mem_o, s6, p6, ir2imm6, ir2imm9: in std_logic_vector(15 downto 0);
        p1, p2, p7: out std_logic_vector(15 downto 0);
        ctrl1_stall, ctrl2_stall, ctrl3_stall, nop4: out std_logic
    );
end entity;

architecture a of ddblock is
    signal op1, op2, op3, op4: std_logic_vector(3 downto 0);
begin

    process(ir2,clk)
    begin
        op1 <= ir2(15 downto 12);
        op2 <= ir3(15 downto 12);
        op3 <= ir4(15 downto 12);
        op4 <= ir5(15 downto 12);
    end process;

    process(rst, op1, op2, op3, op4,ir2,clk)
	 variable j: integer:=0;
    begin
	 
	 if rst = '1'then
		p1<="0000000000000000";
		p2<="0000000000000000";
		p7<="0000000000000000";
	 
	 else
				case op1 is
	 			when "0001" | "0010" =>
						
							
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
	
							
						when "0100" | "0000" =>
						
							
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
					
						
						when "1000" | "1001" | "1010" => --BEQ 
						
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
					
								
							when "0101" => --SW
						
							
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
						
								
							when "1111" => --JRI
						
								p1 <= rf1;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							when "1101" => --JLR
						
							
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
								
							when "0011" => --lli
								
								p1 <= rf1;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "1100" => --jal
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
						
								when others =>
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end case;
							
						case op4 is 
                when "0001" | "0010" | "0011"=> --no memory. only rc is being fwd 

					case op1 is 											--seprerate adi
					
					when "0001" | "0010" =>
						
							if ir5(5 downto 3) = ir2(8 downto 6) then
								p1 <= s6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(5 downto 3) = ir2(5 downto 3) then
								p1 <= rf1;
								p2 <= s6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" => --adi
						
							if ir5(5 downto 3) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
							when "0100"=>  --lw
								
								if ir5(5 downto 3) = ir2(8 downto 6) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
	
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "0101" => --SW
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s6;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "1111" => --JRI
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
							
								
							when "1101" => --JLR
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s6;
								j := 1;							

								
							end if;
								

							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
								
							end case;
							

								
					when "1100" | "1101" => --jal and jlr, lli
								
							case op1 is 
							
							when "0001" | "0010" =>
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc15;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc15;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc15;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc15;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc15;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc15;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc15;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc15;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc15;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc15;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
							
							
							   when "0000" =>							
									
									case op1 is 
							
							when "0001" | "0010" =>
						
							if ir5(8 downto 6) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s6;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= s6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= s6;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s6;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
									
							  when "0100" =>							
									
									case op1 is 
							
							when "0001" | "0010" =>
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= p6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= p6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= p6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= p6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= p6;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= p6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= p6;
								j := 1;
							elsif ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= p6;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= p6;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= p6;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
									
							when others =>
										null;
										end case;
	 
				--if j = 0 then
            --
					--if j = 0 then
					
					case op3 is 
         
                when "0001" | "0010" | "0011"=> --no memory. only rc is being fwd 

					case op1 is 											--seprerate adi
					
					when "0001" | "0010" =>
						
							if ir4(5 downto 3) = ir2(8 downto 6) then
								p1 <= s5;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(5 downto 3) = ir2(5 downto 3) then
								p1 <= rf1;
								p2 <= s5;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" => --adi
						
							if ir4(5 downto 3) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
							when "0100"=>  --lw
								
								if ir4(5 downto 3) = ir2(8 downto 6) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
	
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s5;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "0101" => --SW
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s5;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "1111" => --JRI
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
							
								
							when "1101" => --JLR
						
							if ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s5;
								j := 1;							

								
							end if;
								

							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
								
							end case;
							

								
					when "1100" | "1101" => --jal and jlr, lli
								
							case op1 is 
							
							when "0001" | "0010" =>
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc14;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc14;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc14;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc14;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc14;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc14;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc14;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc14;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir5(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc14;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir5(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc14;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
							
							
							   when "0000" =>							
									
									case op1 is 
							
							when "0001" | "0010" =>
						
							if ir4(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s5;								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir4(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir4(8 downto 6) = ir2(8 downto 6) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir4(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s5;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir4(8 downto 6) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s5;
								j := 1;
							elsif ir4(8 downto 6) = ir2(8 downto 6) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir4(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir4(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s5;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
									
							  when "0100" =>							
									
									case op1 is 
							
							when "0001" | "0010" =>
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= mem_o;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= mem_o;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= mem_o;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= mem_o;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= mem_o;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= mem_o;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= mem_o;
								j := 1;
							elsif ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= mem_o;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir4(11 downto 9) = ir2(11 downto 9) then
								p1 <= mem_o;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir4(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= mem_o;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
									
							when others =>
										null;
										end case;
	 
							
							
							case op2 is 
              
                  when "0001" | "0010" |"0011" => --no memory. only rc is being fwd 

					case op1 is 											--seprerate adi
					
					when "0001" | "0010" =>
						
							if ir3(5 downto 3) = ir2(8 downto 6) then
								p1 <= s4;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(5 downto 3) = ir2(5 downto 3) then
								p1 <= rf1;
								p2 <= s4;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" => --adi
						
							if ir5(5 downto 3) = ir2(11 downto 9) then
								p1 <= s4;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
							when "0100"=>  --lw
								
								if ir3(5 downto 3) = ir2(8 downto 6) then
								p1 <= s4;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
	
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= s4;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s4;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "0101" => --SW
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s4;
								j := 1;
							elsif ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= s4;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
								
							when "1111" => --JRI
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= s4;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

								
							end if;
							
								
							when "1101" => --JLR
						
							if ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s4;
								j := 1;							

								
							end if;
								

							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
								
							end case;
							

								
					when "1100" | "1101" => --jal and jlr, lli
								
							case op1 is 
							
							when "0001" | "0010" =>
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc13;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc13;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc13;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc13;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc13;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= pc13;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc13;
								j := 1;
							elsif ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= pc13;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir3(11 downto 9) = ir2(11 downto 9) then
								p1 <= pc13;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir3(11 downto 9) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= pc13;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
							
							
							   when "0000" =>							
									
									case op1 is 
							
							when "0001" | "0010" =>
						
							if ir3(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s5;								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
                
						
							
						when  "0000" =>
						
							if ir3(8 downto 6) = ir2(11 downto 9) then
								p1 <= s5;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
							
						when "0100" =>
						
							if ir3(8 downto 6) = ir2(8 downto 6) then
								p1 <= s4;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							end if;
						
						
						when "1000" | "1001" | "1010" => --BEQ 
						
							if ir3(8 downto 6) = ir2(11 downto 9) then
								p1 <= s4;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							elsif ir3(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= s4;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								
							end if;
								
							when "0101" => --SW
						
							if ir3(8 downto 6) = ir2(11 downto 9) then
								p1 <= rf1;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s4;
								j := 1;
							elsif ir3(8 downto 6) = ir2(8 downto 6) then
								p1 <= s4;
								p2 <= ir2imm6;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;

							end if;
								
							when "1111" => --JRI
						
							if ir3(8 downto 6) = ir2(11 downto 9) then
								p1 <= s4;
								p2 <= ir2imm9;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								
								j := 1;
							end if;
							
								
							when "1101" => --JLR
						
							if ir3(8 downto 6) = ir2(8 downto 6) then
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= s4;
								j := 1;
								
							end if;
							
							
							when "0110" => --lm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when "0111" => --sm
								
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '0';
								ctrl2_stall <= '0';
								ctrl3_stall<='0';
								nop4<='0';
								p7 <= rf2;
								j := 1;
								when others =>
										null;
							
							end case;
									
							  when "0100" =>							
									
								p1 <= rf1;
								p2 <= rf2;
								ctrl1_stall <= '1';
								ctrl2_stall <= '1';
								ctrl3_stall<='1';
								nop4<='0';
								p7 <= rf2;
								j := 1;
							when others =>
										null;
										end case;
	 
					
					
				--	if j = 0 then	
				
							
						
						--else	
							
			
				
					--	end if;
					--	end if;
						end if;
						
						end process;
						end architecture;
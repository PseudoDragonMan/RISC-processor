library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c4 is 
    port(
        rst: in std_logic;
        ir3: in std_logic_vector(15 downto 0);
		  C_prev,Z_prev: in std_logic;
        ir4_wr,P3_wr,P4_wr,en_ALU2,en_ALU3,C_wr,Z_wr,P8_wr,pc1_wr: out std_logic;--pc1_wr only in JAL,JLR,
		  SEL_ALU3: out std_logic_vector(2 downto 0);
		  pipeline_wr,sign_mux: out std_logic
		 
    );
end entity;

architecture behav of c4 is
    signal opcode: std_logic_Vector(3 downto 0);
	 signal cond: std_logic_vector(2 downto 0);
	 signal P3wr: std_logic;
begin

    process(P3wr)
	 begin 
	     P3_wr<=P3wr;
		  P4_wr<=P3wr;
	end process;

    process(ir3)
    begin
        opcode <= ir3(15 downto 12);
    end process;

    process(ir3)
    begin
        cond <= ir3(2 downto 0);
    end process;	 

    process(rst, opcode,C_prev,Z_prev)
    begin
        if rst = '1' then  --will have this for stalling
           
            ir4_wr <= '0';
            P3wr <= '0';
				en_ALU2<='0';
				en_ALU3<='0';
				C_wr<='0';
				Z_wr <='0';
				SEL_ALU3<="111";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
        else
            case opcode is 
                when "0001" =>  --add
            if(cond ="000") then  --ADA   
						
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="000";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				elsif (cond ="010") then --ADC
				
				if(C_prev='1') then
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="000";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				else
            ir4_wr <= '1';
            P3wr <= '0';
				en_ALU2<='0';
				en_ALU3<='0';
				C_wr<='0';
				Z_wr <='0';
				SEL_ALU3<="111";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				end if;
				
				elsif (cond ="001") then --ADZ
				
				if(Z_prev='1') then
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="000";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				
				else
            ir4_wr <= '1';
            P3wr <= '0';
				en_ALU2<='0';
				en_ALU3<='0';
				C_wr<='0';
				Z_wr <='0';
				SEL_ALU3<="111";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				end if;
				
				
				elsif (cond="011") then --AWC
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="001";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				elsif (cond="100") then --ACA
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="010";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';

				elsif (cond="110") then --ACC
				if(C_prev='1') then
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="010";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				else
            ir4_wr <= '1';
            P3wr <= '0';
				en_ALU2<='0';
				en_ALU3<='0';
				C_wr<='0';
				Z_wr <='0';
				SEL_ALU3<="111";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				end if;
				
				elsif (cond="101") then --ACZ
				
				if(Z_prev='1') then
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="010";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				else
            ir4_wr <= '1';
            P3wr <= '0';
				en_ALU2<='0';
				en_ALU3<='0';
				C_wr<='0';
				Z_wr <='0';
				SEL_ALU3<="111";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
				
				end if;
				
				elsif (cond="111") then --ACW
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="011";
				pipeline_wr<='0';
				sign_mux<='0';
			   P8_wr<='0';	
				pc1_wr <='0';
				
				end if;

								
						
            when "0000" => --ADI
                 
					
            ir4_wr <= '1';
            P3wr <= '1';
				en_ALU2<='0';
				en_ALU3<='1';
				C_wr<='1';
				Z_wr <='1';
				SEL_ALU3<="000";
				pipeline_wr<='0';
				sign_mux<='0';
				P8_wr<='0';
				pc1_wr <='0';
					
				
				
                when "0010" => --NAND
					 
					   if (cond ="000") then --NDU
						      ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="100";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
						elsif (cond ="010") then --NDC
				         if (C_prev ='1') then 
				           ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="100";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
					      else 
							   ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
							end if;
						elsif (cond ="001") then --NDZ
						
						   if (Z_prev ='1') then 
				           ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="100";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
					      else 
							   ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
							end if;
							
						elsif(cond ="100") then --NCU
						      ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
						
						elsif (cond ="110") then --NCC
						
						   if (C_prev ='1') then 
				           ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
					      else 
							   ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
							end if;
							
						elsif(cond ="101") then	--NCZ
							
							if (z_prev ='1') then 
				           ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='1';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
					      else 
							   ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="111";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
							end if;
							
					end if;		
					    	
                when "0011" => --LLI
					         ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="101";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								

                when "0100" => --LW
  

						      ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="000";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
								
						
					when "0101" => --SW
					

						      ir4_wr <= '1';
                        P3wr <= '1';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="000";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='1';
								pc1_wr <='0';
								
								
					when "0110" => --LM
					         ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="100";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='1';
								pc1_wr <='0';
								
								
					when "0111" => --SM
					         ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="100";
				            pipeline_wr<='1';
								sign_mux<='0';
								P8_wr<='1';
								pc1_wr <='0';
								
								
					when "1000" | "1001" | "1010"=> --BEQ/BLT/BLE
					         ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='1';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="110";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';
						
						
					when "1100" => --JAL
  
	
					      	ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='1';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="100";
				            pipeline_wr<='0';
								sign_mux<='1';
								P8_wr<='1';
								pc1_wr <='1';

					when "1101" => --JLR
					
					         ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="000";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='1';
  
	
						

						
					when "1111" => --JRI
  
	
					      	ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='0';
				            en_ALU3<='1';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="000";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';

					when others =>
				            ir4_wr <= '1';
                        P3wr <= '0';
				            en_ALU2<='1';
				            en_ALU3<='0';
				            C_wr<='0';
				            Z_wr <='0';
				            SEL_ALU3<="000";
				            pipeline_wr<='0';
								sign_mux<='0';
								P8_wr<='0';
								pc1_wr <='0';


              
						


						
            end case;
        end if;
    end process;
end architecture;
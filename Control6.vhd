library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control6 is 
    port(
	     clk: in std_logic;
        rst: in std_logic;
        ir5: in std_logic_vector(15 downto 0);
		  pc1_i:in std_logic_vector(15 downto 0);
		  C_prev,Z_prev:in std_logic;
        rf_wr,rf_read,multi,mux_p56_en: out std_logic;
		  --the mux has 3 input lines p5,p6 and pc1_i pipeline register
		  --00->p5 01-->p6 10-->pc1_i
		  mux_p56_sel: out std_logic_vector(1 downto 0);
		  pipeline8_en:out std_logic;
		  rc: out std_logic_vector(2 downto 0);
	     rc_out:out std_logic_vector(7 downto 0) --for multiple case	  
    );
end entity;
--IR3-5//6-8
architecture a of control6 is
    signal opcode: std_logic_Vector(3 downto 0);
	 signal condition: std_logic_vector(1 downto 0);
begin

    process(ir5,clk)
    begin
        opcode <= ir5(15 downto 12);
    end process;

    process(rst, opcode,C_prev,Z_prev,clk)
    begin
        if rst = '1' then  --will have this for stalling
           
            rf_wr<='0';
				rf_read<='0';
				multi<='0';
				mux_p56_en<='0';
				mux_p56_sel<="00";
				rc<="000";
				pipeline8_en<='0';
				rc_out<="00000000";
				
        else
		     				  condition<=ir5(1 downto 0);

            case opcode is 
                when "0001" => --rc is being written into with data from p5					  
					     case condition is 						  
						      when  "00"=>
								 rf_wr<='1';
					          rf_read<='0';
					          multi<='0';
					          mux_p56_en<='1';
					          mux_p56_sel<="00";
					          rc<=ir5(5 downto 3);
					          pipeline8_en<='0';
					          rc_out<="00000000";
								 
								 when "10" =>
								  if(C_prev='1') then 
								   rf_wr<='1';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='1';
					            mux_p56_sel<="00";
					            rc<=ir5(5 downto 3);
					            pipeline8_en<='0';
					            rc_out<="00000000";
								  else 
									rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
						         pipeline8_en<='0';
						         rc_out<="00000000";
								end if;
								
								when "01"=>
								 if(Z_prev='1') then 
								   rf_wr<='1';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='1';
					            mux_p56_sel<="00";
					            rc<=ir5(5 downto 3);
					            pipeline8_en<='0';
					            rc_out<="00000000";
								  else 
									rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
						         pipeline8_en<='0';
						         rc_out<="00000000";
								end if;
							   
			               when others=>
			                  rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
					            pipeline8_en<='0';
					            rc_out<="00000000";	
					end case;				
						
                when "0000" => --rc is Rb and is being written into from p5
                 rf_wr<='1';
					  rf_read<='0';
					  multi<='0';
					  mux_p56_en<='1';
					  mux_p56_sel<="00";
					  rc<=ir5(8 downto 6);
					  pipeline8_en<='0';
					  rc_out<="00000000";
									
						
                when "0010" => --rc is RC and is being written into from p5
                 case condition is 						  
						      when  "00"=>
								 rf_wr<='1';
					          rf_read<='0';
					          multi<='0';
					          mux_p56_en<='1';
					          mux_p56_sel<="00";
					          rc<=ir5(5 downto 3);
					          pipeline8_en<='0';
					          rc_out<="00000000";
								 
								 when "10" =>
								  if(C_prev='1') then 
								   rf_wr<='1';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='1';
					            mux_p56_sel<="00";
					            rc<=ir5(5 downto 3);
					            pipeline8_en<='0';
					            rc_out<="00000000";
								  else 
									rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
						         pipeline8_en<='0';
						         rc_out<="00000000";
								end if;
								
								when "01"=>
								 if(Z_prev='1') then 
								   rf_wr<='1';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='1';
					            mux_p56_sel<="00";
					            rc<=ir5(5 downto 3);
					            pipeline8_en<='0';
					            rc_out<="00000000";
								  else 
									rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
						         pipeline8_en<='0';
						         rc_out<="00000000";
								end if;
							   
			               when others=>
			                  rf_wr<='0';
					            rf_read<='0';
					            multi<='0';
					            mux_p56_en<='0';
					            mux_p56_sel<="00";
					            rc<="000";
					            pipeline8_en<='0';
					            rc_out<="00000000";	
					end case;				
											  
					  when "0011"=> --rc is RA and is being written into from p5
					   
						rf_wr<='1';
						rf_read<='0';
						multi<='0';
						mux_p56_en<='1';
						mux_p56_sel<="00";
						rc<=ir5(11 downto 9);
						pipeline8_en<='0';
						rc_out<="00000000";
						
                when "0100" => --store in rc=RA and is being witten into from p6(comes from mem)
                  rf_wr<='1';
						rf_read<='0';
						multi<='0';
						mux_p56_en<='1';
						mux_p56_sel<="01";
						rc<=ir5(11 downto 9); 
						pipeline8_en<='0';
						rc_out<="00000000";
						
					when "0101" => --do nothing 
					   rf_wr<='0';
					   rf_read<='0';
					   multi<='0';
					   mux_p56_en<='0';
					   mux_p56_sel<="00";
					   rc<="000";
						pipeline8_en<='0';
						rc_out<="00000000";
										
					when "1000" | "1001" | "1010" => --do nothing	
						rf_wr<='0';
					   rf_read<='0';
					   multi<='0';
					   mux_p56_en<='0';
					   mux_p56_sel<="00";
					   rc<="000";
						rc_out<="00000000";
						
					when "1100" => --write into rc=RA with pc1
                  rf_wr<='1';
						rf_read<='0';
						multi<='0';
						mux_p56_en<='1';
						mux_p56_sel<="10";
						rc<=ir5(11 downto 9);
                  pipeline8_en<='0';
                  rc_out<="00000000"	;					

					when "1101" => --write into rc=RA with pc1
					   rf_wr<='1';
						rf_read<='0';
						multi<='0';
						mux_p56_en<='1';
						mux_p56_sel<="10";
						rc<=ir5(11 downto 9);
						pipeline8_en<='0';
						rc_out<="00000000";

						
					when "1111" => --do nothing 
					   rf_wr<='0';
					   rf_read<='0';
					   multi<='0';
					   mux_p56_en<='0';
					   mux_p56_sel<="00";
					   rc<="000";
						pipeline8_en<='0';
						rc_out<="00000000";
						
					when "1110" => --do nothing  (NOP)
					   rf_wr<='0';
					   rf_read<='0';
					   multi<='0';
					   mux_p56_en<='0';
					   mux_p56_sel<="00";
					   rc<="000";         
	               pipeline8_en<='0';
	               rc_out<="00000000"	;				
						
					when "0110" => --pipeline of 8 data being used to write in the rf add being given by imm 8 bits
                  rf_wr<='1';
						rf_read<='0';
						multi<='1';
						pipeline8_en<='1'; --PASSES THE 8 DATA 
						mux_p56_en<='0';
						mux_p56_sel<="00";
						rc<="000";
						rc_out<=ir5(7 downto 0);
						
					when "0111" =>	 --do nothing
						rf_wr<='1';
					   rf_read<='0';
					   multi<='1';
					   mux_p56_en<='1';
					   mux_p56_sel<="10";
					   rc<="000";         
	               pipeline8_en<='0';
						rc_out<="00000000";
				 
				   when others => --do nothing 					
					   rf_wr<='0';
					   rf_read<='0';
					   multi<='0';
					   mux_p56_en<='0';
					   mux_p56_sel<="00";
					   rc<="000";         
	               pipeline8_en<='0';
						rc_out<="00000000";
						
            end case;
        end if;
    end process;
end architecture;
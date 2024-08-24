library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control3 is 
    port(
        rst,clk: in std_logic;
        ir2: in std_logic_vector(15 downto 0);
        rf_read, pr_write, pc_pipe, pc_rst, pc1_rst, pc1_pipe, p1_write, p2_write, ir3_write, multi, p7_write, p7_rst: out std_logic;
        ra, rb: out std_logic_vector(2 downto 0)
    );
end entity control3;

architecture a of control3 is
    signal opcode: std_logic_vector(3 downto 0);
begin

    process(clk,ir2)
	  begin
	       opcode<=ir2(15 downto 12);
	 end process; 
	 
    process(clk, opcode, ir2)
    begin

        if rst = '1' then
            pc_rst <= '0';
            pc1_rst <= '0';
            pc_pipe <= '0';
            pc1_pipe <= '0';
            rf_read <= '0';
            p1_write <= '0';
            p2_write <= '0';
            ir3_write <= '0';
            multi <= '0';
            p7_write <= '0';
            pr_write <= '0';
            p7_rst <= '0';
            ra <= "000";
            rb <= "000";
        else
    
            case opcode is 
                when "0001" => --no mux only ra and rb
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    p1_write <= '1';
                    p2_write <= '1';
                    rf_read <= '1';
                    ir3_write <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);
                        
                when "0000" => --ra and imm (Store in rb)
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    p1_write <= '1';
                    p2_write <= '1';
                    rf_read <= '1';
                    ir3_write <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(8 downto 6);
                    rb <= ir2(11 downto 9);
                        
                when "0010" => --no mux ra and rb
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    p1_write <= '1';
                    p2_write <= '1';
                    ir3_write <= '1';
                    rf_read <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);
                        
                when "0100" => --add ra and imm (store in rb)
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    p1_write <= '1';
                    p2_write <= '1';
                    rf_read <= '1';
                    pr_write <= '0';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '1';
                    ra <= ir2(8 downto 6);
                    rb <= ir2(11 downto 9);
                        
                when "0101" => --add ra and imm. read from rb
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    rf_read <= '1';
                    p1_write <= '1';
                    p2_write <= '1';
                    ir3_write <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '1';
                    p7_rst <= '0';
                    ra <= ir2(8 downto 6);
                    rb <= ir2(11 downto 9);
                        
                when "1000" | "1001" | "1010" => --ra and rb are read
                    pc_rst <= '0';
                    pc1_rst <= '1';
                    pc_pipe <= '1';
                    pc1_pipe <= '0';
                    rf_read <= '1';
                    p1_write <= '1';
                    p2_write <= '1';
                    pr_write <= '0';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '1';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);
                        
                when "1100" => --nothing is being read
                    pc_rst <= '0';
                    pc1_rst <= '0';
                    pc_pipe <= '1';
                    pc1_pipe <= '1';
                    p1_write <= '0';
                    pr_write <= '0';
                    p2_write <= '0';
                    ir3_write <= '1';
                    rf_read <= '0';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '1';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when "1101" => --read rb
                    pc_rst <= '1';
                    pc1_rst <= '0';
                    pc_pipe <= '0';
                    pc1_pipe <= '1';
                    p1_write <= '1';
                    pr_write <= '0';
                    rf_read <= '1';
                    p2_write <= '1';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '1';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when "1111" => --read ra
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    pr_write <= '0';
                    rf_read <= '1';
                    p1_write <= '1';
                    p2_write <= '1';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '1';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when "1110" => --no operation
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    pr_write <= '0';
                    p1_write <= '0';
                    p2_write <= '0';
                    rf_read <= '0';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when "0110" => --read ra for mem address
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    p1_write <= '0';
                    p2_write <= '0';
                    rf_read <= '1';
                    ir3_write <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '1';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(11 downto 9);

                when "0111" =>
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    rf_read <= '1';
                    p1_write <= '0';
                    p2_write <= '0';
                    ir3_write <= '1';
                    pr_write <= '1';
                    multi <= '1';
                    p7_write <= '1';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when "0011" =>
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    rf_read <= '0';
                    p1_write <= '1';
                    p2_write <= '1';
                    ir3_write <= '1';
                    pr_write <= '0';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);

                when others =>
                    pc_rst <= '1';
                    pc1_rst <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    pr_write <= '0';
                    p1_write <= '0';
                    p2_write <= '0';
                    rf_read <= '0';
                    ir3_write <= '1';
                    multi <= '0';
                    p7_write <= '0';
                    p7_rst <= '0';
                    ra <= ir2(11 downto 9);
                    rb <= ir2(8 downto 6);
            end case;
        end if;
    end process;
end architecture a;
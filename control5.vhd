library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control5 is 
    port(
        rst, clk: in std_logic;
        ir4: in std_logic_vector(15 downto 0);
        mem_read, mem_write, mema_sel, pm_write, pc1_pipe, p5_write, p6_write, ir5_write, multi, p5_rst, p6_rst: out std_logic;
        ra, rb: out std_logic_vector(2 downto 0)
    );
end entity control5;

architecture a of control5 is
    signal opcode: std_logic_vector(3 downto 0);
begin

    process(clk,ir4)
	  begin
	       opcode<=ir4(15 downto 12);
	 end process; 
	 
    process(clk, opcode, ir4)
    begin
	 
       if rst = '1' then
            -- Reset state
            mem_read <= '0';
            mem_write <= '0';
            mema_sel <= '0';
            pm_write <= '0';
            pc1_pipe <= '0';
            p5_write <= '0';
            p6_write <= '0';
            ir5_write <= '0';
            multi <= '0';
            p5_rst <= '0';
            p6_rst <= '0';
            ra <= (others => '0');
            rb <= (others => '0');
      else        
            -- Opcode-specific assignments
            case opcode is
                when "0001" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '1';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '0';
                    p6_rst <= '1';
                    
                when "0000" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '1';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '0';
                    p6_rst <= '1';
                    
                when "0010" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '1';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '0';
                    p6_rst <= '1';
                    
                when "0100" =>
                    mem_read <= '1';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '1';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '0';
                    
                when "0101" =>
                    mem_read <= '0';
                    mem_write <= '1';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "1000" | "1001" | "1010" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "1100" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '1';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "1101" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '1';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "1111" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "1110" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "0110" =>
                    mem_read <= '1';
                    mem_write <= '0';
                    mema_sel <= '1';
                    pm_write <= '1';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '1';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "0111" =>
                    mem_read <= '0';
                    mem_write <= '1';
                    mema_sel <= '1';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '0';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '1';
                    p5_rst <= '1';
                    p6_rst <= '1';
                    
                when "0011" =>
                    mem_read <= '0';
                    mem_write <= '0';
                    mema_sel <= '0';
                    pm_write <= '0';
                    pc1_pipe <= '0';
                    p5_write <= '1';
                    p6_write <= '0';
                    ir5_write <= '1';
                    multi <= '0';
                    p5_rst <= '0';
                    p6_rst <= '1';
                    
                when others =>
                -- Handle remaining opcodes or invalid cases
					    mem_read <= '0';
                   mem_write <= '0';
                   mema_sel <= '0';
                   pm_write <= '0';
                   pc1_pipe <= '0';
                   p5_write <= '0';
                   p6_write <= '0';
                   ir5_write <= '0';
                   multi <= '0';
                   p5_rst <= '0';
                   p6_rst <= '0';
                   ra <= (others => '0');
                   rb <= (others => '0');
            end case;
        end if;
		 
    end process;
end architecture a;

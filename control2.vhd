library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control2 is 
    port(
        rst: in std_logic;
        ir1: in std_logic_vector(15 downto 0);
        ir2_write, pc_pipe, pc1_pipe, pc_rst, pc1_rst: out std_logic
    );
end entity;

architecture a of control2 is
    signal opcode: std_logic_Vector(3 downto 0);
begin

    process(ir1)
    begin
        opcode <= ir1(15 downto 12);
    end process;

    process(rst, opcode)
    begin
        if rst = '1' then  --will have this for stalling
            ir2_write <= '0';
            pc_pipe <= '0';
            pc1_pipe <= '0';
            pc_rst <= '0';
            pc1_rst <= '0';
        else
            case opcode is 
                when "1110" =>
                    ir2_write <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    pc_rst <= '1';
                    pc1_rst <= '1';
                when "1000" | "1001" | "1010" =>
                    ir2_write <= '1';
                    pc_pipe <= '1';
                    pc1_pipe <= '0';
                    pc_rst <= '0';
                    pc1_rst <= '1';
                when "1100" =>
                    ir2_write <= '1';
                    pc_pipe <= '1';
                    pc1_pipe <= '1';
                    pc_rst <= '0';
                    pc1_rst <= '0';
                when "1101" =>
                    ir2_write <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '1';
                    pc_rst <= '1';
                    pc1_rst <= '0';
                when others =>
                    ir2_write <= '1';
                    pc_pipe <= '0';
                    pc1_pipe <= '0';
                    pc_rst <= '1';
                    pc1_rst <= '1';
            end case;
        end if;
    end process;
end architecture;

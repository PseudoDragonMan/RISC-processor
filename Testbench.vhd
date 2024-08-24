library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench is
end entity Testbench;

architecture testbencho of Testbench is
    -- Component declaration
    component CPU is
        port (
            clk, rst: in std_logic;
            -- Inputs
            -- Outputs
            i1, i2, i3, i_1,i4, alu3op,dd1,dd2,dd3,alu3at,alu3bt,i5, i6,ddin, pc, r0, r1, r2, r3, r4, r5, r6, r7: out std_logic_vector(15 downto 0);
       selalu: out std_logic_vector(2 downto 0) ;c: out std_logic_vector(0 downto 0);ifw1,stall:out std_logic);
    end component CPU;

    -- Signals declaration
    signal clk, rst,ifw1,stall: std_logic;
    signal i1, i2,i_1, i3,ddin, alu3op,alu3at,alu3bt,i4,dd1,dd2,dd3, i5, i6, pc, r0, r1, r2, r3, r4, r5, r6, r7: std_logic_vector(15 downto 0);
	signal selalu: std_logic_vector(2 downto 0);
	signal c: std_logic_vector(0 downto 0)	;
begin
    -- Instantiate the Unit Under Test (UUT)
    dut: CPU port map(
        clk => clk,
        rst => rst,
        i1 => i1,
		  i_1=>i_1,
        i2 => i2,
        i3 => i3,
        i4 => i4,
        i5 => i5,
        i6 => i6,
        pc => pc,
        r0 => r0,
        r1 => r1,
        r2 => r2,
        r3 => r3,
        r4 => r4,
        r5 => r5,
        r6 => r6,
        r7 => r7,ddin=>ddin,dd1=>dd1,dd2=>dd2,dd3=>dd3,alu3op=>alu3op,
		  alu3at=>alu3at,alu3bt=>alu3bt,selalu=>selalu,c=>c,
		  ifw1=>ifw1,stall=>stall
    );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- Initialize inputs
        rst <= '1';
        wait for 20 ns;
		  wait for 10 ns;
        rst <= '0';
        wait for 20 ns;
        -- Further stimuli can be added here
        wait;
    end process;

end architecture testbencho;

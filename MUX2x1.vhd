library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MUX2x1 is
   port(
      S0: in std_logic;
      X0, X1: in std_logic_vector(15 downto 0);
      Y: out std_logic_vector(15 downto 0);
      mux_en: in std_logic
   );
end MUX2x1;
  
architecture struct of MUX2x1 is
begin
   mux21 : process (S0, X0, X1, mux_en)
   begin
      if mux_en = '0' then
         Y <= (others => '0'); -- Output is all zeros
      else 
         if S0 = '0' then
         Y <= X0;
        elsif S0='1' then 
         Y <= X1;
         end if;
      end if;
   end process mux21;
end struct;

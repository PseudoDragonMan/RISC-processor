library ieee;
use ieee.std_logic_1164.all;
  
entity MUX3x1 is
   port(
      S: in std_logic_vector(1 downto 0);
      X0, X1, X2: in std_logic_vector(15 downto 0);
      Y: out std_logic_vector(15 downto 0);
      mux_en: in std_logic
   );
end MUX3x1;
  
architecture struct of MUX3x1 is
begin
   mux41 : process (S, X0, X1, X2, mux_en)
   begin
      if mux_en = '0' then
         Y <= (others => '0'); -- Output is all zeros when mux is disabled
      else
          if S="00" then
           Y<=X0;
          elsif S = "01" then
            Y <=X1;
          elsif S="10" then 
            Y <= X2;
          else 
            Y<=(others => '0');
         end if;
      end if;
   end process mux41;
end struct;
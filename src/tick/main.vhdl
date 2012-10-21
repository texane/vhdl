library ieee;
use ieee.std_logic_1164.all;

library work;
use work.tick_utils.all;

entity main is end entity main;

architecture fu of main is
 signal clk: std_ulogic := '0';
begin
 h: entity work.tick port map(clk => clk);

 process is
 begin
 end process;
 
end fu;

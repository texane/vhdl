library ieee;
use ieee.std_logic_1164.all;

use std.textio.all;

entity main is end main;

architecture fu of main is
 signal clk : std_logic := '0';
begin

 process(clk)
  variable l : line;
 begin
  clk <= clk xor '1' after 1 sec ;
  write(l, string'("bar"));
  writeline(output, l);
 end process;

end fu;

use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is end entity;

architecture rtl of main is

 signal clk : std_logic := '0';
 signal bar : std_logic := '0';

begin

 process(clk)
 begin
  clk <= clk xor '1' after 1 ns;
 end process;

 process
  variable l : line;
 begin
  write(l, String'("a"));
  writeline(output, l);
  wait on clk;

  write(l, String'("b"));
  writeline(output, l);
  wait on clk;

  wait on bar;
  
 end process;

end rtl;

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
library work;
use work.rt_utils.all;

entity main is end entity;

architecture fu of main is
 signal clk : std_ulogic := '0';
begin

 -- instantiate main clock
 main_clock:
  entity work.rt_clk
  generic map(ms => 2000)
  port map(clk => clk);

 process(clk)
  variable l : line;
 begin
  write(l, 'x');
  writeline(output, l);
 end process;

end fu;

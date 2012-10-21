library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity main is end entity;

architecture fu of main is
 signal x: std_ulogic := '0';
begin

 process
 begin
  x <= x xor '1';
  wait for 1 ns ;
 end process;

 process(x)
  variable l: line;
  variable i: integer := 0;
 begin
  i := i + 1;
  write(l, String(integer'image(i)));
  writeline(output, l);
 end process;

end fu;

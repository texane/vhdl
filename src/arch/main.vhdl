-- baz entity

use std.textio.all;

entity baz is end baz;

architecture fu of baz is
 signal once : bit_vector(1 downto 0);
begin
 process (once)
  variable l : line;
 begin
  write(l, String'("fu architecture"));
  writeline(output, l);
 end process ;
end fu;

architecture bar of baz is
 signal once : bit_vector(1 downto 0);
begin
 process (once)
  variable l : line;
 begin
  write(l, String'("bar architecture"));
  writeline(output, l);
 end process ;
end bar;

-- main entity

entity main is end entity ;

architecture fu of main is
begin
 h: entity work.baz(bar) ;
end fu ;

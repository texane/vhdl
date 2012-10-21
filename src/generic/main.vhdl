-- baz entity

use std.textio.all;

entity baz is
 generic( x : integer := 500 );
end baz;

architecture bar of baz is
 signal once : bit_vector(1 downto 0);
begin
 process (once)
  variable l : line;
 begin
  write(l, String'("bar architecture "));
  write(l, integer'image(x));
  writeline(output, l);
 end process ;
end bar;

-- main entity

use work.all ;

entity main is end entity ;

architecture fu of main is
begin
 h: entity baz generic map( x => 10 ) ;
end fu ;

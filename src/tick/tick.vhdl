--

library ieee;
use ieee.std_logic_1164.all;

package tick_utils is
 procedure get_tick(x: out std_ulogic);
 attribute foreign of get_tick: procedure is "VHPIDIRECT get_tick";
end tick_utils;

package body tick_utils is
 procedure get_tick(x: out std_ulogic) is
 begin
   assert false report "VHPI" severity failure;
 end get_tick;
end tick_utils;


--

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.tick_utils.all;

entity tick is
 port(clk: inout std_ulogic := '0');
end entity;

architecture fu of tick is
 begin
  process
   begin
    clk <= clk xor '1';
   end process;
end fu;

library ieee;
use ieee.std_logic_1164.all;

use work.sbone;

entity main is end main;

architecture rtl of main is
 signal clk: std_ulogic;
begin
 sbone_reg: sbone.reg_core port map(clk => clk);
end rtl;

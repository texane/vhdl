-- package definition

library ieee;
use ieee.std_logic_1164.all;

package sbone is
component reg_core is
 port
 (
  clk: in std_ulogic
 );
end component reg_core;
end package sbone;


-- sbone.reg defintion

library ieee;
use ieee.std_logic_1164.all;

-- sbone.reg entity
entity reg_core is
 port
 (
  clk: in std_ulogic
 );
end entity;

-- sbone.reg architecture
architecture rtl of reg_core is
begin
end rtl;

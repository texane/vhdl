library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
 port
 (
  rst: std_ulogic;
  clk: in std_ulogic
 );
end tb;

architecture tb_arch of tb is
 signal den: std_ulogic;
 signal ida: unsigned(7 downto 0);
 signal oda: unsigned(7 downto 0);
begin

 accum_label:
 entity work.accum
 port map
 (
  rst => rst,
  clk => clk,
  den => den,
  ida => ida,
  oda => oda
 );

end tb_arch;

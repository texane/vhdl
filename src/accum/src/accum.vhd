library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accum is
 port
 (
  rst: in std_ulogic;
  clk: in std_ulogic;
  den: in std_ulogic;
  ida: in unsigned(7 downto 0);
  oda: out unsigned(7 downto 0)
 );
end accum;

architecture accum_arch of accum is
 signal x: unsigned(7 downto 0);
begin
 process(rst, clk)
 begin
  if rst = '1' then
   x <= (others => '0');
  elsif rising_edge(clk) and den = '1' then
   x <= x + ida;
  end if;
 end process;
 oda <= x;
end accum_arch;

-- counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
 generic
 (
  GENERIC_WIDTH: natural := 32
 );
 port
 (
  rst: in std_ulogic;
  clk: in std_ulogic;
  odat: out std_ulogic_vector(GENERIC_WIDTH - 1 downto 0);
  ovf: out std_ulogic
 );
end counter;

architecture counter_arch of counter is
 signal x: unsigned(GENERIC_WIDTH - 1 downto 0);
begin

 odat <= std_ulogic_vector(x);

 process(rst, clk)
 begin
  if rst = '1' then
   x <= (others => '0');
  elsif rising_edge(clk) then
   ovf <= '0';
   if x = (x'range => '1') then
    ovf <= '1';
   end if;
   x <= x + 1;
  end if; -- clk
 end process;
end counter_arch;

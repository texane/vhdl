-- test bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
 port
 (
  signal clk: in std_ulogic
 );
end tb;

architecture tb_arch of tb is
 signal rst: std_ulogic;
 signal odat: std_ulogic_vector(7 downto 0);
 signal ovf: std_ulogic;
begin

 -- counter

 counter_label:
 entity work.counter
 generic map
 (
  GENERIC_WIDTH => 8
 )
 port map
 (
  rst => rst,
  clk => clk,
  odat => odat,
  ovf => ovf
 );

 -- reset logic
 process
 begin
  rst <= '0';
  wait for 10 ns;
  rst <= '1';
  wait for 10 ns;
  rst <= '0';
  wait ;
 end process;

end tb_arch;

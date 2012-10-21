library ieee;
use ieee.std_logic_1164.all;

entity gt is
 port
 (
  clk: in std_logic;
  a, b: in std_logic;
  c: out std_logic
 );
end gt;

architecture rtl of gt is
begin
 c <= (a and '1') and ((not b) and '1');
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity main is end main;
architecture rtl of main is
 signal a: std_logic := '0';
 signal b: std_logic := '0';
 signal c: std_logic := '0';
 signal clk : std_logic := '0';
begin

 gt: entity work.gt port map(clk => clk, a => a, b => b, c => c);

 process(clk)
 begin
  clk <= clk xor '1' after 1 ns;
 end process;

 process
  variable done: integer := 0;
 begin

  if done = 0 then

  wait until rising_edge(clk);

  a <= '0';
  b <= '0';
  wait until rising_edge(clk);

  a <= '1';
  b <= '0';
  wait until rising_edge(clk);

  a <= '0';
  b <= '1';
  wait until rising_edge(clk);

  a <= '1';
  b <= '1';
  wait until rising_edge(clk);

  done := 1;

  a <= '0';
  b <= '0';

  end if;

  wait until rising_edge(clk);  

 end process;
end rtl;

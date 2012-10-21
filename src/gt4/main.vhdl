-- 1 bit greater or equal

library ieee;
use ieee.std_logic_1164.all;

entity geq is
 port
 (
  o: in std_logic;
  a, b: in std_logic;
  c: out std_logic
 );
end geq;

architecture rtl of geq is
begin
 -- o used to override the result
 c <= (not o) and (((a and '1') and ((not b) and '1')) or ((a and b) or ((not a) and (not b))));
end rtl;


-- 4 bit greater or equal

library ieee;
use ieee.std_logic_1164.all;

entity gt4 is
 port
 (
  a, b: in std_logic_vector(3 downto 0);
  c: out std_logic
 );
end gt4;

architecture rtl of gt4 is
 signal res4: std_logic := '0';
 signal res3: std_logic := '1';
 signal res2: std_logic := '1';
 signal res1: std_logic := '1';
 signal res0: std_logic := '1';
begin
 gt3: entity work.geq port map( o => res4, a => a(3), b => b(3), c => res3 );
 gt2: entity work.geq port map( o => res3, a => a(2), b => b(2), c => res2 );
 gt1: entity work.geq port map( o => res2, a => a(1), b => b(1), c => res1 );
 gt0: entity work.geq port map( o => res1, a => a(0), b => b(0), c => res0 );
 c <= not res0;
end rtl;


-- main

library ieee;
use ieee.std_logic_1164.all;

entity main is end main;
architecture rtl of main is
 signal a: std_logic_vector(3 downto 0) := x"0";
 signal b: std_logic_vector(3 downto 0) := x"0";
 signal c: std_logic := '0';
 signal clk : std_logic := '0';
begin

 gt4: entity work.gt4 port map(a => a, b => b, c => c);

 process(clk)
 begin
  clk <= clk xor '1' after 1 ns;
 end process;

 process
  variable done: integer := 0;
 begin

  if done = 0 then

  wait until rising_edge(clk);
  wait until rising_edge(clk);

  a <= x"8";
  b <= x"7";
  wait until rising_edge(clk);
  wait until rising_edge(clk);

  a <= x"7";
  b <= x"8";
  wait until rising_edge(clk);
  wait until rising_edge(clk);

  a <= x"f";
  b <= x"8";
  wait until rising_edge(clk);
  wait until rising_edge(clk);

  done := 1;

  a <= x"0";
  b <= x"0";

  end if;

  wait until rising_edge(clk);  

 end process;
end rtl;

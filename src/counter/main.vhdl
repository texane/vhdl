library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
 generic
 (
  WIDTH: natural
 );
 port
 (
  rst: in std_logic;
  clk: in std_logic;
  ovf: out std_logic
 );
end counter;

architecture rtl of counter is
 signal x: unsigned(WIDTH - 1 downto 0);
 constant ones: natural := (2 ** WIDTH) - 1;
begin

 process(rst, clk)
 begin
  if rst = '1' then
   ovf <= '0';
   x <= to_unsigned(0, WIDTH);
  elsif rising_edge(clk) then
   ovf <= '0';
   x <= x + 1;
   if x = ones then
    ovf <= '1';
   end if;
  end if;
 end process;

end rtl;


-- main entity

library ieee;
use ieee.std_logic_1164.all;

entity main is end entity ;

architecture rtl of main is
 signal rst : std_logic;
 signal clk : std_logic := '0';
 signal ovf : std_logic;
begin

 c: entity work.counter
 generic map(WIDTH => 4)
 port map(rst => rst, clk => clk, ovf => ovf);

 process(rst, clk)
  variable done: integer := 0;
 begin
  rst <= '0';
  if rising_edge(clk) and done = 0 then
   rst <= '1';
   done := 1;
  end if;
 end process;

 process(clk, rst)
 begin
  clk <= clk xor '1' after 1 ns;
 end process;

end rtl;

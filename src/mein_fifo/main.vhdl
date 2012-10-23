-- nlog2
package utils is
 function Nlog2(x: natural) return integer;
end package utils;

package body utils is

function Nlog2(x: natural) return integer is 
 variable j: integer := 0; 
begin 
 for i in 1 to 31 loop
  if (2**i >= x) then
   j := i; exit; end if;
 end loop;
 return j;
end Nlog2; 

end package body utils;

-- fifo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
 generic
 (
  constant DATA_WIDTH: natural := 8; -- in bits
  constant FIFO_DEPTH: natural := 8 -- slot count, assert(pow2)
 );
 port
 (
  rst: in std_logic;
  clk: in std_logic;
  rdata: out std_logic_vector((DATA_WIDTH - 1) downto 0);
  ren: in std_logic;
  wdata: in std_logic_vector((DATA_WIDTH - 1) downto 0);
  wen: in std_logic;
  count: out unsigned(work.utils.Nlog2(FIFO_DEPTH) downto 0)
 );
end fifo;

architecture rtl of fifo is
 constant FIFO_DEPTH_BITS: natural := work.utils.Nlog2(FIFO_DEPTH);

 -- 1 more bit is used in write pointer to avoid overflow
 -- thus, wpointer must be masked when accessing memory
 -- count: wpointer - rpointer
 -- is_empty: count == 0
 -- is_full: count == FIFO_DEPTH

 signal wpointer: unsigned((1 + FIFO_DEPTH_BITS - 1) downto 0);
 signal rpointer: unsigned((FIFO_DEPTH_BITS - 1) downto 0);

 type buf_type is
  array((FIFO_DEPTH - 1) downto 0) of
  std_logic_vector((DATA_WIDTH - 1) downto 0);
 signal buf: buf_type; 
 attribute ram_style: string;
 attribute ram_style of buf: signal is "auto"; -- or "block" or "distributed"

begin
 -- checks
 assert FIFO_DEPTH = (2 ** FIFO_DEPTH_BITS)
 report "FIFO_DEPTH must be a pow2"
 severity failure;

 -- sync read logic
 process(clk)
 begin
  if rising_edge(clk) then
   if rst = '1' then
    rpointer <= (others => '0');
   elsif ren = '1' then
    rdata <= buf(to_integer(rpointer(FIFO_DEPTH_BITS - 1 downto 0)));
    rpointer <= rpointer + 1;
   end if;
  end if;
 end process;

 -- sync write logic
 process(clk, rst)
 begin
  if rising_edge(clk) then
   if rst = '1' then
    wpointer <= (others => '0');
   elsif wen = '1' then
    buf(to_integer(wpointer(FIFO_DEPTH_BITS - 1 downto 0))) <= wdata;
    wpointer <= wpointer + 1;
   end if;
  end if;
 end process;

 -- count logic
 process(rst, clk, wpointer, rpointer)
 begin
  if rising_edge(clk) then
   if rst = '1' then
    count <= (others => '0');
   else
    count <= wpointer - rpointer;
   end if;
  end if;
 end process;

end rtl;


-- main

use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is end main;

architecture rtl of main is

 constant DATA_WIDTH: natural := 8;
 constant FIFO_DEPTH: natural := 4;
 constant FIFO_DEPTH_BITS : natural := work.utils.Nlog2(FIFO_DEPTH) + 1;

 signal clk: std_logic := '0';
 signal rst: std_logic := '1';

 signal rdata: std_logic_vector((DATA_WIDTH - 1) downto 0);
 signal wdata: std_logic_vector((DATA_WIDTH - 1) downto 0);
 signal ren: std_logic;
 signal wen: std_logic;
 signal count: unsigned(FIFO_DEPTH_BITS - 1 downto 0);

begin

 process(clk)
  variable done: natural := 0;
 begin
  clk <= clk xor '1' after 1 ns;
  if rising_edge(clk) then
   rst <= '0';
   if done = 0 then
    done := 1;
    rst <= '1';
   end if;
  end if;
 end process;

 f:
 entity work.fifo
 generic map(DATA_WIDTH => DATA_WIDTH, FIFO_DEPTH => FIFO_DEPTH)
 port map
 (
  rst => rst,
  clk => clk,
  rdata => rdata,
  ren => ren,
  wdata => wdata,
  wen => wen,
  count => count
 );

 process
  variable done: natural := 0;
 begin

  ren <= '0';
  wen <= '0';

  if done = 0 then
   if count /= FIFO_DEPTH then

    wait until rising_edge(clk);
    wait until rising_edge(clk);

    wen <= '1';
    wdata <= x"20";
    wait until rising_edge(clk);
    wen <= '0';

    wen <= '1';
    wdata <= x"21";
    wait until rising_edge(clk);
    wen <= '0';

    wen <= '1';
    wdata <= x"22";
    wait until rising_edge(clk);
    wen <= '0';

    wen <= '1';
    wdata <= x"23";
    wait until rising_edge(clk);
    wen <= '0';

    wen <= '1';
    wdata <= x"24";
    wait until rising_edge(clk);
    wen <= '0';

    ren <= '1';
    wait until rising_edge(clk);
    ren <= '0';

    ren <= '1';
    wait until rising_edge(clk);
    ren <= '0';

   end if;
  done := 1;

 end if; -- done

 wait until rising_edge(clk);

 end process;

end rtl;

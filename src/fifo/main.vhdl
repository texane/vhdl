-- baz entity

use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- main entity

entity main is end entity ;

architecture fu of main is

 signal arst : std_logic := '1';
 signal clk : std_logic := '0';
 signal wr_en : std_logic := '0';
 signal wr_dat : std_logic_vector(7 downto 0) := x"00";
 signal wr_cnt : std_logic_vector(3 downto 0) := x"0";
 signal wr_afull : std_logic := '0';
 signal wr_full : std_logic := '0';
 signal rd_en : std_logic := '0';
 signal rd_dat : std_logic_vector(7 downto 0) := x"00";
 signal rd_aempty : std_logic := '1';
 signal rd_empty : std_logic := '1';

begin

 main_fifo:
 entity work.fifo_s
 generic map
 (
  DWIDTH => 8,
  ADEPTH => 8
 )
 port map
 (
  arst => arst,
  clk => clk,
  wr_en => wr_en,
  wr_dat => wr_dat,
  wr_cnt => wr_cnt,
  wr_afull => wr_afull,
  wr_full => wr_full,
  rd_en => rd_en,
  rd_dat => rd_dat,
  rd_aempty => rd_aempty,
  rd_empty => rd_empty
 );

 -- ticker
 process(clk)
  variable l : line;
 begin
  clk <= clk xor '1' after 1 ns;
  arst <= '0' after 4 ns;
 end process;

 -- actual reader
 process(clk, rd_en, arst)
  variable l : line;
  variable d : integer;
 begin
  if rising_edge(clk) and (arst = '0') and (rd_en = '1') then
   d := to_integer(signed(rd_dat));
   write(l, String'("read "));
   write(l, integer'image(d));
   writeline(output, l);
  end if;
 end process;

 -- reader
 process(clk, arst, rd_empty, rd_en)
 begin
  if rising_edge(clk) and (arst = '0') then
   if (rd_en = '1') then rd_en <= '0';
   elsif (rd_empty = '0') then rd_en <= '1';
   end if;
  end if;
 end process;

 -- writer
 process(clk)
  variable counter : integer := 0;
  variable l : line;
 begin
  if rising_edge(clk) then
  counter := counter + 1;
  wr_en <= '0';
  if (counter mod 7) = 0 then
   wr_dat <= std_logic_vector(to_unsigned(counter, 8));
   wr_en <= '1';
   write(l, String'("write"));
   writeline(output, l);
  end if;
 end if;
 end process;

end fu ;

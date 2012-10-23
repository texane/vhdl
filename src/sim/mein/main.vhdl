-- processor

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
 port
 (
  signal clk: in std_logic;
  signal rst: in std_logic;
  signal do_term: out std_logic;
  signal idata: in unsigned(7 downto 0);
  signal iavail: in std_logic;
  signal odata: out unsigned(7 downto 0);
  signal oavail: out std_logic
 );
end processor;

architecture rtl of processor is
 signal count: unsigned(7 downto 0);
begin
 process(clk)
 begin
  if rising_edge(clk) then
   oavail <= '0';
   do_term <= '0';

   if rst = '1' then
    count <= (others => '0');
   elsif count >= 4 then
    do_term <= '1';
   elsif iavail = '1' then
    count <= count + 1;
   end if;

  end if;
 end process;
end rtl;


-- main

library work;
use work.ghpi_pipe.all;
use work.txt_util.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is end main;
architecture rtl of main is

 signal clk: std_logic := '0';
 signal rst: std_logic := '1';

 signal do_term: std_logic;

 shared variable ipipe : pipehandle_t;

 signal idata: unsigned(7 downto 0);
 signal odata: unsigned(7 downto 0);
 signal iavail: std_logic;
 signal oavail: std_logic;

begin

 p: entity work.processor
 port map
 (
  clk => clk,
  rst => rst,
  do_term => do_term,
  idata => idata,
  iavail => iavail,
  odata => odata,
  oavail => oavail
 );

 -- clock process

 process
  variable done: natural := 0;
 begin
  ipipe := openpipe("/tmp/ipipe");
  if ipipe < 0 then
   assert false report "ipipe error" severity failure;
  end if;

  -- reset logic
  rst <= '1';
  wait for 1 us;
  clk <= clk xor '1';
  wait for 1 us;
  clk <= clk xor '1';
  rst <= '0';

  loop
   wait for 1 us;
   clk <= clk xor '1';
   if do_term = '1' then
    wait for 2 ms;
    exit;
   end if;
  end loop;

  print("-- DONE --");
  closepipe(ipipe);

  wait;

 end process;

 -- read process

 process(clk)
  variable iflags: pipeflag_t;
  variable idata: unsigned(7 downto 0);
 begin
  if rst = '1' then
   iflags := "0000";
   iavail <= '0';
  elsif rising_edge(clk) then
   iavail <= '0';
   pipe_in(ipipe, idata, iflags);
   if iflags(RX) = '1' then
    print("GOT ONE");
    iavail <= '1';
   end if;
  end if;
 end process;

end rtl;

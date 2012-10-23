library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;

entity fsm is
 port
 (
  rst: in std_logic;
  clk: in std_logic;
  do_start: in std_logic;
  status: out std_logic
 );
end fsm;

architecture rtl of fsm is
 type state_type is (STATE_START, STATE_WAIT, STATE_STOP);
 signal curr_state: state_type;
 signal next_state: state_type;
begin

 -- state compute logic
 process(rst, do_start, curr_state)
 begin
  case curr_state is
   when STATE_START =>
    status <= '0';
    if do_start = '1' then
     next_state <= STATE_WAIT;
    end if;
   when STATE_WAIT =>
    status <= '0';
    next_state <= STATE_STOP;
   when STATE_STOP => 
    status <= '1';
    next_state <= STATE_START;
  end case;
 end process;

 -- state update logic
 process(clk)
 begin
  if rst = '1' then
   curr_state <= STATE_START;
  elsif rising_edge(clk) then
   curr_state <= next_state;
  end if;
 end process;

end rtl;


-- main

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is end main;

architecture rtl of main is

 signal clk: std_logic := '0';
 signal rst: std_logic := '1';
 signal do_start: std_logic;
 signal status: std_logic;

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
 entity work.fsm
 port map
 (
  rst => rst,
  clk => clk,
  do_start => do_start,
  status => status
 );

 process
  variable done: natural := 0;
 begin

  do_start <= '0';

  if rst = '0' and done = 0 then

   do_start <= '1';
   wait until rising_edge(clk);
   do_start <= '0';

   done := 1;
  end if; -- done

 wait until rising_edge(clk);

 end process;

end rtl;

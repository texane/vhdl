#!/usr/bin/env sh
gcc -c rt_functions.c ;
ghdl -a rt_clk.vhdl main.vhdl ;
ghdl -e -Wl,rt_functions.o main ;

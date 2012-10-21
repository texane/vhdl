#!/usr/bin/env sh
gcc -c tick.c -o tick_c.o &&
ghdl -a tick.vhdl main.vhdl &&
ghdl -e -Wl,tick_c.o main

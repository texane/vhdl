#!/usr/bin/env sh
GHDL=ghdl
$GHDL -a ebs_core.vhdl
$GHDL -a fifo_s.vhdl
$GHDL -a main.vhdl
$GHDL -e main

#!/usr/bin/env sh

GHDLEX_DIR=../ghdlex_mein

ghdl -a $GHDLEX_DIR/txt_util.vhdl
ghdl -a $GHDLEX_DIR/libpipe.vhdl
ghdl -a main.vhdl
ghdl -e -Wl,-L$GHDLEX_DIR -Wl,-lmysim main

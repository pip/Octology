#!/bin/sh
ChunScrn='FujLyfBukT1010-TouchScrn-XEvntEmu-drvr-967AguA'
g++ -pthread -lX11 -lXtst -L/usr/X11R6/include $ChunScrn.cpp -o$ChunScrn.o

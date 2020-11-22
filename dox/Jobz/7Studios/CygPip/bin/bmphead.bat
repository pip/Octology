@echo off
:: this reads width, height, bit-depth out of .bmp headers
call readhead.bat x18V2x2v %1

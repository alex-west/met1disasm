@echo off

asm6f_32.exe .\main.asm ..\BIN\header.bin
asm6f_32.exe .\prg0_title.asm ..\BIN\bank0.bin
asm6f_32.exe .\prg1_brinstar.asm ..\BIN\bank1.bin
asm6f_32.exe .\prg2_norfair.asm ..\BIN\bank2.bin
asm6f_32.exe .\prg3_tourian.asm ..\BIN\bank3.bin
asm6f_32.exe .\prg4_kraid.asm ..\BIN\bank4.bin
asm6f_32.exe .\prg5_ridley.asm ..\BIN\bank5.bin
asm6f_32.exe .\prg6_graphics.asm ..\BIN\bank6.bin
asm6f_32.exe .\prg7_engine.asm ..\BIN\bank7.bin

copy /b ..\BIN\header.bin+..\BIN\bank* ..\test.nes

fc /b ..\test.nes ..\METROID.NES

:exit
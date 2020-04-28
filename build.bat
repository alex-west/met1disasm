@echo off
ophis .\SRC\main.asm -o.\BIN\header.bin
ophis .\SRC\prg0_title.asm -o.\BIN\bank0.bin
ophis .\SRC\prg1_brinstar.asm -o.\BIN\bank1.bin
ophis .\SRC\prg2_norfair.asm -o.\BIN\bank2.bin
ophis .\SRC\prg3_tourian.asm -o.\BIN\bank3.bin
ophis .\SRC\prg4_kraid.asm -o.\BIN\bank4.bin
ophis .\SRC\prg5_ridley.asm -o.\BIN\bank5.bin
ophis .\SRC\prg6_graphics.asm -o.\BIN\bank6.bin
ophis .\SRC\prg7_engine.asm -o.\BIN\bank7.bin

copy /b .\BIN\header.bin+.\BIN\bank* test.nes

fc /b test.nes METROID.NES
@echo off

if not exist OBJ mkdir OBJ

: wla-6502 .\SRC\main.asm .\OBJ\header.o
wla-6502 -o .\OBJ\bank0.o .\SRC\prg0_title.asm
wla-6502 -o .\OBJ\bank1.o .\SRC\prg1_brinstar.asm 
goto end
wla-6502 -o .\OBJ\bank2.o .\SRC\prg2_norfair.asm
wla-6502 -o .\OBJ\bank3.o .\SRC\prg3_tourian.asm
wla-6502 -o .\OBJ\bank4.o .\SRC\prg4_kraid.asm
wla-6502 -o .\OBJ\bank5.o .\SRC\prg5_ridley.asm
wla-6502 -o .\OBJ\bank6.o .\SRC\prg6_graphics.asm
wla-6502 -o .\OBJ\bank7.o .\SRC\prg7_engine.asm

copy /b ..\BIN\header.bin+..\BIN\bank* ..\test.nes

fc /b ..\test.nes ..\METROID.NES

:end
; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi 
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Title BG Tiles

L8BE0:  .byte $7F, $40, $40, $40, $40, $40, $40, $40, $00, $3F, $3F, $3F, $3F, $3F, $3F, $3F
L8BF0:  .byte $00, $00, $02, $03, $03, $03, $03, $03, $FF, $FF, $FD, $FC, $FD, $FD, $FD, $FD
L8C00:  .byte $03, $03, $02, $02, $02, $02, $02, $02, $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
L8C10:  .byte $FE, $02, $02, $02, $02, $02, $02, $02, $00, $FC, $FC, $FC, $FC, $FC, $FC, $FC
L8C20:  .byte $40, $40, $40, $40, $40, $40, $40, $40, $3F, $3F, $3F, $3F, $3F, $3F, $3F, $3F
L8C30:  .byte $20, $20, $20, $20, $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
L8C40:  .byte $04, $04, $04, $04, $04, $04, $04, $04, $03, $03, $03, $03, $03, $03, $03, $03
L8C50:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
L8C60:  .byte $00, $00, $66, $00, $00, $00, $00, $18, $7E, $7E, $7E, $18, $18, $18, $18, $18
L8C70:  .byte $00, $00, $40, $C0, $C0, $C0, $C0, $C0, $FF, $FF, $BF, $3F, $BF, $BF, $BF, $BF
L8C80:  .byte $C0, $C0, $C0, $40, $40, $40, $40, $40, $BF, $BF, $BF, $3F, $3F, $3F, $3F, $3F
L8C90:  .byte $18, $18, $00, $00, $00, $00, $00, $00, $E7, $E7, $FF, $FF, $FF, $FF, $FF, $FF
L8CA0:  .byte $40, $40, $40, $40, $40, $40, $40, $7F, $3F, $3F, $3F, $3F, $3F, $3F, $3F, $00
L8CB0:  .byte $20, $20, $20, $20, $20, $20, $20, $E0, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $00
L8CC0:  .byte $04, $04, $04, $04, $04, $04, $04, $07, $03, $03, $03, $03, $03, $03, $03, $00
L8CD0:  .byte $02, $02, $02, $02, $02, $02, $02, $FE, $FC, $FC, $FC, $FC, $FC, $FC, $FC, $00
L8CE0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8CF0:  .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
L8D00:  .byte $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE
L8D10:  .byte $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
L8D20:  .byte $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
L8D30:  .byte $00, $00, $00, $14, $08, $00, $00, $63, $63, $77, $7F, $7F, $6B, $63, $63, $63
L8D40:  .byte $00, $81, $42, $24, $18, $00, $00, $00, $00, $00, $81, $C3, $E7, $FF, $FF, $FF
L8D50:  .byte $00, $00, $3F, $3F, $3F, $3F, $3F, $3F, $FF, $FF, $C0, $DF, $DF, $DF, $DF, $DF
L8D60:  .byte $02, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FC, $FC, $00, $FE, $FE, $FE, $FE, $FE
L8D70:  .byte $3F, $3F, $20, $3F, $00, $00, $00, $00, $DF, $DF, $C0, $C0, $FF, $FF, $FF, $FF
L8D80:  .byte $FE, $FE, $00, $FE, $02, $02, $02, $02, $FE, $FE, $00, $00, $FC, $FC, $FC, $FC
L8D90:  .byte $00, $00, $00, $00, $00, $3F, $3F, $3F, $FF, $FF, $FF, $FF, $FF, $C0, $DF, $DF
L8DA0:  .byte $02, $02, $02, $02, $02, $FE, $FE, $FE, $FC, $FC, $FC, $FC, $FC, $00, $FE, $FE
L8DB0:  .byte $FF, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8DC0:  .byte $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00
L8DD0:  .byte $3F, $3F, $3F, $3F, $20, $3F, $00, $00, $DF, $DF, $DF, $DF, $C0, $C0, $FF, $FF
L8DE0:  .byte $FE, $FE, $FE, $FE, $00, $FE, $02, $02, $FE, $FE, $FE, $FE, $00, $00, $FC, $FC
L8DF0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8E00:  .byte $00, $03, $0C, $10, $20, $20, $40, $40, $00, $00, $03, $0F, $1F, $1F, $3F, $3F
L8E10:  .byte $00, $C0, $30, $08, $04, $04, $02, $02, $00, $00, $C0, $F0, $F8, $F8, $FC, $FC
L8E20:  .byte $02, $02, $06, $06, $0E, $3E, $FE, $FE, $FC, $FC, $FA, $FA, $F6, $CE, $3E, $FE
L8E30:  .byte $FE, $FE, $FC, $FC, $F8, $F0, $C0, $00, $FE, $FE, $FC, $FC, $F8, $F0, $C0, $00
L8E40:  .byte $40, $40, $60, $60, $70, $7C, $7F, $7F, $3F, $3F, $5F, $5F, $6F, $73, $7C, $7F
L8E50:  .byte $7F, $7F, $3F, $3F, $1F, $0F, $03, $00, $7F, $7F, $3F, $3F, $1F, $0F, $03, $00
L8E60:  .byte $00, $00, $3F, $3F, $3F, $3F, $3F, $3F, $FF, $FF, $C0, $DF, $DF, $DF, $DF, $DF
L8E70:  .byte $00, $00, $FC, $FC, $FC, $FC, $FC, $FC, $FF, $FF, $03, $FB, $FB, $FB, $FB, $FB
L8E80:  .byte $20, $20, $20, $20, $20, $3F, $00, $00, $C0, $C0, $C0, $C0, $C0, $C0, $FF, $FF
L8E90:  .byte $04, $04, $04, $04, $04, $FC, $00, $00, $03, $03, $03, $03, $03, $03, $FF, $FF
L8EA0:  .byte $3F, $3F, $20, $3F, $00, $00, $00, $00, $DF, $DF, $C0, $C0, $FF, $FF, $FF, $FF
L8EB0:  .byte $FC, $FC, $04, $FC, $00, $00, $00, $00, $FB, $FB, $03, $03, $FF, $FF, $FF, $FF
L8EC0:  .byte $00, $00, $00, $00, $00, $3F, $3F, $3F, $FF, $FF, $FF, $FF, $FF, $C0, $DF, $DF
L8ED0:  .byte $00, $00, $00, $00, $00, $FC, $FC, $FC, $FF, $FF, $FF, $FF, $FF, $03, $FB, $FB
L8EE0:  .byte $02, $02, $02, $02, $04, $04, $08, $10, $FC, $FC, $FC, $FC, $F8, $F8, $F0, $E0
L8EF0:  .byte $10, $08, $04, $04, $02, $02, $02, $02, $E0, $F0, $F8, $F8, $FC, $FC, $FC, $FC
L8F00:  .byte $FC, $FC, $04, $04, $04, $04, $04, $04, $FB, $FB, $03, $03, $03, $03, $03, $03
L8F10:  .byte $3F, $3F, $20, $20, $20, $20, $20, $20, $DF, $DF, $C0, $C0, $C0, $C0, $C0, $C0
L8F20:  .byte $40, $40, $7F, $7F, $7F, $7F, $7F, $7F, $3F, $3F, $00, $7F, $7F, $7F, $7F, $7F
L8F30:  .byte $00, $00, $C0, $C0, $C0, $C0, $C0, $C0, $FF, $FF, $3F, $BF, $BF, $BF, $BF, $BF
L8F40:  .byte $00, $00, $03, $03, $03, $03, $03, $03, $FF, $FF, $FC, $FD, $FD, $FD, $FD, $FD
L8F50:  .byte $02, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FC, $FC, $00, $FE, $FE, $FE, $FE, $FE
L8F60:  .byte $7F, $7F, $00, $00, $00, $00, $00, $00, $7F, $7F, $00, $00, $00, $00, $00, $00
L8F70:  .byte $C0, $C0, $40, $40, $40, $40, $40, $40, $BF, $BF, $3F, $3F, $3F, $3F, $3F, $3F
L8F80:  .byte $03, $03, $02, $02, $02, $02, $02, $02, $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
L8F90:  .byte $FE, $FE, $00, $00, $00, $00, $00, $00, $FE, $FE, $00, $00, $00, $00, $00, $00
L8FA0:  .byte $FC, $FC, $FC, $FC, $04, $04, $04, $04, $FB, $FB, $FB, $FB, $03, $03, $03, $03
L8FB0:  .byte $3F, $3F, $3F, $3F, $20, $20, $20, $20, $DF, $DF, $DF, $DF, $C0, $C0, $C0, $C0
L8FC0:  .byte $00, $00, $00, $00, $81, $C3, $E7, $FF, $FF, $FF, $FF, $FF, $7E, $BD, $DB, $E7
L8FD0:  .byte $FF, $FF, $FF, $7E, $3C, $18, $00, $00, $FF, $FF, $FF, $7E, $3C, $18, $00, $00
L8FE0:  .byte $32, $FF, $F7, $FF, $7F, $FF, $DB, $FF, $73, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8FF0:  .byte $B4, $FF, $FF, $FF, $FE, $7B, $FF, $FD, $B6, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9000:  .byte $B5, $FF, $7F, $9D, $F6, $7F, $DD, $77, $FF, $FF, $FF, $FF, $EF, $FF, $BB, $FE
L9010:  .byte $D7, $FF, $79, $DE, $F5, $3F, $ED, $BF, $FF, $FF, $FF, $FF, $BF, $FF, $FB, $FF
L9020:  .byte $89, $F7, $5F, $F3, $E7, $FD, $70, $CF, $FF, $BF, $EC, $FF, $9F, $FE, $AF, $F9
L9030:  .byte $9F, $F9, $3D, $F7, $3F, $99, $FD, $CF, $F6, $7F, $FF, $FD, $CF, $FF, $FF, $FB
L9040:  .byte $B9, $59, $CC, $7F, $DF, $9F, $BF, $1E, $7F, $FF, $B7, $F3, $FD, $6F, $FF, $E7
L9050:  .byte $7F, $F9, $F3, $FF, $FF, $FF, $FF, $BB, $9F, $FF, $CF, $9F, $FD, $FF, $27, $DF
L9060:  .byte $63, $EF, $EE, $1F, $B9, $1C, $F7, $FF, $9D, $38, $FF, $FF, $C7, $E3, $FF, $BF
L9070:  .byte $FF, $9D, $7E, $FF, $B3, $C7, $FF, $A1, $3C, $7E, $FF, $E7, $CF, $FF, $FB, $7F
L9080:  .byte $C8, $ED, $BE, $DC, $9E, $F8, $36, $CC, $3F, $1E, $7F, $FF, $EF, $07, $CF, $FF
L9090:  .byte $C7, $BF, $3A, $7F, $BD, $A3, $7F, $FC, $3C, $7C, $FD, $E7, $CF, $FE, $8C, $0F
L90A0:  .byte $00, $00, $18, $18, $3C, $7E, $5E, $FF, $10, $10, $18, $38, $7C, $7E, $FE, $FF
L90B0:  .byte $00, $10, $10, $10, $10, $30, $30, $10, $10, $10, $10, $10, $30, $30, $30, $30
L90C0:  .byte $20, $30, $30, $20, $60, $30, $70, $F8, $20, $30, $30, $60, $60, $70, $F0, $F8
L90D0:  .byte $3C, $42, $99, $A1, $A1, $99, $42, $3C, $00, $00, $00, $00, $00, $00, $00, $00

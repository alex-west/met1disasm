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
;Disassembled using TRaCER.

;Ridley hideout (memory page 5)

.org $8000

.include "./MetroidDefines.txt"

BANK = 5

;--------------------------------------[ Forward declarations ]--------------------------------------

Startup                = $C01A
NMI                    = $C0D9
ChooseRoutine          = $C27C
Adiv32                 = $C2BE
Adiv16                 = $C2BF
Amul16                 = $C2C5
TwosCompliment         = $C3D4
Base10Subtract         = $C3FB
SubtractHealth         = $CE92
SetProjectileAnim      = $D2FA
UpdateEnemyAnim        = $E094
VerticalRoomCentered   = $E21B

;-----------------------------------------[ Start of code ]------------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Misc. tile patterns. (CRE?)
L8D60:  .byte $73, $FD, $3B, $A0, $C0, $E0, $60, $80, $00, $00, $00, $1F, $10, $17, $14, $14
L8D70:  .byte $E8, $9C, $7C, $1C, $44, $58, $5C, $5C, $00, $04, $0C, $FC, $24, $B8, $BC, $BC
L8D80:  .byte $E0, $E7, $A0, $2F, $73, $7C, $00, $00, $17, $10, $1F, $0F, $33, $7C, $00, $00
L8D90:  .byte $58, $D4, $14, $DC, $EC, $D8, $00, $00, $B8, $34, $F4, $DC, $EC, $D8, $00, $00
L8DA0:  .byte $41, $41, $77, $14, $14, $14, $14, $14, $1D, $01, $7F, $0C, $0C, $0C, $0C, $0C
L8DB0:  .byte $14, $14, $14, $14, $14, $7F, $41, $41, $0C, $0C, $0C, $0C, $0C, $01, $01, $1D
L8DC0:  .byte $7F, $7F, $7F, $3E, $3E, $3E, $3C, $1C, $03, $03, $07, $06, $06, $06, $04, $04
L8DD0:  .byte $7E, $7E, $7E, $7C, $7C, $3C, $38, $38, $06, $06, $0E, $0C, $0C, $0C, $08, $08
L8DE0:  .byte $1C, $1C, $1C, $08, $08, $08, $08, $08, $04, $04, $04, $00, $00, $00, $00, $00
L8DF0:  .byte $38, $10, $10, $10, $00, $00, $00, $00, $08, $00, $00, $00, $00, $00, $00, $00
L8E00:  .byte $7E, $7E, $7E, $3E, $3E, $3C, $1C, $1C, $60, $60, $70, $30, $30, $30, $10, $10
L8E10:  .byte $FE, $FE, $FE, $7C, $7C, $7C, $3C, $38, $C0, $C0, $E0, $60, $60, $60, $20, $20
L8E20:  .byte $1C, $08, $08, $08, $00, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00
L8E30:  .byte $38, $38, $38, $10, $10, $10, $10, $10, $20, $20, $20, $00, $00, $00, $00, $00
L8E40:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E50:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E60:  .byte $00, $01, $03, $00, $0F, $03, $1F, $21, $00, $01, $01, $00, $01, $03, $07, $01
L8E70:  .byte $7F, $FF, $F0, $D7, $8F, $DC, $98, $F8, $7F, $9F, $70, $D0, $83, $C4, $88, $E8
L8E80:  .byte $80, $F0, $78, $BC, $FC, $7E, $6E, $4C, $80, $F0, $78, $3C, $BC, $7E, $6E, $4C
L8E90:  .byte $3C, $3C, $3A, $7B, $77, $6F, $69, $3C, $3C, $2C, $2A, $5B, $51, $47, $61, $1C
L8EA0:  .byte $D1, $89, $07, $C6, $20, $1C, $87, $00, $C1, $81, $07, $C6, $00, $00, $80, $00
L8EB0:  .byte $F6, $02, $08, $1C, $1E, $1E, $07, $07, $F6, $22, $60, $C0, $98, $9C, $44, $26
L8EC0:  .byte $70, $70, $0C, $32, $20, $1C, $10, $06, $30, $30, $0C, $12, $20, $0C, $10, $02
L8ED0:  .byte $1C, $7E, $78, $F3, $F1, $E1, $C2, $73, $1C, $66, $58, $B3, $B1, $A1, $C2, $73
L8EE0:  .byte $03, $03, $03, $01, $B1, $18, $0C, $CC, $12, $12, $22, $00, $90, $08, $04, $44
L8EF0:  .byte $00, $07, $00, $03, $00, $01, $03, $0F, $00, $03, $00, $01, $00, $00, $01, $03
L8F00:  .byte $01, $48, $46, $30, $1E, $C0, $81, $67, $01, $48, $46, $30, $1E, $C0, $80, $61
L8F10:  .byte $E6, $F0, $31, $0B, $83, $00, $EF, $C9, $A2, $C0, $30, $08, $81, $00, $20, $C1
L8F20:  .byte $02, $03, $77, $89, $BE, $2C, $00, $80, $00, $01, $77, $81, $8E, $0C, $00, $00
L8F30:  .byte $0F, $02, $1F, $02, $0F, $1B, $11, $F0, $07, $02, $0F, $02, $07, $0B, $11, $D0
L8F40:  .byte $1F, $3C, $70, $61, $07, $5E, $19, $7E, $07, $1C, $30, $20, $01, $46, $19, $7E
L8F50:  .byte $26, $7E, $58, $D2, $23, $C1, $00, $00, $20, $22, $10, $52, $23, $C1, $00, $00
L8F60:  .byte $00, $40, $70, $18, $C8, $ED, $F7, $3D, $00, $00, $40, $10, $00, $C9, $E1, $3D
L8F70:  .byte $18, $70, $F0, $80, $00, $00, $00, $00, $10, $10, $F0, $80, $00, $00, $00, $00
L8F80:  .byte $00, $00, $00, $70, $FC, $DE, $02, $E2, $00, $00, $00, $00, $70, $1E, $02, $C0
L8F90:  .byte $45, $D7, $FF, $FF, $FD, $FF, $BF, $FB, $00, $00, $00, $00, $02, $00, $40, $04
L8FA0:  .byte $FF, $BB, $FF, $FF, $EF, $FF, $7F, $FD, $00, $44, $00, $00, $10, $00, $80, $02
L8FB0:  .byte $12, $12, $12, $12, $12, $12, $12, $12, $1D, $1D, $1D, $1D, $1D, $1D, $1D, $1D
L8FC0:  .byte $58, $58, $58, $58, $58, $58, $58, $58, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
L8FD0:  .byte $00, $00, $7F, $80, $80, $FF, $7F, $00, $00, $7F, $80, $7F, $FF, $FF, $7F, $00
L8FE0:  .byte $00, $00, $FC, $01, $03, $FF, $FE, $00, $00, $FE, $03, $FF, $FF, $FF, $FE, $00
L8FF0:  .byte $00, $00, $00, $00, $00, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF
L9000:  .byte $FF, $00, $FF, $FF, $FF, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
L9010:  .byte $00, $00, $10, $00, $09, $10, $0A, $25, $00, $00, $10, $00, $09, $10, $0A, $25
L9020:  .byte $00, $00, $00, $90, $68, $90, $F4, $BA, $00, $00, $00, $90, $68, $90, $74, $AA
L9030:  .byte $0A, $07, $2B, $15, $02, $21, $04, $00, $0A, $07, $2B, $15, $02, $21, $04, $00
L9040:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9050:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9060:  .byte $FC, $B4, $6A, $C8, $22, $28, $00, $00, $FC, $B4, $6A, $C8, $22, $28, $00, $00
L9070:  .byte $22, $76, $FF, $FF, $FF, $7F, $FF, $7E, $00, $76, $F7, $7F, $DB, $7F, $FF, $5E
L9080:  .byte $90, $60, $E0, $D0, $F0, $AC, $D0, $F8, $90, $40, $E0, $D0, $F0, $AC, $D0, $F8
L9090:  .byte $FF, $EE, $BD, $7B, $3E, $50, $00, $00, $FF, $EE, $BD, $7B, $3E, $50, $00, $00
L90A0:  .byte $E4, $40, $A8, $40, $40, $00, $00, $00, $E4, $40, $A8, $40, $40, $00, $00, $00
L90B0:  .byte $3F, $C0, $80, $80, $00, $00, $FF, $80, $00, $3F, $7F, $7F, $00, $00, $00, $7F
L90C0:  .byte $FC, $00, $00, $00, $00, $1C, $90, $20, $00, $FC, $FC, $FC, $00, $00, $0C, $9C
L90D0:  .byte $80, $80, $00, $F0, $80, $80, $00, $00, $7F, $7F, $00, $00, $7F, $7F, $00, $00
L90E0:  .byte $20, $20, $00, $3C, $40, $40, $00, $00, $9C, $1C, $00, $00, $BC, $BC, $00, $00
L90F0:  .byte $10, $10, $10, $00, $08, $08, $08, $08, $6F, $6F, $6F, $00, $17, $17, $17, $17
L9100:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF
L9110:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $E6, $E6, $E6, $00, $C8, $C8, $C8, $C8
L9120:  .byte $7E, $FF, $C0, $C0, $C0, $CF, $C0, $4F, $00, $00, $3F, $2F, $3F, $30, $38, $30
L9130:  .byte $7E, $FF, $03, $03, $03, $F3, $03, $F2, $00, $01, $FF, $F7, $FF, $FF, $0F, $FE
L9140:  .byte $40, $CF, $C0, $C0, $C0, $C0, $FF, $7E, $38, $30, $38, $3F, $2F, $3F, $7F, $7E
L9150:  .byte $02, $F3, $03, $03, $03, $03, $FF, $7E, $0E, $FF, $0F, $FF, $F7, $FF, $FF, $7E
L9160:  .byte $73, $F9, $FF, $7F, $3F, $BF, $FF, $FF, $00, $79, $40, $5F, $10, $17, $54, $55
L9170:  .byte $CC, $DC, $FC, $F4, $F0, $D4, $D4, $54, $00, $DC, $04, $F4, $10, $D4, $54, $54
L9180:  .byte $FC, $FF, $B0, $7F, $C0, $F7, $00, $00, $54, $57, $10, $5F, $40, $77, $00, $00
L9190:  .byte $50, $D4, $14, $F4, $04, $CC, $00, $00, $50, $94, $14, $E4, $04, $C8, $00, $00
L91A0:  .byte $FE, $82, $92, $AA, $92, $82, $FE, $00, $00, $7E, $46, $5E, $56, $7E, $FE, $00

;Game over, Japaneese font tile patterns.
L91B0:  .byte $C0, $04, $C4, $04, $04, $0C, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91C0:  .byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91D0:  .byte $40, $7E, $48, $88, $08, $18, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91E0:  .byte $E0, $02, $02, $02, $06, $0C, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91F0:  .byte $18, $0C, $86, $82, $82, $82, $82, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9200:  .byte $7E, $42, $C2, $02, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9210:  .byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9220:  .byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9230:  .byte $40, $40, $40, $78, $44, $40, $40, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9240:  .byte $10, $FE, $82, $82, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9250:  .byte $0C, $78, $08, $FE, $08, $18, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9260:  .byte $7C, $00, $00, $00, $00, $00, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9270:  .byte $00, $00, $50, $54, $04, $0C, $38, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9280:  .byte $00, $00, $00, $38, $08, $08, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9290:  .byte $A2, $A2, $A2, $02, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92A0:  .byte $40, $FE, $42, $46, $44, $60, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92B0:  .byte $7E, $02, $02, $7E, $02, $02, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92C0:  .byte $00, $00, $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92D0:  .byte $3E, $60, $C0, $CE, $C6, $66, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92E0:  .byte $38, $6C, $C6, $C6, $FE, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92F0:  .byte $C6, $EE, $FE, $FE, $D6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9300:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9310:  .byte $7C, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9320:  .byte $C6, $C6, $C6, $EE, $7C, $38, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9330:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9340:  .byte $7E, $18, $18, $18, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9350:  .byte $7E, $18, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9360:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9370:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9380:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9390:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93B0:  .byte $45, $D7, $FF, $BB, $FF, $EF, $7F, $DD, $00, $00, $00, $44, $02, $50, $88, $22
L93C0:  .byte $FF, $77, $DD, $F7, $BE, $EF, $BB, $6E, $24, $88, $22, $48, $45, $10, $46, $B1
L93D0:  .byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93E0:  .byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93F0:  .byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9400:  .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9410:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9420:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9430:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9440:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9450:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9460:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9470:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9480:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9490:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Unused tile patterns.
L94B0:  .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C0:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D0:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9500:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9510:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A0EB)
L9562:  .word Palette01                 ;($A10F)
L9564:  .word Palette02                 ;($A11B)
L9566:  .word Palette03                 ;($A115)
L9568:  .word Palette04                 ;($A121)
L956A:  .word Palette05                 ;($A127)
L956C:  .word Palette06                 ;($A13B)
L956E:  .word Palette06                 ;($A13B)
L9570:  .word Palette06                 ;($A13B)
L9572:  .word Palette06                 ;($A13B)
L9574:  .word Palette06                 ;($A13B)
L9576:  .word Palette06                 ;($A13B)
L9578:  .word Palette06                 ;($A13B)
L957A:  .word Palette06                 ;($A13B)
L957C:  .word Palette06                 ;($A13B)
L957E:  .word Palette06                 ;($A13B)
L9580:  .word Palette06                 ;($A13B)
L9582:  .word Palette06                 ;($A13B)
L9584:  .word Palette06                 ;($A13B)
L9586:  .word Palette06                 ;($A13B)
L9588:  .word Palette07                 ;($A142)
L958A:  .word Palette08                 ;($A149)
L958C:  .word Palette09                 ;($A150)
L958E:  .word Palette0A                 ;($A157)
L9590:  .word Palette0B                 ;($A15F)
L9592:  .word Palette0C                 ;($A167)
L9594:  .word Palette0D                 ;($A16F)
L9596:  .word Palette0E                 ;($A177)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A20D)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A17F)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A1D3)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AB23)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9BF0)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9CF0)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9D04)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9B85)Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:  JMP $9B48                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $12                       ;Ridley's room.

L95CD:  .byte $80                       ;Ridley hideout music init flag.

L95CE:  .byte $40                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $19                       ;Samus start x coord on world map.
L95D8:  .byte $18                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $58, $44, $4A, $48, $4A, $4A, $36, $25

L95E5:  LDA $6B02,X
L95E8:  JSR $8024

L95EB:  .word $98D7 ; 00 - swooper
L95ED:  .word $990C ; 01 - becomes swooper ?
L95EF:  .word $9847 ; 02 - dessgeegas
L95F1:  .word $9862 ; 03 - ceiling dessgeegas
L95F3:  .word InvalidEnemy ; 04 - disappears
L95F5:  .word InvalidEnemy ; 05 - same as 4
L95F7:  .word $9967 ; 06 - crawler
L95F9:  .word ZebboRoutine ; 07 - pipe bugs
L95FB:  .word InvalidEnemy ; 08 - same as 4
L95FD:  .word $9A13 ; 09 - ridley
L95FF:  .word $9A4A ; 0A - ridley fireball
L9601:  .word InvalidEnemy ; 0B - same as 4
L9603:  .word $9B03 ; 0C - bouncy orbs
L9605:  .word InvalidEnemy ; 0D - same as 4
L9607:  .word $9B16 ; 0E - ???
L9609:  .word InvalidEnemy ; 0F - same as 4

L960B:  .byte $23, $23, $23, $23, $3A, $3A, $3C, $3C, $00, $00, $00, $00, $56, $56, $65, $63

L961B:  .byte $00, $00, $11, $11, $13, $18, $28, $28, $32, $32, $34, $34, $00, $00, $00, $00

L962B:  .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $1D, $1D, $1D, $1D, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $69, $67

L964B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L965B:  .byte $20, $20, $20, $20, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $60, $5D

L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

L96BB:  .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $18, $1A, $00, $03, $00, $00, $08, $08, $00, $0A, $0C, $0F, $14, $16, $18, $00

EnemyMovementPtrs:
L96DB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97F0, $97F3, $97F3
L96EB:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L96FB:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L970B:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L971B:  .word $97F3, $97F3, $97F3, $97F3

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $7F, $7F, $81, $81
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01
L9773:  .byte $01, $00, $00, $00, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $34, $34, $44, $4A, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8

L97A7:  .word $97FD, $97FD, $980C, $981B, $9B49, $9B4E, $9B53, $9B58
L97B7:  .word $9B5D, $9B62, $9B67, $9B6C, $9B71, $9B76, $9B7B, $9B80
L97C7:  .word $9B85, $9B85, $9B85, $9B85, $9B85

L97D1:  .byte $01, $04, $05, $01, $06, $07, $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03
L97E1:  .byte $00, $01, $02, $03, $00, $10, $00, $11, $00, $00, $00, $01

L97ED:  .byte $01, $03, $FF

L97F0:  .byte $01, $0B, $FF

L97F3:  .byte $14, $90, $0A, $00, $FD, $30, $00, $14, $10, $FA

L97FD:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L980C:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L981B:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

;-------------------------------------------------------------------------------
InvalidEnemy:
L982A:  LDA #$00
L982C:  STA $6AF4,X
L982F:  RTS

L9830:  LDA $81
L9832:  CMP #$01
L9834:  BEQ $983F
L9836:  CMP #$03
L9838:  BEQ $9844
L983A:  LDA $00
L983C:  JMP $8000
L983F:  LDA $01
L9841:  JMP $8003
L9844:  JMP $8006

;-------------------------------------------------------------------------------
; Sidehopper (dessgeega) Routine
L9847:  LDA #$42
L9849:  STA $85
L984B:  STA $86
L984D:  LDA $6AF4,X
L9850:  CMP #$03
L9852:  BEQ $9857
L9854:  JSR $801B
L9857:  LDA #$06
L9859:  STA $00
L985B:  LDA #$08
L985D:  STA $01
L985F:  JMP $9830

;-------------------------------------------------------------------------------
; Ceiling Dessgeega
L9862:  LDA #$48
L9864:  JMP $9849

;-------------------------------------------------------------------------------
ZebboRoutine: ; L9867
.include enemies/pipe_bug.asm

;-------------------------------------------------------------------------------
; Swooper Routine
L98D7:  LDA #$03
L98D9:  STA $00
L98DB:  LDA #$08
L98DD:  STA $01
L98DF:  LDA $6AF4,X
L98E2:  CMP #$01
L98E4:  BNE $98F2
L98E6:  LDA $0405,X
L98E9:  AND #$10
L98EB:  BEQ $98F2
L98ED:  LDA #$01
L98EF:  JSR $9958
L98F2:  JSR $98F8
L98F5:  JMP $9830
L98F8:  LDA $6AF4,X
L98FB:  CMP #$02
L98FD:  BNE $990B
L98FF:  LDA #$20
L9901:  LDY $0402,X
L9904:  BPL $9908
L9906:  LDA #$1D
L9908:  STA $6AF9,X
L990B:  RTS

;-------------------------------------------------------------------------------
; Swooper 2 Routine
L990C:  LDA $81
L990E:  CMP #$01
L9910:  BEQ $9922
L9912:  CMP #$03
L9914:  BEQ $9955
L9916:  LDA $6AF4,X
L9919:  CMP #$01
L991B:  BNE $9927
L991D:  LDA #$00
L991F:  JSR $9958
L9922:  LDA #$08
L9924:  JMP $8003
L9927:  LDA #$80
L9929:  STA $6AFE,X
L992C:  LDA $0402,X
L992F:  BMI $994D
L9931:  LDA $0405,X
L9934:  AND #$10
L9936:  BEQ $994D
L9938:  LDA $0400,X
L993B:  SEC 
L993C:  SBC $030D
L993F:  BPL $9944
L9941:  JSR $95C6
L9944:  CMP #$10
L9946:  BCS $994D
L9948:  LDA #$00
L994A:  STA $6AFE,X
L994D:  JSR $98F8
L9950:  LDA #$03
L9952:  JMP $8000
L9955:  JMP $8006
L9958:  STA $6B02,X
L995B:  LDA $040B,X
L995E:  PHA 
L995F:  JSR $802A
L9962:  PLA 
L9963:  STA $040B,X
L9966:  RTS

;-------------------------------------------------------------------------------
; Crawler Routine
L9967:  JSR $8009
L996A:  AND #$03
L996C:  BEQ $99A2
L996E:  LDA $81
L9970:  CMP #$01
L9972:  BEQ $99AA
L9974:  CMP #$03
L9976:  BEQ $99A7
L9978:  LDA $6AF4,X
L997B:  CMP #$03
L997D:  BEQ $99A2
L997F:  LDA $040A,X
L9982:  AND #$03
L9984:  CMP #$01
L9986:  BNE $9999
L9988:  LDY $0400,X
L998B:  CPY #$EB
L998D:  BNE $9999
L998F:  JSR $99DB
L9992:  LDA #$03
L9994:  STA $040A,X
L9997:  BNE $999F
L9999:  JSR $9A00
L999C:  JSR $99C6
L999F:  JSR $99E4
L99A2:  LDA #$03
L99A4:  JSR $800C
L99A7:  JMP $8006
L99AA:  JMP $8003
L99AD:  LDA $0405,X
L99B0:  LSR 
L99B1:  LDA $040A,X
L99B4:  AND #$03
L99B6:  ROL 
L99B7:  TAY 
L99B8:  LDA $99BE,Y
L99BB:  JMP $800F

L99BE:  .byte $4A, $4A, $53, $4D, $50, $50, $4D, $53

L99C6:  LDX $4B
L99C8:  BCS $99E3
L99CA:  LDA $00
L99CC:  BNE $99DB
L99CE:  LDY $040A,X
L99D1:  DEY 
L99D2:  TYA 
L99D3:  AND #$03
L99D5:  STA $040A,X
L99D8:  JMP $99AD
L99DB:  LDA $0405,X
L99DE:  EOR #$01
L99E0:  STA $0405,X
L99E3:  RTS

L99E4:  JSR $99F8
L99E7:  JSR $9A00
L99EA:  LDX $4B
L99EC:  BCC $99F7
L99EE:  JSR $99F8
L99F1:  STA $040A,X
L99F4:  JSR $99AD
L99F7:  RTS

L99F8:  LDY $040A,X
L99FB:  INY 
L99FC:  TYA 
L99FD:  AND #$03
L99FF:  RTS

L9A00:  LDY $0405,X
L9A03:  STY $00
L9A05:  LSR $00
L9A07:  ROL 
L9A08:  ASL 
L9A09:  TAY 
L9A0A:  LDA $8049,Y
L9A0D:  PHA 
L9A0E:  LDA $8048,Y
L9A11:  PHA 
L9A12:  RTS

;-------------------------------------------------------------------------------
; Ridley Routine
L9A13:  LDA $6AF4,X
L9A16:  CMP #$03
L9A18:  BCC $9A33
L9A1A:  BEQ $9A20
L9A1C:  CMP #$05
L9A1E:  BNE $9A41

L9A20:  LDA #$00
L9A22:  STA $6B04
L9A25:  STA $6B14
L9A28:  STA $6B24
L9A2B:  STA $6B34
L9A2E:  STA $6B44
L9A31:  BEQ $9A41

L9A33:  LDA #$0B
L9A35:  STA $85
L9A37:  LDA #$0E
L9A39:  STA $86
L9A3B:  JSR $801B
L9A3E:  JSR $9A79

L9A41:  LDA #$03
L9A43:  STA $00
L9A45:  STA $01
L9A47:  JMP $9830

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
L9A4A:  LDA $0405,X
L9A4D:  PHA 
L9A4E:  LDA #$02
L9A50:  STA $00
L9A52:  STA $01
L9A54:  JSR $9830
L9A57:  PLA 
L9A58:  LDX $4B
L9A5A:  EOR $0405,X
L9A5D:  LSR 
L9A5E:  BCS $9A73
L9A60:  LDA $0405,X
L9A63:  LSR 
L9A64:  BCS $9A78
L9A66:  LDA $0401,X
L9A69:  SEC 
L9A6A:  SBC $030E
L9A6D:  BCC $9A78
L9A6F:  CMP #$20
L9A71:  BCC $9A78
L9A73:  LDA #$00
L9A75:  STA $6AF4,X
L9A78:  RTS

;-------------------------------------------------------------------------------
; Ridley Subroutine
L9A79:  LDY $80
L9A7B:  BNE $9A7F
L9A7D:  LDY #$60
L9A7F:  LDA $2D
L9A81:  AND #$02
L9A83:  BNE $9AA9
L9A85:  DEY 
L9A86:  STY $80
L9A88:  TYA 
L9A89:  ASL 
L9A8A:  BMI $9AA9
L9A8C:  AND #$0F
L9A8E:  CMP #$0A
L9A90:  BNE $9AA9
L9A92:  LDX #$50
L9A94:  LDA $6AF4,X
L9A97:  BEQ $9AAA
L9A99:  LDA $0405,X
L9A9C:  AND #$02
L9A9E:  BEQ $9AAA
L9AA0:  TXA 
L9AA1:  SEC 
L9AA2:  SBC #$10
L9AA4:  TAX 
L9AA5:  BNE $9A94
L9AA7:  INC $7E
L9AA9:  RTS

L9AAA:  TXA 
L9AAB:  TAY 
L9AAC:  LDX #$00
L9AAE:  JSR StorePositionToTemp
L9AB1:  TYA 
L9AB2:  TAX 
L9AB3:  LDA $0405
L9AB6:  STA $0405,X
L9AB9:  AND #$01
L9ABB:  TAY 
L9ABC:  LDA $9ADF,Y
L9ABF:  STA $05
L9AC1:  LDA #$F8
L9AC3:  STA $04
L9AC5:  JSR $8027
L9AC8:  BCC $9AA9
L9ACA:  LDA #$00
L9ACC:  STA $040F,X
L9ACF:  LDA #$0A
L9AD1:  STA $6B02,X
L9AD4:  LDA #$01
L9AD6:  STA $6AF4,X
L9AD9:  JSR LoadPositionFromTemp
L9ADC:  JMP $802A
L9ADF:  PHP 
L9AE0:  SED 

StorePositionToTemp:
L9AE1:  LDA EnYRoomPos,X
L9AE4:  STA $08
L9AE6:  LDA EnXRoomPos,X
L9AE9:  STA $09
L9AEB:  LDA EnNameTable,X
L9AEE:  STA $0B
L9AF0:  RTS

LoadPositionFromTemp:
L9AF1:  LDA $0B
L9AF3:  AND #$01
L9AF5:  STA EnNameTable,X
L9AF8:  LDA $08
L9AFA:  STA EnYRoomPos,X
L9AFD:  LDA $09
L9AFF:  STA EnXRoomPos,X
L9B02:  RTS

;-------------------------------------------------------------------------------
; Bouncy Orb Routine
L9B03:  LDA $6AF4,X
L9B06:  CMP #$02
L9B08:  BNE $9B0D
L9B0A:  JSR $801E
L9B0D:  LDA #$02
L9B0F:  STA $00
L9B11:  STA $01
L9B13:  JMP $9830

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
L9B16:  LDA #$00
L9B18:  STA $6AF5,X
L9B1B:  STA $6AF6,X
L9B1E:  LDA #$10
L9B20:  STA $0405,X
L9B23:  TXA 
L9B24:  LSR 
L9B25:  LSR 
L9B26:  LSR 
L9B27:  LSR 
L9B28:  ADC $2D
L9B2A:  AND #$07
L9B2C:  BNE $9B48
L9B2E:  LSR $0405,X
L9B31:  LDA #$03
L9B33:  STA $87
L9B35:  LDA $2E
L9B37:  LSR 
L9B38:  ROL $0405,X
L9B3B:  AND #$03
L9B3D:  BEQ $9B48
L9B3F:  STA $88
L9B41:  LDA #$02
L9B43:  STA $85
L9B45:  JMP $8021
L9B48:  RTS

L9B49:  .byte $22, $FF, $FF, $FF, $FF

L9B4E:  .byte $22, $80, $81, $82, $83

L9B53:  .byte $22, $84, $85, $86, $87

L9B58:  .byte $22, $88, $89, $8A, $8B

L9B5D:  .byte $22, $8C, $8D, $8E, $8F

L9B62:  .byte $22, $94, $95, $96, $97

L9B67:  .byte $22, $9C, $9D, $9D, $9C

L9B6C:  .byte $22, $9E, $9F, $9F, $9E

L9B71:  .byte $22, $90, $91, $92, $93

L9B76:  .byte $22, $70, $71, $72, $73

L9B7B:  .byte $22, $74, $75, $76, $77

L9B80:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9B85:  .byte $00, $01, $FF

L9B88:  .byte $02, $FF

L9B8A:  .byte $03, $04, $FF

L9B8D:  .byte $07, $08, $FF

L9B90:  .byte $05, $06, $FF

L9B93:  .byte $09, $0A, $FF

L9B96:  .byte $0B, $FF

L9B98:  .byte $0C, $0D, $0E, $0F, $FF

L9B9D:  .byte $10, $11, $12, $13, $FF

L9BA2:  .byte $17, $18, $FF

L9BA5:  .byte $19, $1A, $FF

L9BA8:  .byte $1B, $FF

L9BAA:  .byte $21, $22, $FF

L9BAD:  .byte $27, $28, $29, $2A, $FF

L9BB2:  .byte $2B, $2C, $2D, $2E, $FF

L9BB7:  .byte $2F, $FF

L9BB9:  .byte $42, $FF

L9BBB:  .byte $43, $44, $F7, $FF

L9BBF:  .byte $37, $FF, $38, $FF

L9BC3:  .byte $30, $31, $FF

L9BC6:  .byte $31, $32, $FF

L9BC9:  .byte $33, $34, $FF

L9BCC:  .byte $34, $35, $FF

L9BCF:  .byte $58, $59, $FF

L9BD2:  .byte $5A, $5B, $FF

L9BD5:  .byte $5C, $5D, $FF

L9BD8:  .byte $5E, $5F, $FF

L9BDB:  .byte $60, $FF

L9BDD:  .byte $61, $F7, $62, $F7, $FF

L9BE2:  .byte $66, $67, $FF

L9BE5:  .byte $69, $6A, $FF

L9BE8:  .byte $68, $FF

L9BEA:  .byte $6B, $FF

L9BEC:  .byte $66, $FF

L9BEE:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9BF0:  .word $9DD8, $9DDD, $9DE2, $9DE7, $9DFA, $9E0E, $9E24, $9E3A
L9C00:  .word $9E4D, $9E61, $9E77, $9E8D, $9E97, $9E9C, $9EA1, $9EA6
L9C10:  .word $9EAB, $9EB0, $9EB5, $9EBA, $9EBF, $9EBF, $9EBF, $9EBF
L9C20:  .word $9ECE, $9EDD, $9EEE, $9EFF, $9F07, $9F07, $9F07, $9F07
L9C30:  .word $9F07, $9F07, $9F0F, $9F17, $9F17, $9F17, $9F17, $9F17
L9C40:  .word $9F23, $9F31, $9F3F, $9F4D, $9F59, $9F67, $9F75, $9F83
L9C50:  .word $9F8E, $9F9C, $9FAA, $9FB6, $9FC4, $9FD2, $9FDE, $9FDE
L9C60:  .word $9FF2, $A006, $A006, $A006, $A006, $A006, $A006, $A006
L9C70:  .word $A006, $A006, $A006, $A00B, $A013, $A01B, $A01B, $A01B
L9C80:  .word $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B
L9C90:  .word $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B
L9CA0:  .word $A01B, $A027, $A033, $A03F, $A04B, $A057, $A063, $A06F
L9CB0:  .word $A07B, $A083, $A091, $A0AB, $A0AB, $A0AB, $A0AB, $A0B3
L9CC0:  .word $A0BB, $A0C3, $A0CB, $A0D3, $A0DB, $A0DB, $A0DB, $A0DB
L9CD0:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB
L9CE0:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB

EnemyFramePtrTbl2:
L9CF0:  .word $A0DB, $A0E1, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9D00:  .word $A0E6, $A0E6

EnemyPlacePtrTbl:
L9D04:  .word $9D22, $9D24, $9D3C, $9D60, $9D72, $9D64, $9D6E, $9D76
L9D14:  .word $9D82, $9D8A, $9D8A, $9DAA, $9DB8, $9DBC, $9DCC

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D22:  .byte $FC, $FC

L9D24:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9D34:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9D3C:  .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
L9D4C:  .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
L9D5C:  .byte $12, $E8, $14, $F8

L9D60:  .byte $F4, $F4, $F4, $04

L9D64:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9D6E:  .byte $FC, $F8, $FC, $00

L9D72:  .byte $F0, $F8, $F0, $00

L9D76:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9D82:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9D8A:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9D9A:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DAA:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9DB8:  .byte $F8, $FC, $00, $FC

L9DBC:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9DCC:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

;Enemy frame drawing data.

L9DD8:  .byte $00, $02, $02, $14, $FF

L9DDD:  .byte $00, $02, $02, $24, $FF

L9DE2:  .byte $00, $00, $00, $04, $FF

L9DE7:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9DF7:  .byte $F9, $F8, $FF

L9DFA:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9D0A:  .byte $D8, $FE, $E8, $FF

L9E0E:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E1E:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E24:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E34:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E3A:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E4A:  .byte $F9, $F8, $FF

L9E4D:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E5D:  .byte $D8, $FE, $E8, $FF

L9E61:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E71:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E77:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E87:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E8D:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9E97:  .byte $30, $07, $07, $EC, $FF

L9E9C:  .byte $30, $07, $07, $FB, $FF

L9EA1:  .byte $F0, $07, $07, $EC, $FF

L9EA6:  .byte $F0, $07, $07, $FB, $FF

L9EAB:  .byte $70, $07, $07, $EC, $FF

L9EB0:  .byte $70, $07, $07, $FB, $FF

L9EB5:  .byte $B0, $07, $07, $EC, $FF

L9EBA:  .byte $B0, $07, $07, $FB, $FF

L9EBF:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9ECE:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9EDD:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9EED:  .byte $FF

L9EEE:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9EFE:  .byte $FF

L9EFF:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F07:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F0F:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF, $27, $08, $08, $EE, $EF

L9F17:  .byte $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9F23:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9F31:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9F3F:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9F4D:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9F59:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9F67:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9F75:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

L9F83:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

L9F8E:  .byte $2D, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9F9C:  .byte $2D, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9FAA:  .byte $2E, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9FB6:  .byte $AD, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9FC4:  .byte $AD, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9FD2:  .byte $AE, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9FDE:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FEE:  .byte $00, $08, $F2, $FF

L9FF2:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
LA002:  .byte $00, $08, $E2, $FF

LA006:  .byte $20, $04, $04, $C0, $FF

LA00B:  .byte $20, $00, $00, $FC, $F8, $00, $D0, $FF

LA013:  .byte $23, $00, $00, $D1, $FD, $62, $D1, $FF

LA01B:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA027:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA033:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA03F:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA04B:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA057:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA063:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA06F:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA07B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA083:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA091:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA0A1:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA0AB:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0B3:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0BB:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0C3:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0CB:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0D3:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0DB:  .byte $0C, $08, $04, $14, $24, $FF

A0E1:   .byte $00, $04, $04, $8A, $FF

A0E6:   .byte $00, $04, $04, $8A, $FF


;------------------------------------------[ Palette data ]------------------------------------------

.include ridley/palettes.asm

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include ridley/room_ptrs.asm

StrctPtrTbl:
.include ridley/structure_ptrs.asm

;-----------------------------------[ Special items table ]-----------------------------------------

.include ridley/items.asm

;-----------------------------------------[ Room definitions ]---------------------------------------

.include ridley/rooms.asm

;---------------------------------------[ Structure definitions ]------------------------------------

.include ridley/structures.asm

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAB23:  .byte $FF, $FF, $F0, $F0
LAB27:  .byte $F1, $F1, $F1, $F1
LAB2B:  .byte $A4, $FF, $A4, $FF
LAB2F:  .byte $FF, $A5, $FF, $A5
LAB33:  .byte $80, $81, $82, $83
LAB37:  .byte $45, $46, $45, $46
LAB3B:  .byte $FF, $FF, $59, $5A
LAB3F:  .byte $FF, $FF, $5A, $5B
LAB43:  .byte $60, $61, $62, $63
LAB47:  .byte $0C, $0D, $0E, $0F
LAB4B:  .byte $EC, $FF, $ED, $FF
LAB4F:  .byte $FF, $EE, $FF, $EF
LAB53:  .byte $1C, $1D, $1E, $1F
LAB57:  .byte $20, $21, $22, $23
LAB5B:  .byte $25, $25, $24, $24
LAB5F:  .byte $26, $27, $28, $29
LAB63:  .byte $2A, $2B, $2C, $2D
LAB67:  .byte $18, $19, $1A, $1B
LAB6B:  .byte $A0, $A0, $A0, $A0
LAB6F:  .byte $A1, $A1, $A1, $A1
LAB73:  .byte $10, $11, $12, $13
LAB77:  .byte $04, $05, $06, $07
LAB7B:  .byte $E0, $E1, $E2, $E3
LAB7F:  .byte $70, $71, $72, $73
LAB83:  .byte $FF, $FF, $43, $43
LAB87:  .byte $44, $44, $44, $44
LAB8B:  .byte $14, $15, $16, $17
LAB8F:  .byte $88, $89, $8A, $8B
LAB93:  .byte $E8, $E9, $EA, $EB
LAB97:  .byte $78, $79, $7A, $7B
LAB9B:  .byte $55, $56, $57, $58
LAB9F:  .byte $90, $91, $92, $93
LABA3:  .byte $C7, $C8, $C9, $CA

;Not used.
LABA7:  .byte $11, $11, $11, $04, $11, $11, $11, $11, $FF, $08, $20, $22, $22, $22, $22, $22
LABB7:  .byte $22, $22, $FF, $01, $1F, $FF, $01, $21, $01, $21, $01, $21, $FF, $08, $23, $23
LABC7:  .byte $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24, $24, $23, $08
LABD7:  .byte $23, $23, $23, $23, $23, $23, $23, $23, $FF, $01, $23, $01, $23, $01, $23, $01
LABE7:  .byte $23, $FF, $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24
LABF7:  .byte $23, $04, $23, $23, $23, $23, $FF, $01, $25, $FF, $01, $26, $01, $26, $01, $26
LAC07:  .byte $01, $26, $FF, $03, $27, $27, $27, $FF, $03, $28, $28, $28, $FF, $08, $13, $13
LAC17:  .byte $13, $13, $13, $13, $13, $13, $FF, $01, $13, $01, $13, $01, $13, $01, $13, $FF
LAC27:  .byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF, $F1, $F1, $F1, $F1, $FF
LAC37:  .byte $FF, $F0, $F0, $64, $64, $64, $64, $FF, $FF, $64, $64, $A4, $FF, $A4, $FF, $FF
LAC47:  .byte $A5, $FF, $A5, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $4F, $4F, $4F, $4F, $84
LAC57:  .byte $85, $86, $87, $88, $89, $8A, $8B, $80, $81, $82, $83, $FF, $FF, $BA, $BA, $BB
LAC67:  .byte $BB, $BB, $BB, $10, $11, $12, $13, $04, $05, $06, $07, $14, $15, $16, $17, $1C
LAC77:  .byte $1D, $1E, $1F, $09, $09, $09, $09, $0C, $0D, $0E, $0F, $FF, $FF, $59, $5A, $FF
LAC87:  .byte $FF, $5A, $5B, $51, $52, $53, $54, $55, $56, $57, $58, $EC, $FF, $ED, $FF, $FF
LAC97:  .byte $EE, $FF, $EF, $45, $46, $45, $46, $4B, $4C, $4D, $50, $FF, $FF, $FF, $FF, $47
LACA7:  .byte $48, $47, $48, $08, $08, $08, $08, $70, $71, $72, $73, $74, $75, $76, $77, $E0
LACB7:  .byte $E1, $E2, $E3, $E4, $E5, $E6, $E7, $20, $21, $22, $23, $25, $25, $24, $24, $78
LACC7:  .byte $79, $7A, $7B, $E8, $E9, $EA, $EB, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $0D
LACD7:  .byte $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15, $21
LACE7:  .byte $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F, $0D
LACF7:  .byte $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21, $1C
LAD07:  .byte $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C, $1C
LAD17:  .byte $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF, $02
LAD27:  .byte $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01, $21
LAD37:  .byte $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22, $22
LAD47:  .byte $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21, $11
LAD57:  .byte $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF, $01
LAD67:  .byte $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D, $22
LAD77:  .byte $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21, $08
LAD87:  .byte $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22, $20
LAD97:  .byte $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17, $17
LADA7:  .byte $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08, $18
LADB7:  .byte $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C, $1F
LADC7:  .byte $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18, $18
LADD7:  .byte $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07, $0D
LADE7:  .byte $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07, $0D
LADF7:  .byte $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01
LAE07:  .byte $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01, $18
LAE17:  .byte $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14, $04
LAE27:  .byte $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF, $08
LAE37:  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10, $0E
LAE47:  .byte $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF, $FF
LAE57:  .byte $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F, $4F
LAE67:  .byte $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10, $11
LAE77:  .byte $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C, $1D
LAE87:  .byte $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A, $2C
LAE97:  .byte $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28, $28
LAEA7:  .byte $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B, $2B
LAEB7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D, $3E
LAEC7:  .byte $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B, $0B
LAED7:  .byte $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56, $57
LAEE7:  .byte $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D, $62
LAEF7:  .byte $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F, $70
LAF07:  .byte $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49, $4A
LAF17:  .byte $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18, $19
LAF27:  .byte $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D, $0D
LAF37:  .byte $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33, $FF
LAF47:  .byte $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B, $3E
LAF57:  .byte $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89, $8A
LAF67:  .byte $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8, $B9
LAF77:  .byte $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14, $15
LAF87:  .byte $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13, $BC
LAF97:  .byte $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF, $BA
LAFA7:  .byte $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF, $08
LAFB7:  .byte $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C, $4D
LAFC7:  .byte $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12, $FF
LAFD7:  .byte $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00, $BC
LAFE7:  .byte $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $20, $20, $20
LAFF7:  .byte $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

;------------------------------------------[ Area music data ]---------------------------------------

; Ridley Music Data
.include ridley/music.asm

; Kraid Music Data
.include kraid/music.asm

;Not used.
B0E7:   .byte $2A, $2A, $2A, $B9, $2A, $2A, $2A, $B2, $2A, $2A, $2A, $2A, $2A, $B9, $2A, $12
B0F7:   .byte $2A, $B2, $26, $B9, $0E, $26, $26, $B2, $26, $B9, $0E, $26, $26, $B2, $22, $B9
B107:   .byte $0A, $22, $22, $B2, $22, $B9, $0A, $22, $22, $B2, $20, $20, $B9, $20, $20, $20
B117:   .byte $B2, $20, $B9, $34, $30, $34, $38, $34, $38, $3A, $38, $3A, $3E, $3A, $3E, $FF
B127:   .byte $C2, $B2, $18, $30, $18, $30, $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2
B137:   .byte $22, $20, $1C, $18, $16, $14, $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $B2
B147:   .byte $2A, $28, $28, $B9, $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $26
B157:   .byte $26, $3E, $FF, $F0, $B2, $01, $04, $01, $04, $FF, $E0, $BA, $2A, $1A, $02, $3A
B167:   .byte $40, $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C
B177:   .byte $38, $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A
B187:   .byte $4C, $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF
B197:   .byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $2B, $3B, $1B, $5A, $D0, $D1, $C3
B1A7:   .byte $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF
B1B7:   .byte $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC
B1C7:   .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
B1D7:   .byte $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03
B1E7:   .byte $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18
B1F7:   .byte $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include reset.asm

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.org $BFFA, $FF
LBFFA:  .word NMI                       ;($C0D9)NMI vector.
LBFFC:  .word RESET                     ;($FFB0)Reset vector.
LBFFE:  .word RESET                     ;($FFB0)IRQ vector.
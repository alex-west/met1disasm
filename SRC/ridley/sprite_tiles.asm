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

;Ridley's Hideout Sprite Tiles

L9160:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9170:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9180:  .byte $00, $00, $08, $31, $7A, $DA, $19, $FD, $00, $00, $00, $21, $5A, $DA, $99, $FD
L9190:  .byte $8C, $9C, $BC, $78, $E0, $D8, $A2, $48, $8C, $98, $B0, $60, $C0, $9E, $3D, $77
L91A0:  .byte $00, $00, $00, $40, $E0, $E0, $F0, $78, $00, $00, $00, $40, $E0, $C0, $40, $60
L91B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91C0:  .byte $18, $0C, $04, $02, $01, $0E, $18, $2C, $06, $02, $03, $01, $00, $00, $07, $13
L91D0:  .byte $19, $00, $40, $18, $0C, $96, $56, $00, $DE, $6E, $DE, $C6, $E3, $61, $25, $B9
L91E0:  .byte $00, $00, $00, $03, $2E, $2E, $12, $33, $3C, $7F, $FF, $FC, $D1, $50, $69, $0E
L91F0:  .byte $00, $00, $00, $80, $40, $70, $7C, $35, $00, $00, $C0, $60, $B0, $68, $73, $B2
L9200:  .byte $00, $05, $0C, $5F, $34, $19, $33, $BE, $00, $05, $0C, $5F, $34, $19, $31, $B6
L9210:  .byte $40, $20, $B4, $48, $DA, $66, $63, $03, $40, $20, $B4, $48, $9A, $66, $4B, $11
L9220:  .byte $00, $09, $02, $1A, $3D, $6F, $55, $2A, $00, $09, $02, $1A, $3D, $6F, $55, $2E
L9230:  .byte $40, $40, $20, $E8, $A4, $9C, $D6, $CA, $40, $40, $20, $E8, $A4, $1C, $96, $CA
L9240:  .byte $80, $C1, $63, $78, $3E, $3E, $1E, $0E, $80, $40, $20, $18, $04, $00, $00, $00
L9250:  .byte $5A, $DB, $DB, $FF, $7E, $18, $81, $81, $50, $00, $00, $00, $00, $00, $00, $24
L9260:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9270:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9280:  .byte $F2, $64, $0F, $DA, $8D, $5B, $10, $10, $FB, $70, $01, $C0, $8D, $58, $10, $10
L9290:  .byte $90, $40, $20, $80, $B0, $70, $5C, $60, $EF, $3E, $18, $80, $00, $10, $5C, $60
L92A0:  .byte $B8, $38, $30, $80, $80, $60, $20, $18, $A0, $A4, $66, $C6, $3E, $0C, $20, $18
L92B0:  .byte $30, $27, $2D, $38, $2A, $5E, $70, $40, $10, $00, $01, $00, $12, $20, $00, $00
L92C0:  .byte $0A, $40, $40, $51, $78, $C4, $C2, $90, $31, $3D, $3B, $2C, $06, $3B, $3D, $6F
L92D0:  .byte $00, $08, $10, $80, $42, $00, $2E, $5A, $F9, $B1, $40, $60, $3E, $0E, $82, $92
L92E0:  .byte $00, $00, $00, $00, $00, $0C, $0E, $0C, $00, $00, $00, $0C, $1E, $13, $15, $16
L92F0:  .byte $00, $01, $01, $00, $00, $08, $04, $12, $00, $00, $00, $06, $0F, $07, $03, $09
L9300:  .byte $5D, $23, $54, $2B, $24, $1E, $0F, $04, $5D, $23, $55, $2B, $20, $1C, $0F, $04
L9310:  .byte $01, $A7, $06, $0B, $4A, $D6, $2C, $F0, $59, $F1, $52, $FB, $6A, $D6, $2C, $F0
L9320:  .byte $EC, $F5, $7C, $99, $42, $60, $38, $0F, $CE, $D5, $70, $9D, $47, $68, $38, $0F
L9330:  .byte $AF, $73, $36, $26, $0C, $1C, $78, $C0, $AF, $73, $76, $A6, $4C, $1C, $78, $C0
L9340:  .byte $69, $2C, $0E, $77, $D4, $B4, $E2, $00, $03, $01, $00, $70, $F0, $F0, $E0, $00
L9350:  .byte $69, $2C, $0E, $37, $14, $04, $02, $00, $03, $01, $00, $30, $10, $00, $00, $00
L9360:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9370:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9380:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $00, $00, $18, $3C, $3C, $FE, $7D, $FF
L9390:  .byte $81, $42, $24, $24, $3C, $7E, $C3, $A5, $00, $00, $00, $00, $00, $00, $00, $24
L93A0:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $00, $00, $18, $3C, $3F, $FF, $7C, $FE
L93B0:  .byte $00, $00, $80, $00, $00, $08, $04, $82, $00, $00, $00, $86, $8F, $87, $83, $41
L93C0:  .byte $D1, $E4, $88, $00, $00, $30, $88, $70, $2E, $18, $73, $FF, $7F, $8F, $47, $8F
L93D0:  .byte $80, $00, $00, $20, $00, $10, $30, $70, $00, $00, $C0, $C0, $F0, $E0, $C0, $80
L93E0:  .byte $0C, $0C, $0C, $18, $18, $10, $10, $00, $30, $34, $3C, $28, $38, $30, $30, $20
L93F0:  .byte $01, $05, $1D, $20, $01, $00, $00, $00, $3C, $38, $20, $40, $40, $40, $40, $80
L9400:  .byte $00, $03, $1C, $90, $80, $80, $40, $20, $FF, $FC, $E0, $60, $78, $7C, $3C, $1E
L9410:  .byte $20, $C0, $00, $00, $00, $00, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00
L9420:  .byte $38, $4C, $86, $36, $7E, $7E, $6C, $38, $00, $08, $04, $14, $3C, $38, $00, $00
L9430:  .byte $9E, $7F, $3F, $07, $4E, $3D, $03, $0A, $F0, $68, $30, $3C, $5A, $3F, $07, $0B
L9440:  .byte $12, $04, $2F, $2F, $3F, $3F, $5F, $2F, $13, $0F, $3D, $3E, $34, $78, $70, $68
L9450:  .byte $00, $80, $60, $F0, $E8, $F8, $F0, $FC, $C0, $70, $98, $0C, $14, $06, $0E, $02
L9460:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9470:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9480:  .byte $00, $18, $20, $00, $00, $00, $00, $00, $64, $C0, $1C, $78, $3C, $12, $22, $20
L9490:  .byte $E7, $5A, $3C, $5A, $81, $81, $42, $00, $66, $42, $00, $00, $00, $00, $00, $00
L94A0:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $01, $03, $1B, $3E, $3C, $FE, $7C, $FE
L94B0:  .byte $41, $21, $10, $04, $00, $00, $00, $00, $20, $1C, $0E, $03, $00, $00, $00, $00
L94C0:  .byte $00, $00, $00, $00, $00, $01, $3E, $00, $FF, $FC, $F8, $73, $7F, $7E, $00, $00
L94D0:  .byte $00, $00, $00, $00, $08, $97, $59, $08, $E0, $00, $00, $EC, $F6, $73, $39, $08
L94E0:  .byte $00, $00, $01, $07, $0F, $0D, $1B, $10, $00, $01, $06, $09, $15, $1F, $2B, $30
L94F0:  .byte $00, $40, $E0, $D8, $D8, $BC, $3E, $0C, $60, $B0, $D8, $E4, $F6, $FB, $39, $0A
L9500:  .byte $30, $26, $08, $18, $33, $06, $00, $00, $0E, $19, $13, $1B, $32, $06, $00, $00
L9510:  .byte $04, $02, $31, $5B, $7B, $7E, $3E, $18, $00, $00, $00, $1A, $3A, $1C, $00, $00
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
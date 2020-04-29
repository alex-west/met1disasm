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

;Tourian Sprite Tiles

L9160:  .byte $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $03, $06, $0D
L9170:  .byte $00, $00, $00, $00, $00, $00, $98, $64, $00, $00, $00, $7E, $C3, $00, $00, $00
L9180:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80, $C0, $60, $30
L9190:  .byte $00, $00, $00, $00, $00, $02, $06, $0C, $00, $00, $03, $04, $08, $12, $16, $2C
L91A0:  .byte $00, $00, $00, $00, $80, $78, $04, $04, $00, $FF, $00, $00, $00, $00, $00, $00
L91B0:  .byte $00, $00, $00, $00, $00, $00, $10, $20, $00, $00, $C0, $20, $10, $08, $04, $04
L91C0:  .byte $00, $15, $0F, $05, $3F, $2F, $7E, $3D, $00, $00, $00, $00, $01, $07, $06, $0D
L91D0:  .byte $03, $07, $17, $13, $0F, $1F, $1D, $1F, $01, $04, $03, $03, $07, $06, $05, $1D
L91E0:  .byte $E0, $A0, $B0, $18, $0F, $00, $00, $00, $A0, $00, $80, $10, $02, $00, $00, $00
L91F0:  .byte $00, $00, $00, $00, $80, $00, $00, $00, $7F, $7F, $7F, $7F, $FF, $3F, $3F, $3F
L9200:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9210:  .byte $F0, $20, $40, $80, $80, $C0, $70, $10, $A0, $00, $00, $00, $87, $1F, $2E, $EF
L9220:  .byte $00, $00, $10, $30, $60, $60, $F0, $60, $00, $00, $10, $30, $E0, $68, $F4, $66
L9230:  .byte $00, $00, $0C, $06, $03, $00, $10, $30, $2C, $27, $3D, $56, $5B, $CC, $D7, $F0
L9240:  .byte $00, $00, $00, $03, $1E, $0C, $08, $00, $00, $00, $00, $03, $9E, $EC, $F8, $F0
L9250:  .byte $00, $00, $00, $07, $0F, $1F, $1E, $1C, $00, $00, $00, $00, $03, $04, $08, $08
L9260:  .byte $03, $02, $04, $0A, $09, $13, $03, $01, $1B, $1A, $30, $30, $60, $60, $60, $78
L9270:  .byte $18, $3C, $3C, $3C, $DB, $E7, $E7, $E7, $00, $00, $00, $18, $00, $00, $81, $00
L9280:  .byte $40, $80, $80, $40, $88, $D0, $C0, $80, $10, $18, $0C, $0C, $06, $06, $06, $1E
L9290:  .byte $08, $00, $00, $00, $0D, $33, $03, $01, $28, $40, $40, $40, $80, $81, $81, $F0
L92A0:  .byte $18, $3C, $3C, $3C, $DB, $E7, $E7, $E7, $00, $18, $3C, $18, $81, $C3, $E7, $C3
L92B0:  .byte $20, $20, $40, $4C, $90, $C0, $C0, $80, $02, $02, $02, $01, $01, $81, $81, $0F
L92C0:  .byte $3F, $5E, $5B, $3B, $37, $0B, $01, $00, $0F, $0E, $03, $09, $01, $00, $00, $00
L92D0:  .byte $1F, $0B, $0F, $1C, $06, $0F, $07, $02, $07, $03, $07, $00, $02, $01, $00, $00
L92E0:  .byte $00, $00, $E0, $70, $20, $00, $00, $00, $03, $07, $E7, $7F, $2F, $1F, $1F, $1F
L92F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $F1, $FE, $FF, $FF, $FF, $FF, $FF, $FF
L9300:  .byte $80, $C0, $60, $70, $78, $38, $30, $00, $80, $C0, $60, $76, $7B, $3B, $77, $47
L9310:  .byte $18, $08, $08, $1C, $08, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9320:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $8F, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9330:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $F0, $FE, $FF, $FF, $FF, $FF
L9340:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $F8, $F8, $F4, $FC, $FE, $FE, $FA, $FE
L9350:  .byte $00, $00, $00, $01, $07, $0E, $0C, $18, $00, $00, $00, $00, $03, $04, $08, $08
L9360:  .byte $00, $30, $38, $38, $30, $10, $08, $00, $4E, $03, $00, $20, $20, $10, $08, $00
L9370:  .byte $C3, $00, $00, $00, $81, $C3, $C3, $66, $00, $C3, $FF, $3C, $99, $C3, $C3, $66
L9380:  .byte $00, $0C, $1C, $1C, $0C, $08, $10, $00, $72, $C0, $00, $04, $04, $08, $10, $00
L9390:  .byte $00, $30, $38, $38, $31, $11, $09, $00, $8C, $87, $41, $20, $21, $11, $09, $00
L93A0:  .byte $C3, $00, $00, $00, $00, $81, $00, $81, $00, $00, $C3, $7E, $3C, $99, $00, $81
L93B0:  .byte $00, $0C, $1C, $1C, $8C, $88, $90, $00, $31, $E1, $82, $04, $84, $88, $90, $00
L93C0:  .byte $4A, $BE, $7A, $34, $58, $3C, $3C, $14, $08, $1C, $38, $34, $18, $18, $18, $14
L93D0:  .byte $18, $18, $18, $10, $18, $18, $10, $10, $18, $18, $18, $10, $18, $18, $10, $10
L93E0:  .byte $00, $00, $03, $07, $01, $00, $00, $80, $1F, $1F, $1F, $1F, $1F, $1F, $0F, $8F
L93F0:  .byte $00, $C0, $E0, $E0, $C2, $03, $01, $41, $FF, $DF, $EF, $EF, $CD, $1C, $FE, $FE
L9400:  .byte $00, $10, $10, $18, $10, $10, $10, $00, $00, $08, $08, $18, $08, $08, $08, $00
L9410:  .byte $00, $00, $00, $10, $1C, $0C, $07, $02, $00, $00, $00, $08, $0C, $0A, $01, $02
L9420:  .byte $00, $00, $00, $3E, $08, $00, $00, $00, $00, $00, $00, $08, $3E, $00, $00, $00
L9430:  .byte $3C, $7E, $FF, $FF, $FF, $FF, $7E, $3C, $00, $20, $40, $00, $00, $00, $00, $00
L9440:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $DE, $FE, $FC, $FC, $FC, $F8, $F8, $F8
L9450:  .byte $00, $00, $00, $00, $01, $04, $00, $08, $00, $00, $00, $00, $01, $04, $00, $08
L9460:  .byte $00, $3D, $4A, $81, $4A, $3D, $00, $00, $00, $3D, $7A, $FF, $7A, $3D, $00, $00
L9470:  .byte $05, $18, $39, $66, $46, $4C, $78, $00, $05, $1A, $3D, $7E, $7E, $7C, $78, $00
L9480:  .byte $15, $0A, $11, $1B, $11, $11, $0A, $04, $15, $0E, $15, $1F, $1F, $1F, $0E, $04
L9490:  .byte $00, $00, $00, $18, $3C, $10, $0A, $00, $81, $4A, $28, $3C, $FD, $34, $4A, $89
L94A0:  .byte $00, $00, $30, $4A, $68, $1D, $20, $08, $00, $00, $30, $7A, $78, $15, $22, $08
L94B0:  .byte $00, $10, $00, $00, $0C, $12, $00, $00, $3C, $DF, $E6, $BD, $DF, $DF, $72, $1C
L94C0:  .byte $34, $18, $18, $30, $14, $00, $08, $00, $10, $18, $00, $10, $00, $00, $08, $00
L94D0:  .byte $18, $10, $10, $10, $00, $10, $00, $10, $18, $10, $10, $10, $00, $10, $00, $10
L94E0:  .byte $80, $80, $C0, $70, $59, $CF, $80, $80, $8F, $05, $43, $13, $41, $04, $80, $80
L94F0:  .byte $E1, $41, $41, $C2, $83, $03, $03, $04, $BD, $9C, $9E, $1E, $3D, $7C, $B8, $2C
L9500:  .byte $00, $42, $3C, $3C, $3C, $3C, $42, $00, $00, $00, $18, $24, $24, $18, $00, $00
L9510:  .byte $10, $52, $24, $03, $C0, $24, $4A, $08, $34, $5E, $E5, $43, $C2, $A7, $7A, $2C
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

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
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Brinstar (memory page 1)

.org $8000

include "MetroidDefines.txt"

BANK = 1

;--------------------------------------[ Forward declarations ]--------------------------------------

Startup                = $C01A
NMI                    = $C0D9
ChooseRoutine          = $C27C
Adiv32                 = $C2BE
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

;Partial font, "THE END".
L8D60:
.include misc_chr/end_font.asm

;Brinstar enemy tile patterns.
L9160:
.include "brinstar/sprite_tiles.asm"

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A271)
L9562:  .word Palette01                 ;($A295)
L9564:  .word Palette02                 ;($A2A1)
L9566:  .word Palette03                 ;($A29B)
L9568:  .word Palette04                 ;($A2A7)
L956A:  .word Palette05                 ;($A2AD)
L956C:  .word Palette06                 ;($A2D0)
L956E:  .word Palette06                 ;($A2D0)
L9570:  .word Palette06                 ;($A2D0)
L9572:  .word Palette06                 ;($A2D0)
L9574:  .word Palette06                 ;($A2D0)
L9576:  .word Palette06                 ;($A2D0)
L9578:  .word Palette06                 ;($A2D0)
L957A:  .word Palette06                 ;($A2D0)
L957C:  .word Palette06                 ;($A2D0)
L957E:  .word Palette06                 ;($A2D0)
L9580:  .word Palette06                 ;($A2D0)
L9582:  .word Palette06                 ;($A2D0)
L9584:  .word Palette06                 ;($A2D0)
L9586:  .word Palette06                 ;($A2D0)
L9588:  .word Palette07                 ;($A2D7)
L958A:  .word Palette08                 ;($A2DE)
L958C:  .word Palette09                 ;($A2E5)
L958E:  .word Palette0A                 ;($A2EC)
L9590:  .word Palette0B                 ;($A2F4)
L9592:  .word Palette0C                 ;($A2FC)
L9594:  .word Palette0D                 ;($A304)
L9596:  .word Palette0E                 ;($A30C)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A3D6)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A314)Beginning of room pointer table.        
L959C:  .word StrctPtrTbl               ;($A372)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AEF0)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9DE0)Pointer table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9EE0)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9F0E)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9D6A)index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60 
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:  JMP $9D35                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $FF                       ;Not used.
                                
L95CD:  .byte $01                       ;Brinstar music init flag.

L95CE:  .byte $80                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $00                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $2B, $2C, $28, $0B, $1C, $0A, $1A

L95D7:  .byte $03                       ;Samus start x coord on world map.
L95D8:  .byte $0E                       ;Samus start y coord on world map.
L95D9:  .byte $B0                       ;Samus start verticle screen position.

L95DA:  .byte $01, $00, $03, $43, $00, $00, $00, $00, $00, $00, $69 

; Enemy AI jump table
L95E5:  LDA EnDataIndex, X
L95E8:  JSR $8024

L95EB:  .word $99B8 ; 00 - Sidehopper
L95ED:  .word $99D3 ; 01 - Ceiling sidehopper
L95EF:  .word $99E5 ; 02 - Waver
L95F1:  .word $99D8 ; 03 - Ripper
L95F3:  .word $99FA ; 04 - Skree
L95F5:  .word $9A4C ; 05 - Wallcrawler
L95F7:  .word $9AF5 ; 06 - Rio (swoopers)
L95F9:  .word $9B32 ; 07 - Pipe bugs
L95FB:  .word $9BA2 ; 08 - Kraid? (crashes)
L95FD:  .word $9BD2 ; 09 - Kraid projectile? (crashes)
L95FF:  .word $9C1A ; 0A - jumps immediately to the above routine
L9601:  .word $0000 ; 0B - Null pointers (hard crash)
L9603:  .word $0000 ; 0C - Null
L9605:  .word $0000 ; 0D - Null
L9607:  .word $0000 ; 0E - Null
L9609:  .word $0000 ; 0F - Null

L960B:  .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $4B, $4B, $55, $53

L961B:  .byte $72, $74, $00, $00, $00, $00, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

EnemyHitPointTbl:
L962B:  .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

L963B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $59, $57 

L964B:  .byte $6C, $6F, $5B, $5D, $62, $67, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $50, $4D

L966B:  .byte $6C, $6F, $5B, $5D, $5F, $64, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00 

L968B:  .byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00 

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00 

L96AB:  .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00 

EnemyInitDelayTbl:
L96BB:  .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:  .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

L96DB:  .word $97EF, $97F2, $97F5, $97F5, $97F5, $97F5, $97F5, $97F5
L96EB:  .word $97F5, $97F5, $97F5, $9840, $988B, $988E, $9891, $98A5
L96FB:  .word $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9
L970B:  .word $98B9, $98C0, $98C7, $98CE, $98D5, $98D8, $98DB, $98F2
L971B:  .word $9909, $9920, $9937, $994E

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $40, $30, $C0, $D0, $00, $00, $7F
L9733:  .byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00 

L978B:  .byte $00, $00, $64, $67, $69, $69, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $9965, $9974, $9983, $9992, $9D36, $9D3B, $9D40, $9D45
L97B7:  .word $9D4A, $9D4F, $9D54, $9D59, $9D5E, $9D63, $9D6A, $9D6A
L97C7:  .word $9D6A, $9D6A, $9D6A, $9D6A, $9D6A

L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09
L97E1:  .byte $00, $00, $00, $0B, $01, $0C, $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97EF:  .byte $20, $22, $FE

L97F2:  .byte $20, $2A, $FE

L97F5:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9805:  .byte $05, $52, $04, $62, $02, $72, $02, $72, $04, $62, $04, $52, $05, $32, $03, $12
L9815:  .byte $04, $02, $05, $92, $03, $B2, $05, $D2, $04, $E2, $02, $F2, $FD, $03, $D2, $06
L9825:  .byte $B2, $08, $92, $05, $02, $07, $12, $05, $32, $04, $52, $03, $52, $06, $32, $08
L9835:  .byte $12, $05, $02, $07, $92, $05, $B2, $04, $D2, $FD, $FF

L9840:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L9850:  .byte $05, $5A, $04, $6A, $02, $7A, $02, $7A, $04, $6A, $04, $5A, $05, $3A, $03, $1A
L9860:  .byte $04, $0A, $05, $9A, $03, $BA, $05, $DA, $04, $EA, $02, $FA, $FD, $03, $DA, $06
L9870:  .byte $BA, $08, $9A, $05, $0A, $07, $1A, $05, $3A, $04, $5A, $03, $5A, $06, $3A, $08
L9880:  .byte $1A, $05, $0A, $07, $9A, $05, $BA, $04, $DA, $FD, $FF

L988B:  .byte $01, $01, $FF

L988E:  .byte $01, $09, $FF

L9891:  .byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L98A1:  .byte $00, $64, $00, $FB

L98A5:  .byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L98B5:  .byte $00, $64, $00, $FB

L98B9:  .byte $14, $11, $0A, $00, $14, $19, $FE

L98C0:  .byte $14, $19, $0A, $00, $14, $11, $FE

L98C7:  .byte $1E, $11, $0A, $00, $1E, $19, $FE 

L98CE:  .byte $1E, $19, $0A, $00, $1E, $11, $FE

L98D5:  .byte $50, $04, $FF

L98D8:  .byte $50, $0C, $FF

L98DB:  .byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L98EB:  .byte $05, $53, $04, $63, $50, $73, $FF

L98F2:  .byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9902:  .byte $05, $5B, $04, $6B, $50, $7B, $FF

L9909:  .byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L9919:  .byte $05, $54, $04, $64, $50, $74, $FF

L9920:  .byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9930:  .byte $05, $5C, $04, $6C, $50, $7C, $FF

L9937:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9947:  .byte $05, $52, $04, $62, $50, $72, $FF

L994E:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L995E:  .byte $05, $5A, $04, $6A, $50, $7A, $FF

L9965:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L9974:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9983:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9992:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L99A1:  LDA $81
L99A3:  CMP #$01
L99A5:  BEQ $99B0
L99A7:  CMP #$03
L99A9:  BEQ $99B5
L99AB:  LDA $00
L99AD:  JMP $8000
L99B0:  LDA $01
L99B2:  JMP $8003
L99B5:  JMP $8006

L99B8:  LDA #$09
L99BA:  STA $85
L99BC:  STA $86
L99BE:  LDA EnStatus,X
L99C1:  CMP #$03
L99C3:  BEQ $99C8
L99C5:  JSR $801B
L99C8:  LDA #$06
L99CA:  STA $00
L99CC:  LDA #$08
L99CE:  STA $01
L99D0:  JMP $99A1

L99D3:  LDA #$0F
L99D5:  JMP $99BA
L99D8:  LDA EnStatus,X
L99DB:  CMP #$03
L99DD:  BEQ $99E2
L99DF:  JSR $801E
L99E2:  JMP $99C8
L99E5:  LDA #$21
L99E7:  STA $85
L99E9:  LDA #$1E
L99EB:  STA $86
L99ED:  LDA EnStatus,X
L99F0:  CMP #$03
L99F2:  BEQ $99F7
L99F4:  JSR $801B
L99F7:  JMP $99C8
L99FA:  LDA $81
L99FC:  CMP #$01
L99FE:  BEQ $9A44
L9A00:  CMP #$03
L9A02:  BEQ $9A49
L9A04:  LDA EnCounter,X
L9A07:  CMP #$0F
L9A09:  BCC $9A3F
L9A0B:  CMP #$11
L9A0D:  BCS $9A16
L9A0F:  LDA #$3A
L9A11:  STA $6B01,X
L9A14:  BNE $9A3F
L9A16:  DEC $6B01,X
L9A19:  BNE $9A3F
L9A1B:  LDA #$00
L9A1D:  STA EnStatus,X
L9A20:  LDY #$0C
L9A22:  LDA #$0A
L9A24:  STA $00A0,Y
L9A27:  LDA EnYRoomPos,X
L9A2A:  STA $00A1,Y
L9A2D:  LDA EnXRoomPos,X
L9A30:  STA $00A2,Y
L9A33:  LDA EnNameTable,X
L9A36:  STA $00A3,Y
L9A39:  DEY 
L9A3A:  DEY 
L9A3B:  DEY 
L9A3C:  DEY 
L9A3D:  BPL $9A22
L9A3F:  LDA #$02
L9A41:  JMP $8000
L9A44:  LDA #$08
L9A46:  JMP $8003
L9A49:  JMP $8006

L9A4C:  JSR $8009
L9A4F:  AND #$03
L9A51:  BEQ $9A87
L9A53:  LDA $81
L9A55:  CMP #$01
L9A57:  BEQ $9A44
L9A59:  CMP #$03
L9A5B:  BEQ $9A49
L9A5D:  LDA EnStatus,X
L9A60:  CMP #$03
L9A62:  BEQ $9A87
L9A64:  LDA $040A,X
L9A67:  AND #$03
L9A69:  CMP #$01
L9A6B:  BNE $9A7E
L9A6D:  LDY EnYRoomPos,X
L9A70:  CPY #$E4
L9A72:  BNE $9A7E
L9A74:  JSR $9ABD
L9A77:  LDA #$03
L9A79:  STA $040A,X
L9A7C:  BNE $9A84
L9A7E:  JSR $9AE2
L9A81:  JSR $9AA8
L9A84:  JSR $9AC6
L9A87:  LDA #$03
L9A89:  JSR $800C
L9A8C:  JMP $8006
L9A8F:  LDA $0405,X
L9A92:  LSR 
L9A93:  LDA $040A,X
L9A96:  AND #$03
L9A98:  ROL 
L9A99:  TAY 
L9A9A:  LDA $9AA0,Y
L9A9D:  JMP $800F

L9AA0:  .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E 

L9AA8:  LDX PageIndex
L9AAA:  BCS $9AC5
L9AAC:  LDA $00
L9AAE:  BNE $9ABD
L9AB0:  LDY $040A,X
L9AB3:  DEY 
L9AB4:  TYA 
L9AB5:  AND #$03
L9AB7:  STA $040A,X
L9ABA:  JMP $9A8F
L9ABD:  LDA $0405,X
L9AC0:  EOR #$01
L9AC2:  STA $0405,X
L9AC5:  RTS

L9AC6:  JSR $9ADA
L9AC9:  JSR $9AE2
L9ACC:  LDX PageIndex
L9ACE:  BCC $9AD9
L9AD0:  JSR $9ADA
L9AD3:  STA $040A,X
L9AD6:  JSR $9A8F
L9AD9:  RTS

L9ADA:  LDY $040A,X
L9ADD:  INY 
L9ADE:  TYA 
L9ADF:  AND #$03
L9AE1:  RTS

L9AE2:  LDY $0405,X
L9AE5:  STY $00
L9AE7:  LSR $00
L9AE9:  ROL 
L9AEA:  ASL 
L9AEB:  TAY 
L9AEC:  LDA $8049,Y
L9AEF:  PHA 
L9AF0:  LDA $8048,Y
L9AF3:  PHA 
L9AF4:  RTS

L9AF5:  LDA $81
L9AF7:  CMP #$01
L9AF9:  BEQ $9B2D
L9AFB:  CMP #$03
L9AFD:  BEQ $9B2A
L9AFF:  LDA #$80
L9B01:  STA $6AFE,X
L9B04:  LDA $0402,X
L9B07:  BMI $9B25
L9B09:  LDA $0405,X
L9B0C:  AND #$10
L9B0E:  BEQ $9B25
L9B10:  LDA EnYRoomPos,X
L9B13:  SEC 
L9B14:  SBC $030D
L9B17:  BPL $9B1C
L9B19:  JSR $95C6
L9B1C:  CMP #$10
L9B1E:  BCS $9B25
L9B20:  LDA #$00
L9B22:  STA $6AFE,X
L9B25:  LDA #$03
L9B27:  JMP $8000
L9B2A:  JMP $8006
L9B2D:  LDA #$08
L9B2F:  JMP $8003
L9B32:  LDA EnStatus,X
L9B35:  CMP #$02
L9B37:  BNE $9B71
L9B39:  LDA $0403,X
L9B3C:  BNE $9B71
L9B3E:  LDA $6AFE,X
L9B41:  BNE $9B55
L9B43:  LDA $030D
L9B46:  SEC 
L9B47:  SBC EnYRoomPos,X
L9B4A:  CMP #$40
L9B4C:  BCS $9B71
L9B4E:  LDA #$7F
L9B50:  STA $6AFE,X
L9B53:  BNE $9B71
L9B55:  LDA $0402,X
L9B58:  BMI $9B71
L9B5A:  LDA #$00
L9B5C:  STA $0402,X
L9B5F:  STA EnCounter,X
L9B62:  STA $6AFE,X
L9B65:  LDA $0405,X
L9B68:  AND #$01
L9B6A:  TAY 
L9B6B:  LDA $9BA0,Y
L9B6E:  STA $0403,X
L9B71:  LDA $0405,X
L9B74:  ASL 
L9B75:  BMI $9B95
L9B77:  LDA EnStatus,X
L9B7A:  CMP #$02
L9B7C:  BNE $9B95
L9B7E:  JSR $8036
L9B81:  PHA 
L9B82:  JSR $8039
L9B85:  STA $05
L9B87:  PLA 
L9B88:  STA $04
L9B8A:  JSR $9CA8
L9B8D:  JSR $8027
L9B90:  BCC $9B9A
L9B92:  JSR $9C96
L9B95:  LDA #$03
L9B97:  JMP $8003
L9B9A:  LDA #$00
L9B9C:  STA EnStatus,X
L9B9F:  RTS

L9BA0:  .byte $04, $FC

L9BA2:  LDA EnStatus,X
L9BA5:  CMP #$03
L9BA7:  BCC $9BC2
L9BA9:  BEQ $9BAF
L9BAB:  CMP #$05
L9BAD:  BNE $9BCB
L9BAF:  LDA #$00
L9BB1:  STA $6B04
L9BB4:  STA $6B14
L9BB7:  STA $6B24
L9BBA:  STA $6B34
L9BBD:  STA $6B44
L9BC0:  BEQ $9BCB
L9BC2:  JSR $9C1D
L9BC5:  JSR $9CCC
L9BC8:  JSR $9D05
L9BCB:  LDA #$0A
L9BCD:  STA $00
L9BCF:  JMP $99CC
L9BD2:  LDA $0405,X
L9BD5:  AND #$02
L9BD7:  BEQ $9BE0
L9BD9:  LDA EnStatus,X
L9BDC:  CMP #$03
L9BDE:  BNE $9BE7
L9BE0:  LDA #$00
L9BE2:  STA EnStatus,X
L9BE5:  BEQ $9C12
L9BE7:  LDA $0405,X
L9BEA:  ASL 
L9BEB:  BMI $9C12
L9BED:  LDA EnStatus,X
L9BF0:  CMP #$02
L9BF2:  BNE $9C12
L9BF4:  JSR $802D
L9BF7:  LDX PageIndex
L9BF9:  LDA $00
L9BFB:  STA $0402,X
L9BFE:  JSR $8030
L9C01:  LDX PageIndex
L9C03:  LDA $00
L9C05:  STA $0403,X
L9C08:  JSR $8033
L9C0B:  BCS $9C12
L9C0D:  LDA #$03
L9C0F:  STA EnStatus,X
L9C12:  LDA #$01
L9C14:  JSR $800C
L9C17:  JMP $8006
L9C1A:  JMP $9BD2
L9C1D:  LDX #$50
L9C1F:  JSR $9C2A
L9C22:  TXA 
L9C23:  SEC 
L9C24:  SBC #$10
L9C26:  TAX 
L9C27:  BNE $9C1F
L9C29:  RTS

L9C2A:  LDY EnStatus,X
L9C2D:  BEQ $9C55
L9C2F:  LDA EnDataIndex,X
L9C32:  CMP #$0A
L9C34:  BEQ $9C3A
L9C36:  CMP #$09
L9C38:  BNE $9CA7
L9C3A:  LDA $0405,X
L9C3D:  AND #$02
L9C3F:  BEQ $9C55
L9C41:  DEY 
L9C42:  BEQ $9C60
L9C44:  CPY #$02
L9C46:  BEQ $9C55
L9C48:  CPY #$03
L9C4A:  BNE $9CA7
L9C4C:  LDA $040C,X
L9C4F:  CMP #$01
L9C51:  BNE $9CA7
L9C53:  BEQ $9C60
L9C55:  LDA #$00
L9C57:  STA EnStatus,X
L9C5A:  STA EnSpecialAttribs,X
L9C5D:  JSR $802A
L9C60:  LDA $0405
L9C63:  STA $0405,X
L9C66:  LSR 
L9C67:  PHP 
L9C68:  TXA 
L9C69:  LSR 
L9C6A:  LSR 
L9C6B:  LSR 
L9C6C:  LSR 
L9C6D:  TAY 
L9C6E:  LDA $9CB7,Y
L9C71:  STA $04
L9C73:  LDA $9CC6,Y
L9C76:  STA EnDataIndex,X
L9C79:  TYA 
L9C7A:  PLP 
L9C7B:  ROL 
L9C7C:  TAY 
L9C7D:  LDA $9CBB,Y
L9C80:  STA $05
L9C82:  LDX #$00
L9C84:  JSR $9CA8
L9C87:  JSR $8027
L9C8A:  LDX PageIndex
L9C8C:  BCC $9CA7
L9C8E:  LDA EnStatus,X
L9C91:  BNE $9C96
L9C93:  INC EnStatus,X
L9C96:  LDA $08
L9C98:  STA EnYRoomPos,X
L9C9B:  LDA $09
L9C9D:  STA EnXRoomPos,X
L9CA0:  LDA $0B
L9CA2:  AND #$01
L9CA4:  STA EnNameTable,X
L9CA7:  RTS

L9CA8:  LDA EnYRoomPos,X
L9CAB:  STA $08
L9CAD:  LDA EnXRoomPos,X
L9CB0:  STA $09
L9CB2:  LDA EnNameTable,X
L9CB5:  STA $0B
L9CB7:  RTS

L9CB8:  .byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
L9CC8:  .byte $09, $09, $0A, $0A
 
L9CCC:  LDY $7E
L9CCE:  BNE $9CD2
L9CD0:  LDY #$80
L9CD2:  LDA $2D
L9CD4:  AND #$02
L9CD6:  BNE $9D04
L9CD8:  DEY 
L9CD9:  STY $7E
L9CDB:  TYA 
L9CDC:  ASL 
L9CDD:  BMI $9D04
L9CDF:  AND #$0F
L9CE1:  CMP #$0A
L9CE3:  BNE $9D04
L9CE5:  LDA #$01
L9CE7:  LDX #$10
L9CE9:  CMP EnStatus,X
L9CEC:  BEQ $9CFF
L9CEE:  LDX #$20
L9CF0:  CMP EnStatus,X
L9CF3:  BEQ $9CFF
L9CF5:  LDX #$30
L9CF7:  CMP EnStatus,X
L9CFA:  BEQ $9CFF
L9CFC:  INC $7E
L9CFE:  RTS

L9CFF:  LDA #$08
L9D01:  STA EnDelay,X
L9D04:  RTS

L9D05:  LDY $7F
L9D07:  BNE $9D0B
L9D09:  LDY #$60
L9D0B:  LDA $2D
L9D0D:  AND #$02
L9D0F:  BNE $9D34
L9D11:  DEY 
L9D12:  STY $7F
L9D14:  TYA 
L9D15:  ASL 
L9D16:  BMI $9D34
L9D18:  AND #$0F
L9D1A:  BNE $9D34
L9D1C:  LDA #$01
L9D1E:  LDX #$40
L9D20:  CMP EnStatus,X
L9D23:  BEQ $9D2F
L9D25:  LDX #$50
L9D27:  CMP EnStatus,X
L9D2A:  BEQ $9D2F
L9D2C:  INC $7F
L9D2E:  RTS

L9D2F:  LDA #$08
L9D31:  STA EnDelay,X
L9D34:  RTS

L9D35:  .byte $60, $22, $FF, $FF, $FF, $FF, $22, $80, $81, $82, $83, $22, $84, $85, $86, $87
L9D45:  .byte $22, $88, $89, $8A, $8B, $22, $8C, $8D, $8E, $8F, $22, $94, $95, $96, $97, $22
L9D55:  .byte $9C, $9D, $9D, $9C, $22, $9E, $9F, $9F, $9E, $22, $90, $91, $92, $93, $32, $4E
L9D65:  .byte $4E, $4E, $4E, $4E, $4E

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:

L9D6A:  .byte $00, $01, $FF

L9D6D:  .byte $02, $FF

L9D6F:  .byte $19, $1A, $FF

L9D72:  .byte $1A, $1B, $FF

L9D75:  .byte $1C, $1D, $FF

L9D78:  .byte $1D, $1E, $FF

L9D7B:  .byte $22, $23, $24, $FF

L9D7F:  .byte $1F, $20, $21, $FF

L9D83:  .byte $22, $FF

L9D85:  .byte $1F, $FF

L9D87:  .byte $23, $04, $FF

L9D8A:  .byte $20, $03, $FF

L9D8D:  .byte $27, $28, $29, $FF

L9D91:  .byte $37, $FF

L9D93:  .byte $38, $FF

L9D95:  .byte $39, $FF

L9D97:  .byte $3A, $FF

L9D99:  .byte $3B, $FF

L9D9B:  .byte $3C, $FF

L9D9D:  .byte $3D, $FF

L9D9F:  .byte $58, $59, $FF

L9DA2:  .byte $5A, $5B, $FF

L9DA5:  .byte $5C, $5D, $FF

L9DA8:  .byte $5E, $5F, $FF

L9DAB:  .byte $60, $FF

L9DAD:  .byte $61, $F7, $62, $F7, $FF

L9DB2:  .byte $63, $64, $FF

L9DB5:  .byte $65, $FF

L9DB7:  .byte $66, $67, $FF

L9DBA:  .byte $69, $6A, $FF

L9DBD:  .byte $68, $FF

L9DBF:  .byte $6B, $FF

L9DC1:  .byte $66, $FF

L9DC3:  .byte $69, $FF

L9DC5:  .byte $6C, $FF

L9DC7:  .byte $6D, $FF

L9DC9:  .byte $6F, $70, $71, $6E, $FF

L9DCE:  .byte $73, $74, $75, $72, $FF

L9DD3:  .byte $8F, $90, $FF

L9DD6:  .byte $91, $92, $FF

L9DD9:  .byte $93, $94, $FF

L9DDC:  .byte $95, $FF

L9DDE:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9DE0:  .word $9FC2, $9FC7, $9FCC, $9FD1, $9FDA, $9FE3, $9FE3, $9FE3
L9DF0:  .word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E00:  .word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E10:  .word $9FE3, $9FE3, $9FF1, $9FFF, $A00B, $A019, $A027, $A033
L9E20:  .word $A03C, $A046, $A050, $A059, $A063, $A06D, $A06D, $A06D
L9E30:  .word $A07B, $A082, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E40:  .word $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E50:  .word $A09F, $A0B3, $A0BE, $A0C9, $A0D2, $A0DB, $A0E6, $A0E6
L9E60:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E70:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E80:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E90:  .word $A0E6, $A0EE, $A0F6, $A0FE, $A106, $A10E, $A116, $A11E
L9EA0:  .word $A126, $A12E, $A13C, $A156, $A162, $A16F, $A177, $A17F
L9EB0:  .word $A187, $A18F, $A197, $A19F, $A1A7, $A1AF, $A1B7, $A1BF
L9EC0:  .word $A1C7, $A1CF, $A1D7, $A1DF, $A1E7, $A1EF, $A1F7, $A1F7
L9ED0:  .word $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7

EnemyFramePtrTbl2:
L9EE0:  .word $A1F7, $A1FF, $A204, $A204, $A204, $A204, $A204, $A204
L9EF0:  .word $A204, $A204, $A209, $A209, $A209, $A209, $A209, $A209
L9F00:  .word $A213, $A21D, $A22D, $A23D, $A24D, $A25D, $A267

EnemyPlacePtrTbl:
L9F0E:  .word $9F2E, $9F30, $9F48, $9F60, $9F60, $9F60, $9F70, $9F7C
L9F1E:  .word $9F84, $9F90, $9F90, $9FB0, $9FBE, $9FBE, $9FBE, $9FBE

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9F2E:  .byte $FC, $FC

;Enemy explode.
L9F30:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9F40:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9F48:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9F58:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9F60:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9F70:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9F7C:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9F84:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9F90:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9FA0:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9FB0:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9FBE:  .byte $FC, $F8, $FC, $00 

;Enemy frame drawing data.

L9FC2:  .byte $00, $02, $02, $14, $FF

L9FC7:  .byte $00, $02, $02, $24, $FF

L9FCC:  .byte $00, $00, $00, $04, $FF

L9FD1:  .byte $27, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FDA:  .byte $67, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FE3:  .byte $25, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $62, $A3, $B3, $FF

L9FF1:  .byte $25, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $62, $A5, $B3, $FF

L9FFF:  .byte $26, $08, $0A, $B5, $B3, $A4, $B4, $FD, $62, $B5, $B3, $FF

LA00B:  .byte $A5, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $E2, $A3, $B3, $FF

LA019:  .byte $A5, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $E2, $A5, $B3, $FF

LA027:  .byte $A6, $08, $0A, $B5, $B3, $A4, $B4, $FD, $E2, $B5, $B3, $FF

LA033:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA03C:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

LA046:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

LA050:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA059:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

LA063:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

LA06D:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

LA07B:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

LA082:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

LA08B:  .byte $21, $00, $00, $FC, $08, $FC, $A3, $FC, $00, $08, $A3, $FC, $00, $F8, $B3, $FC
LA09B:  .byte $00, $08, $B3, $FF

LA09F:  .byte $21, $00, $00, $FC, $00, $FC, $B3, $FC, $00, $08, $B3, $FC, $00, $F8, $A3, $FC
LA0AF:  .byte $00, $08, $A3, $FF

LA0B3:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

LA0BE:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

LA0C9:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

LA0D2:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

LA0DB:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

LA0E6:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0EE:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0F6:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA0FE:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA106:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA10E:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA116:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA11E:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA126:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA12E:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA13C:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA14C:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA156:  .byte $2B, $08, $08, $E2, $E3, $E4, $FE, $FD, $62, $E3, $E4, $FF

LA162:  .byte $2B, $08, $08, $E2, $E3, $FE, $E4, $FD, $62, $E3, $FE, $E4, $FF

LA16F:  .byte $21, $00, $00, $96, $96, $98, $98, $FF

LA177:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA17F:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA187:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA18F:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA197:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA19F:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA1A7:  .byte $20, $02, $04, $FC, $FF

LA1AC:  .byte $00, $F8, $FF

LA1AF:  .byte $60, $02, $04, $FC, $FF

LA1B4:  .byte $00, $F8, $FF

LA1B7:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA1BF:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA1C7:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA1CF:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA1D7:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA1DF:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA1E7:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA1EF:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA1F7:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA1FF:  .byte $00, $04, $04, $8A, $FF

LA204:  .byte $00, $04, $04, $8A, $FF

LA209:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA213:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA21D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA22D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA23D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA24D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA25D:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA267:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

.include "brinstar/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include brinstar/room_ptrs.asm

StrctPtrTbl:
.include brinstar/structure_ptrs.asm

;------------------------------------[ Special items table ]-----------------------------------------

.include "brinstar/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "brinstar/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "brinstar/structures.asm"

;----------------------------------------[ Macro definitions ]--------------------------------------- 

MacroDefs:
.include "brinstar/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.include "brinstar/music.asm"

; Errant Mother Brain BG tiles (unused)
LB135:  .byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
LB145:  .byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
LB155:  .byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
LB165:  .byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
LB175:  .byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
LB185:  .byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
LB195:  .byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
LB1A5:  .byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
LB1B5:  .byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
LB1C5:  .byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
LB1D5:  .byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
LB1E5:  .byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
; ???
LB1F5:  .byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include reset.asm

;;Not used.
;LBFD5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
;LBFE5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;LBFF5:  .byte $00, $00, $00, $00, $00

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.org $BFFA, $FF
LBFFA:  .word NMI                       ;($C0D9)NMI vector.
LBFFC:  .word RESET                     ;($FFB0)Reset vector.
LBFFE:  .word RESET                     ;($FFB0)IRQ vector.

BRINSTAR = 0
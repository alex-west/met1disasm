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

;Kraid hideout (memory page 4)

.org $8000

.include "MetroidDefines.txt"

BANK = 4

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

;Samus end tile patterns.
.include ending/sprite_tiles.asm

;Unused tile patterns (needed so the Palette Pointer Table, etc. below are properly aligned)
.include kraid/unused_tiles.asm

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A155)
L9562:  .word Palette01                 ;($A179)
L9564:  .word Palette02                 ;($A185)
L9566:  .word Palette03                 ;($A17F)
L9668:  .word Palette04                 ;($A18B)
L966A:  .word Palette05                 ;($A191)
L956C:  .word Palette05                 ;($A191)
L956E:  .word Palette05                 ;($A191)
L9570:  .word Palette05                 ;($A191)
L9572:  .word Palette05                 ;($A191)
L9574:  .word Palette05                 ;($A191)
L9576:  .word Palette05                 ;($A191)
L9578:  .word Palette05                 ;($A191)
L957A:  .word Palette05                 ;($A191)
L957C:  .word Palette05                 ;($A191)
L957E:  .word Palette05                 ;($A191)
L9580:  .word Palette05                 ;($A191)
L9582:  .word Palette05                 ;($A191)
L9584:  .word Palette05                 ;($A191)
L9586:  .word Palette05                 ;($A191)
L9588:  .word Palette06                 ;($A198)
L958A:  .word Palette07                 ;($A19F)
L958C:  .word Palette08                 ;($A1A6)
L958E:  .word Palette09                 ;($A1AD)
L9590:  .word Palette0A                 ;($A1B5)
L9592:  .word Palette0B                 ;($A1BD)
L9594:  .word Palette0C                 ;($A1C5)
L9596:  .word Palette0D                 ;($A1CD)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A26D)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A1D5)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A21F)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AC32)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9CF7)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9DF7)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9E25)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9C86)Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:  JMP $9C49                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $1D                       ;Kraid's room.

L95CD:  .byte $10                       ;Kraid's hideout music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $07                       ;Samus start x coord on world map.
L95D8:  .byte $14                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $43, $00, $00, $00, $00, $00, $00, $64

L95E5:  LDA EnDataIndex,X
L95E8:  JSR $8024

L95EB:  .word $991C ; 00 - sidehopper
L95ED:  .word $9937 ; 01 - ceiling sidehopper
L95EF:  .word $95CB ; 02 - unused enemy type that doesn't properly clear itself
L95F1:  .word $993C ; 03 - ripper
L95F3:  .word $9949 ; 04 - skree
L95F5:  .word $999B ; 05 - crawler
L95F7:  .word $95CB ; 06 - same as 2
L95F9:  .word GeegaRoutine ; 07 - pipe bug
L95FB:  .word KraidRoutine ; 08 - kraid
L95FD:  .word KraidLint ; 09 - kraid projectile? lint or nail?
L95FF:  .word KraidNail ; 0a - kraid projectile?
L9601:  .word $95CB ; 0b - same as 2
L9603:  .word $95CB ; 0c - same as 2
L9605:  .word $95CB ; 0d - same as 2
L9607:  .word $95CB ; 0e - same as 2
L9609:  .word $95CB ; 0f - same as 2

L960B:  .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $48, $48, $50, $4E

L961B:  .byte $6D, $6F, $00, $00, $00, $00, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L962B:  .byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $54, $52

L964B:  .byte $67, $6A, $56, $58, $5D, $62, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $4B, $48

L966B:  .byte $67, $6A, $56, $58, $5A, $5F, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

L968B:  .byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

L96AB:  .byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:  .byte $00, $03, $00, $06, $08, $0C, $00, $0A, $0E, $11, $13, $00, $00, $00, $00, $00


L96DB:  .word $97E9, $97EC, $97EF, $97EF, $97EF, $97EF, $97EF, $97EF
L96EB:  .word $97EF, $97EF, $97EF, $97EF, $97EF, $97F2, $97F5, $9809
L96FB:  .word $981D, $981D, $981D, $981D, $981D, $981D, $981D, $981D
L970B:  .word $981D, $9824, $982B, $9832, $9839, $983C, $983F, $9856
L971B:  .word $986D, $9884, $989B, $98B2

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $70, $70, $90, $90, $00, $00, $7F
L9733:  .byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

L978B:  .byte $00, $00, $5F, $62, $64, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $98C9, $98D8, $98E7, $98F6, $9C4A, $9C4F, $9C54, $9C59
L97B7:  .word $9C5E, $9C63, $9C68, $9C6D, $9C72, $9C77, $9C7C, $9C81
L97C7:  .word $9C86, $9C86, $9C86, $9C86, $9C86

L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $06, $00, $07, $00, $09, $00, $00, $01, $0C
L97E1:  .byte $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97E9:  .byte $20, $22, $FE

L97EC:  .byte $20, $2A, $FE

L97EF:  .byte $01, $01, $FF

L97F2:  .byte $01, $09, $FF

L97F5:  .byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L9805:  .byte $00, $64, $00, $FB

L9809:  .byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L9819:  .byte $00, $64, $00, $FB

L981D:  .byte $14, $11, $0A, $00, $14, $19, $FE

L9824:  .byte $14, $19, $0A, $00, $14, $11, $FE

L982B:  .byte $32, $11, $0A, $00, $32, $19, $FE

L9832:  .byte $32, $19, $0A, $00, $32, $11, $FE

L9839:  .byte $50, $04, $FF

L983C:  .byte $50, $0C, $FF

L983F:  .byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L984F:  .byte $05, $53, $04, $63, $50, $73, $FF

L9856:  .byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9866:  .byte $05, $5B, $04, $6B, $50, $7B, $FF

L986D:  .byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L987D:  .byte $05, $54, $04, $64, $50, $74, $FF

L9884:  .byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9894:  .byte $05, $5C, $04, $6C, $50, $7C, $FF

L989B:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L98AB:  .byte $05, $52, $04, $62, $50, $72, $FF

L98B2:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A ,$03, $3A
L98C2:  .byte $05, $5A, $04, $6A, $50, $7A, $FF

L98C9:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L98D8:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L98E7:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L98F6:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L9905:  LDA $81
L9907:  CMP #$01
L9909:  BEQ $9914
L990B:  CMP #$03
L990D:  BEQ $9919
L990F:  LDA $00
L9911:  JMP $8000
L9914:  LDA $01
L9916:  JMP $8003
L9919:  JMP CommonJump_02

;-------------------------------------------------------------------------------
; Sidehopper Routine
L991C:  LDA #$09
L991E:  STA $85
L9920:  STA $86
L9922:  LDA EnStatus,X
L9925:  CMP #$03
L9927:  BEQ $992C
L9929:  JSR $801B
L992C:  LDA #$06
L992E:  STA $00

CommonEnemyStub:
L9930:  LDA #$08
L9932:  STA $01
L9934:  JMP $9905

;-------------------------------------------------------------------------------
; Ceiling Sidehopper Routine
L9937:  LDA #$0F
L9939:  JMP $991E

;-------------------------------------------------------------------------------
; Ripper Routine
L993C:  LDA EnStatus,X
L993F:  CMP #$03
L9941:  BEQ $9946
L9943:  JSR $801E
L9946:  JMP $992C

;-------------------------------------------------------------------------------
; Skree Routine
L9949:  LDA $81
L994B:  CMP #$01
L994D:  BEQ $9993
L994F:  CMP #$03
L9951:  BEQ $9998
L9953:  LDA $0406,X
L9956:  CMP #$0F
L9958:  BCC $998E
L995A:  CMP #$11
L995C:  BCS $9965
L995E:  LDA #$3A
L9960:  STA $6B01,X
L9963:  BNE $998E
L9965:  DEC $6B01,X
L9968:  BNE $998E
L996A:  LDA #$00
L996C:  STA EnStatus,X
L996F:  LDY #$0C
L9971:  LDA #$0A
L9973:  STA $00A0,Y
L9976:  LDA $0400,X
L9979:  STA $00A1,Y
L997C:  LDA $0401,X
L997F:  STA $00A2,Y
L9982:  LDA $6AFB,X
L9985:  STA $00A3,Y
L9988:  DEY
L9989:  DEY
L998A:  DEY
L998B:  DEY
L998C:  BPL $9971
L998E:  LDA #$02
L9990:  JMP $8000
L9993:  LDA #$08
L9995:  JMP $8003
L9998:  JMP CommonJump_02

;-------------------------------------------------------------------------------
; Crawler Routine
L999B:  JSR $8009
L999E:  AND #$03
L99A0:  BEQ $99D6
L99A2:  LDA $81
L99A4:  CMP #$01
L99A6:  BEQ $9993
L99A8:  CMP #$03
L99AA:  BEQ $9998
L99AC:  LDA EnStatus,X
L99AF:  CMP #$03
L99B1:  BEQ $99D6
L99B3:  LDA $040A,X
L99B6:  AND #$03
L99B8:  CMP #$01
L99BA:  BNE $99CD
L99BC:  LDY $0400,X
L99BF:  CPY #$E4
L99C1:  BNE $99CD
L99C3:  JSR $9A0C
L99C6:  LDA #$03
L99C8:  STA $040A,X
L99CB:  BNE $99D3
L99CD:  JSR $9A31
L99D0:  JSR $99F7
L99D3:  JSR $9A15
L99D6:  LDA #$03
L99D8:  JSR CommonJump_UpdateEnemyAnim
L99DB:  JMP CommonJump_02
L99DE:  LDA EnData05,X
L99E1:  LSR 
L99E2:  LDA $040A,X
L99E5:  AND #$03
L99E7:  ROL 
L99E8:  TAY 
L99E9:  LDA $99EF,Y
L99EC:  JMP $800F

L99EF:  .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E

L99F7:  LDX $4B
L99F9:  BCS $9A14
L99FB:  LDA $00
L99FD:  BNE $9A0C
L99FF:  LDY $040A,X
L9A02:  DEY 
L9A03:  TYA 
L9A04:  AND #$03
L9A06:  STA $040A,X
L9A09:  JMP $99DE
L9A0C:  LDA EnData05,X
L9A0F:  EOR #$01
L9A11:  STA EnData05,X
L9A14:  RTS

L9A15:  JSR $9A29
L9A18:  JSR $9A31
L9A1B:  LDX $4B
L9A1D:  BCC $9A28
L9A1F:  JSR $9A29
L9A22:  STA $040A,X
L9A25:  JSR $99DE
L9A28:  RTS

L9A29:  LDY $040A,X
L9A2C:  INY 
L9A2D:  TYA 
L9A2E:  AND #$03
L9A30:  RTS

L9A31:  LDY EnData05,X
L9A34:  STY $00
L9A36:  LSR $00
L9A38:  ROL 
L9A39:  ASL 
L9A3A:  TAY 
L9A3B:  LDA $8049,Y
L9A3E:  PHA 
L9A3F:  LDA $8048,Y
L9A42:  PHA 
L9A43:  RTS

;-------------------------------------------------------------------------------
GeegaRoutine: ; L9A44
.include enemies/pipe_bug.asm

;-------------------------------------------------------------------------------
; Kraid Routine
.include enemies/kraid.asm
; Note: For this bank the functions StorePositionToTemp and LoadPositionFromTemp
;  are in are in kraid.asm. Extract those functions from that file if you plan
;  on removing it.

; Area Specific Routine
; -= Code not Data! =-
L9C49:  .byte $60

L9C4A:  .byte $22, $FF, $FF, $FF, $FF

L9C4F:  .byte $22, $80, $81, $82, $83

L9C54:  .byte $22, $84, $85, $86, $87

L9C59:  .byte $22, $88, $89, $8A, $8B

L9C5E:  .byte $22, $8C, $8D, $8E, $8F

L9C63:  .byte $22, $94, $95, $96, $97

L9C68:  .byte $22, $9C, $9D, $9D, $9C

L9C6D:  .byte $22, $9E, $9F, $9F, $9E

L9C72:  .byte $22, $90, $91, $92, $93

L9C77:  .byte $22, $70, $71, $72, $73

L9C7C:  .byte $22, $74, $75, $76, $77

L9C81:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9C86:  .byte $00, $01, $FF

L9C89:  .byte $02, $FF

L9C8B:  .byte $19, $1A, $FF

L9C8E:  .byte $1A, $1B, $FF

L9C91:  .byte $1C, $1D, $FF

L9C94:  .byte $1D, $1E, $FF

L9C97:  .byte $22, $23, $24, $FF

L9C9B:  .byte $1F, $20, $21, $FF

L9C9F:  .byte $22, $FF

L9CA1:  .byte $1F, $FF

L9CA3:  .byte $23, $04, $FF

L9CA6:  .byte $20, $03, $FF

L9CA9:  .byte $27, $28, $29, $FF

L9CAD:  .byte $37, $FF

L9CAF:  .byte $38, $FF

L9CB1:  .byte $39, $FF

L9CB3:  .byte $3A, $FF

L9CB5:  .byte $3B, $FF

L9CB7:  .byte $3C, $FF

L9CB9:  .byte $3D, $FF

L9CBB:  .byte $58, $59, $FF

L9CBE:  .byte $5A, $5B, $FF

L9CC1:  .byte $5C, $5D, $FF

L9CC4:  .byte $5E, $5F, $FF

L9CC7:  .byte $60, $FF

L9CC9:  .byte $61, $F7, $62, $F7, $FF

L9CCE:  .byte $66, $67, $FF

L9CD1:  .byte $69, $6A, $FF

L9CD4:  .byte $68, $FF

L9CD6:  .byte $6B, $FF

L9CD8:  .byte $66, $FF

L9CDA:  .byte $69, $FF

L9CDC:  .byte $6C, $FF

L9CDE:  .byte $6D, $FF

L9CE0:  .byte $6F, $70, $71, $6E, $FF

L9CE5:  .byte $73, $74, $75, $72, $FF

L9CEA:  .byte $8F, $90, $FF

L9CED:  .byte $91, $92, $FF

L9CF0:  .byte $93, $94, $FF

L9CF3:  .byte $95, $FF

L9CF5:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9CF7:  .word $9ED9, $9EDE, $9EE3, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D07:  .word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D17:  .word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8 
L9D27:  .word $9EE8, $9EE8, $9EF6, $9F04, $9F10, $9F1E, $9F2C, $9F38 
L9D37:  .word $9F41, $9F4B, $9F55, $9F5E, $9F68, $9F72, $9F72, $9F72
L9D47:  .word $9F80, $9F87, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D57:  .word $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D67:  .word $9FA4, $9FB8, $9FC3, $9FCE, $9FD7, $9FE0, $9FEB, $9FEB
L9D77:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D87:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D97:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9DA7:  .word $9FEB, $9FF3, $9FFB, $A003, $A00B, $A013, $A01B, $A023
L9DB7:  .word $A02B, $A033, $A041, $A05B, $A05B, $A05B, $A05B, $A063
L9BC7:  .word $A06B, $A073, $A07B, $A083, $A08B, $A093, $A09B, $A0A3
L9BD7:  .word $A0AB, $A0B3, $A0BB, $A0C3, $A0CB, $A0D3, $A0DB, $A0DB
L9BE7:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB

EnemyFramePtrTbl2:
L9DF7:  .word $A0DB, $A0E3, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8
L9E07:  .word $A0E8, $A0E8, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED
L9E17:  .word $A0F7, $A101, $A111, $A121, $A131, $A141, $A14B

EnemyPlacePtrTbl:
L9E25:  .word $9E45, $9E47, $9E5F, $9E77, $9E77, $9E77, $9E87, $9E93
L9E35:  .word $9E9B, $9EA7, $9EA7, $9EC7, $9ED5, $9ED5, $9ED5, $9ED5

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9E45:  .byte $FC, $FC

L9E47:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9E57:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9E5F:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9E6F:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9E77:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9E87:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9E93:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9E9B:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9EA7:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9EB7:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9EC7:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9ED5:  .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

L9ED9:  .byte $00, $02, $02, $14, $FF

L9EDE:  .byte $00, $02, $02, $24, $FF

L9EE3:  .byte $00, $00, $00, $04, $FF

L9EE8:  .byte $25, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9EF6:  .byte $25, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9F04:  .byte $26, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9F10:  .byte $A5, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9F1E:  .byte $A5, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9F2C:  .byte $A6, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9F38:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F41:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

L9F4B:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

L9F55:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F5E:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

L9F68:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

L9F72:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

L9F80:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

L9F87:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

L9F90:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FA0:  .byte $00, $08, $F2, $FF

L9FA4:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
L9FB4:  .byte $00, $08, $E2, $FF

L9FB8:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

L9FC3:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

L9FCE:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

L9FD7:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

L9FE0:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

L9FEB:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FF3:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FFB:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA003:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA00B:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA013:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA01B:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA023:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA02B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA033:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA041:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA051:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA05B:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA063:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA06B:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA073:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA07B:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA083:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA08B:  .byte $20, $02, $04, $FC, $FF

LA090:  .byte $00, $F8, $FF

LA093:  .byte $60, $02, $04, $FC, $FF

LA098:  .byte $00, $F8, $FF

LA09B:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA0A3:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA0AB:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA0B3:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA0BB:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA0C3:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA0CB:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA0D3:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA0DB:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA0E3:  .byte $00, $04, $04, $8A, $FF

LA0E8:  .byte $00, $04, $04, $8A, $FF

LA0ED:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA0F7:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA101:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA111:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA121:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA131:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA141:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA14B:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

.include kraid/palettes.asm

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include kraid/room_ptrs.asm

StrctPtrTbl:
.include kraid/structure_ptrs.asm

;-----------------------------------[ Special items table ]-----------------------------------------

SpecItmsTbl:
.include kraid/items.asm

;-----------------------------------------[ Room definitions ]---------------------------------------

.include kraid/rooms.asm

;---------------------------------------[ Structure definitions ]------------------------------------

.include kraid/structures.asm

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAC32:  .byte $F1, $F1, $F1, $F1
LAC36:  .byte $FF, $FF, $F0, $F0
LAC3A:  .byte $64, $64, $64, $64
LAC3E:  .byte $FF, $FF, $64, $64
LAC42:  .byte $A4, $FF, $A4, $FF
LAC46:  .byte $FF, $A5, $FF, $A5
LAC4A:  .byte $A0, $A0, $A0, $A0
LAC4E:  .byte $A1, $A1, $A1, $A1
LAC52:  .byte $4F, $4F, $4F, $4F
LAC56:  .byte $84, $85, $86, $87
LAC5A:  .byte $88, $89, $8A, $8B
LAC5E:  .byte $80, $81, $82, $83
LAC62:  .byte $FF, $FF, $BA, $BA
LAC66:  .byte $BB, $BB, $BB, $BB
LAC6A:  .byte $10, $11, $12, $13
LAC6E:  .byte $04, $05, $06, $07
LAC72:  .byte $14, $15, $16, $17
LAC76:  .byte $1C, $1D, $1E, $1F
LAC7A:  .byte $09, $09, $09, $09
LAC7E:  .byte $0C, $0D, $0E, $0F
LAC82:  .byte $FF, $FF, $59, $5A
LAC86:  .byte $FF, $FF, $5A, $5B
LAC8A:  .byte $51, $52, $53, $54
LAC8E:  .byte $55, $56, $57, $58
LAC92:  .byte $EC, $FF, $ED, $FF
LAC96:  .byte $FF, $EE, $FF, $EF
LAC9A:  .byte $45, $46, $45, $46
LAC9E:  .byte $4B, $4C, $4D, $50
LACA2:  .byte $FF, $FF, $FF, $FF
LACA6:  .byte $47, $48, $47, $48
LACAA:  .byte $08, $08, $08, $08
LACAE:  .byte $70, $71, $72, $73
LACB2:  .byte $74, $75, $76, $77
LACB6:  .byte $E0, $E1, $E2, $E3
LACBA:  .byte $E4, $E5, $E6, $E7
LACBE:  .byte $20, $21, $22, $23
LACC2:  .byte $25, $25, $24, $24
LACC6:  .byte $78, $79, $7A, $7B
LACCA:  .byte $E8, $E9, $EA, $EB
LACCE:  .byte $26, $27, $28, $29
LACD2:  .byte $2A, $2B, $2C, $2D

;Not used.
LACD6:  .byte $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15
LACE6:  .byte $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F
LACF6:  .byte $0D, $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21
LAD06:  .byte $1C, $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C
LAD16:  .byte $1C, $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF
LAD26:  .byte $02, $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01
LAD36:  .byte $21, $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22
LAD46:  .byte $22, $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21
LAD56:  .byte $11, $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF
LAD66:  .byte $01, $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D
LAD76:  .byte $22, $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21
LAD86:  .byte $08, $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22
LAD96:  .byte $20, $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17
LADA6:  .byte $17, $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08
LADB6:  .byte $18, $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C
LADC6:  .byte $1F, $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18
LADD6:  .byte $18, $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07
LADE6:  .byte $0D, $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07
LADF6:  .byte $0D, $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A
LAE06:  .byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01
LAE16:  .byte $18, $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14
LAE26:  .byte $04, $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF
LAE36:  .byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
LAE46:  .byte $0E, $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF
LAE56:  .byte $FF, $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F
LAE66:  .byte $4F, $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10
LAE76:  .byte $11, $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C
LAE86:  .byte $1D, $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A
LAE96:  .byte $2C, $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28
LAEA6:  .byte $28, $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B
LAEB6:  .byte $2B, $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D
LAEC6:  .byte $3E, $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B
LAED6:  .byte $0B, $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56
LAEE6:  .byte $57, $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D
LAEF6:  .byte $62, $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F
LAF06:  .byte $70, $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49
LAF16:  .byte $4A, $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18
LAF26:  .byte $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D
LAF36:  .byte $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33
LAF46:  .byte $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B
LAF56:  .byte $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89
LAF66:  .byte $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8
LAF76:  .byte $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14
LAF86:  .byte $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13
LAF96:  .byte $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF
LAFA6:  .byte $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF
LAFB6:  .byte $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C
LAFC6:  .byte $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12
LAFD6:  .byte $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00
LAFE6:  .byte $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $20, $20
LAFF6:  .byte $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

;------------------------------------------[ Area music data ]---------------------------------------

; Ridley Music Data
.include ridley/music.asm

; Kraid Music Data
.include kraid/music.asm

;Not used.
LB0E7:  .byte $2A, $2A, $2A, $B9, $2A, $2A, $2A, $B2, $2A, $2A, $2A, $2A, $2A, $B9, $2A, $12
LB0F7:  .byte $2A, $B2, $26, $B9, $0E, $26, $26, $B2, $26, $B9, $0E, $26, $26, $B2, $22, $B9
LB107:  .byte $0A, $22, $22, $B2, $22, $B9, $0A, $22, $22, $B2, $20, $20, $B9, $20, $20, $20
LB117:  .byte $B2, $20, $B9, $34, $30, $34, $38, $34, $38, $3A, $38, $3A, $3E, $3A, $3E, $FF
LB127:  .byte $C2, $B2, $18, $30, $18, $30, $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2
LB137:  .byte $22, $20, $1C, $18, $16, $14, $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $B2
LB147:  .byte $2A, $28, $28, $B9, $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $26
LB157:  .byte $26, $3E, $FF, $F0, $B2, $01, $04, $01, $04, $FF, $E0, $BA, $2A, $1A, $02, $3A
LB167:  .byte $40, $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C
LB177:  .byte $38, $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A
LB187:  .byte $4C, $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF
LB197:  .byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $2B, $3B, $1B, $5A, $D0, $D1, $C3
LB1A7:  .byte $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF
LB1B7:  .byte $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC
LB1C7:  .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
LB1D7:  .byte $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03
LB1E7:  .byte $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18
LB1F7:  .byte $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include reset.asm

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.org $BFFA, $FF
LBFFA:  .word NMI                       ;($C0D9)NMI vector.
LBFFC:  .word RESET                     ;($FFB0)Reset vector.
LBFFE:  .word RESET                     ;($FFB0)IRQ vector.
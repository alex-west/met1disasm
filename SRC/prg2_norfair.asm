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

;Norfair (memory page 2)

.org $8000

.include "MetroidDefines.txt"

BANK = 2

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

;Norfair enemy tile patterns.
.include norfair/sprite_tiles.asm

;Tourian enemy tile patterns.
.include tourian/sprite_tiles.asm

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A178)
L9562:  .word Palette01                 ;($A19C)
L9564:  .word Palette02                 ;($A1A8)
L9566:  .word Palette03                 ;($A1A2)
L9568:  .word Palette04                 ;($A1AE)
L956A:  .word Palette05                 ;($A1B4)
L956C:  .word Palette06                 ;($A1D7)
L956E:  .word Palette06                 ;($A1D7)
L9570:  .word Palette06                 ;($A1D7)
L9572:  .word Palette06                 ;($A1D7)
L9574:  .word Palette06                 ;($A1D7)
L9576:  .word Palette06                 ;($A1D7)
L9578:  .word Palette06                 ;($A1D7)
L957A:  .word Palette06                 ;($A1D7)
L957C:  .word Palette06                 ;($A1D7)
L957E:  .word Palette06                 ;($A1D7)
L9580:  .word Palette06                 ;($A1D7)
L9582:  .word Palette06                 ;($A1D7)
L9584:  .word Palette06                 ;($A1D7)
L9586:  .word Palette06                 ;($A1D7)
L9588:  .word Palette07                 ;($A1DE)
L958A:  .word Palette08                 ;($A1E5)
L958C:  .word Palette09                 ;($A1EC)
L958E:  .word Palette0A                 ;($A1F3)
L9590:  .word Palette0B                 ;($A1FB)
L9592:  .word Palette0C                 ;($A203)
L9594:  .word Palette0D                 ;($A20B)
L9596:  .word Palette0E                 ;($A213)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A2D9)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A21B)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A277)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AEEC)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9C64)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9D64)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9D78)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9BDA)Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60 
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

L95C3:  JMP $9B9D                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $08                       ;Norfair music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $01                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $10, $05, $27, $04, $0F, $FF, $FF

L95D7:  .byte $16                       ;Samus start x coord on world map.
L95D8:  .byte $0D                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $01, $00, $03, $77, $53, $57, $55, $59, $5B, $4F, $32

L95E5:  LDA $6B02,X
L95E8:  JSR $8024

L95EB:  .word $98D3 ; 00 - swooper
L95ED:  .word $9908 ; 01 - becomes swooper?
L95EF:  .word $98C0 ; 02 - ripper
L95F1:  .word InvalidEnemy ; 03 - disappears
L95F3:  .word InvalidEnemy ; 04 - same as 3
L95F5:  .word InvalidEnemy ; 05 - same as 3
L95F7:  .word $9996 ; 06 - crawler
L95F9:  .word GametRoutine ; 07 - pipe bug
L95FB:  .word InvalidEnemy ; 08 - same as 3
L95FD:  .word InvalidEnemy ; 09 - same as 3
L95FF:  .word InvalidEnemy ; 0A - same as 3
L9601:  .word $9A64 ; 0B - lava jumper
L9603:  .word $9AD6 ; 0C - bouncy orb
L9605:  .word $9AE9 ; 0D - seahorse
L9607:  .word $9B64 ; 0E - rock launcher thing
L9609:  .word InvalidEnemy ; 0F - same as 3

L960B:  .byte $28, $28, $28, $28, $30, $30, $00, $00, $00, $00, $00, $00, $75, $75, $84, $82
L961B:  .byte $00, $00, $11, $11, $13, $18, $35, $35, $41, $41, $4B, $4B, $00, $00, $00, $00

EnemyHitPointTbl:
L962B:  .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86
L964B:  .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00

L965B:  .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C
L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00

L967B:  .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00

L96BB:  .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $12, $14, $00, $00, $00, $00, $02, $02, $00, $04, $06, $09, $0E, $10, $12, $00

EnemyMovementPtrs:
L96DB:  .word $97E7, $97E7, $97E7, $97E7, $97E7, $97EA, $97ED, $97ED
L96EB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L96FB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L970B:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L971B:  .word $97ED, $97ED, $97ED, $97ED

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01
L9773:  .byte $01, $00, $01, $01, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $4D, $4D, $53, $57, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8 

L97A7:  .word $97F7, $9806, $9815, $9824, $9B9E, $9BA3, $9BA8, $9BAD
L97B7:  .word $9BB2, $9BB7, $9BBC, $9BC1, $9BC6, $9BCB, $9BD0, $9BD5
L97C7:  .word $9BDA, $9BDA, $9BDA, $9BDA, $9BDA

L97D1:  .byte $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03, $00, $01, $02, $03, $00, $10
L97E1:  .byte $00, $11, $00, $00, $00, $01

L97E7:  .byte $01, $03, $FF

L97EA:  .byte $01, $0B, $FF

L97ED:  .byte $14, $90, $0A, $00, $FD, $30, $00, $14, $10, $FA

L97F7:  .byte $0A, $D3, $07, $B3, $07, $93, $07, $03, $07, $13, $07, $23, $50, $33, $FF

L9806:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9815:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9824:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

;-------------------------------------------------------------------------------
InvalidEnemy:
L9833:  LDA #$00
L9835:  STA EnStatus,X
L9838:  RTS

L9839:  LDA $81
L983B:  CMP #$01
L983D:  BEQ $9848
L983F:  CMP #$03
L9841:  BEQ $984D
L9843:  LDA $00
L9845:  JMP $8000
L9848:  LDA $01
L984A:  JMP $8003
L984D:  JMP $8006

;-------------------------------------------------------------------------------
GametRoutine: ; L9850
.include enemies/pipe_bug.asm

;-------------------------------------------------------------------------------
; Ripper routine
L98C0:  LDA EnStatus,X
L98C3:  CMP #$03
L98C5:  BEQ L98CA
L98C7:  JSR $801E
L98CA:  LDA #$03
L98CC:  STA $00
L98CE:  STA $01
L98D0:  JMP $9839

;-------------------------------------------------------------------------------
; Swooper routine
L98D3:  LDA #$03
L98D5:  STA $00
L98D7:  LDA #$08
L98D9:  STA $01
L98DB:  LDA EnStatus,X
L98DE:  CMP #$01
L98E0:  BNE $98EE
L98E2:  LDA $0405,X
L98E5:  AND #$10
L98E7:  BEQ $98EE
L98E9:  LDA #$01
L98EB:  JSR $9954
L98EE:  JSR $98F4
L98F1:  JMP $9839
L98F4:  LDA EnStatus,X
L98F7:  CMP #$02
L98F9:  BNE $9907
L98FB:  LDA #$25
L98FD:  LDY $0402,X
L9900:  BPL $9904
L9902:  LDA #$22
L9904:  STA $6AF9,X
L9907:  RTS

;-------------------------------------------------------------------------------
; Swooper Routine 2?
L9908:  LDA $81
L990A:  CMP #$01
L990C:  BEQ $991E
L990E:  CMP #$03
L9910:  BEQ $9951
L9912:  LDA EnStatus,X
L9915:  CMP #$01
L9917:  BNE $9923
L9919:  LDA #$00
L991B:  JSR $9954
L991E:  LDA #$08
L9920:  JMP $8003
L9923:  LDA #$80
L9925:  STA $6AFE,X
L9928:  LDA $0402,X
L992B:  BMI $9949
L992D:  LDA $0405,X
L9930:  AND #$10
L9932:  BEQ $9949
L9934:  LDA $0400,X
L9937:  SEC 
L9938:  SBC $030D
L993B:  BPL $9940
L993D:  JSR $95C6
L9940:  CMP #$10
L9942:  BCS $9949
L9944:  LDA #$00
L9946:  STA $6AFE,X
L9949:  JSR $98F4
L994C:  LDA #$03
L994E:  JMP $8000
L9951:  JMP $8006
L9954:  STA $6B02,X
L9957:  LDA $040B,X
L995A:  PHA 
L995B:  JSR $802A
L995E:  PLA 
L995F:  STA $040B,X
L9962:  RTS

L9963:  JSR $801B
L9966:  LDA #$06
L9968:  STA $00
L996A:  JMP $9839
L996D:  JSR $801B
L9970:  LDA #$06
L9972:  STA $00
L9974:  JMP $9839
L9977:  JSR $801B
L997A:  LDA #$06
L997C:  STA $00
L997E:  LDA $81
L9980:  CMP #$02
L9982:  BNE $9993
L9984:  CMP EnStatus,X
L9987:  BNE $9993
L9989:  JSR $8009
L998C:  AND #$03
L998E:  BNE $9993
L9990:  JMP $984D
L9993:  JMP $9839

;-------------------------------------------------------------------------------
; Crawler Routine
L9996:  JSR $8009
L9999:  AND #$03
L999B:  BEQ $99D1
L999D:  LDA $81
L999F:  CMP #$01
L99A1:  BEQ $99D9
L99A3:  CMP #$03
L99A5:  BEQ $99D6
L99A7:  LDA EnStatus,X
L99AA:  CMP #$03
L99AC:  BEQ $99D1
L99AE:  LDA $040A,X
L99B1:  AND #$03
L99B3:  CMP #$01
L99B5:  BNE $99C8
L99B7:  LDY $0400,X
L99BA:  CPY #$EB
L99BC:  BNE $99C8
L99BE:  JSR $9A0A
L99C1:  LDA #$03
L99C3:  STA $040A,X
L99C6:  BNE $99CE
L99C8:  JSR $9A2F
L99CB:  JSR $99F5
L99CE:  JSR $9A13
L99D1:  LDA #$03
L99D3:  JSR $800C
L99D6:  JMP $8006
L99D9:  JMP $8003
L99DC:  LDA $0405,X
L99DF:  LSR 
L99E0:  LDA $040A,X
L99E3:  AND #$03
L99E5:  ROL 
L99E6:  TAY 
L99E7:  LDA $99ED,Y
L99EA:  JMP $800F

L99ED:  .byte $69, $69, $72, $6C, $6F, $6F, $6C, $72

L99F5:  LDX $4B
L99F7:  BCS $9A12
L99F9:  LDA $00
L99FB:  BNE $9A0A
L99FD:  LDY $040A,X
L9A00:  DEY 
L9A01:  TYA 
L9A02:  AND #$03
L9A04:  STA $040A,X
L9A07:  JMP $99DC
L9A0A:  LDA $0405,X
L9A0D:  EOR #$01
L9A0F:  STA $0405,X
L9A12:  RTS

L9A13:  JSR $9A27
L9A16:  JSR $9A2F
L9A19:  LDX $4B
L9A1B:  BCC $9A26
L9A1D:  JSR $9A27
L9A20:  STA $040A,X
L9A23:  JSR $99DC
L9A26:  RTS

L9A27:  LDY $040A,X
L9A2A:  INY 
L9A2B:  TYA 
L9A2C:  AND #$03
L9A2E:  RTS

L9A2F:  LDY $0405,X
L9A32:  STY $00
L9A34:  LSR $00
L9A36:  ROL 
L9A37:  ASL 
L9A38:  TAY 
L9A39:  LDA $8049,Y
L9A3C:  PHA 
L9A3D:  LDA $8048,Y
L9A40:  PHA 
L9A41:  RTS

StorePositionToTemp:
L9A42:  LDA EnYRoomPos,X
L9A45:  STA $08
L9A47:  LDA EnXRoomPos,X
L9A4A:  STA $09
L9A4C:  LDA EnNameTable,X
L9A4F:  STA $0B
L9A51:  RTS

LoadPositionFromTemp:
L9A52:  LDA $0B
L9A54:  AND #$01
L9A56:  STA EnNameTable,X
L9A59:  LDA $08
L9A5B:  STA EnYRoomPos,X
L9A5E:  LDA $09
L9A60:  STA EnXRoomPos,X
L9A63:  RTS

;-------------------------------------------------------------------------------
; Lava Jumper Routine
L9A64:  LDA $81
L9A66:  CMP #$01
L9A68:  BNE $9A88
L9A6A:  LDA EnStatus,X
L9A6D:  CMP #$03
L9A6F:  BEQ $9ACA
L9A71:  CMP #$02
L9A73:  BNE $9A88
L9A75:  LDY $0408,X
L9A78:  LDA $9AD2,Y
L9A7B:  STA $0402,X
L9A7E:  LDA #$40
L9A80:  STA $6AFE,X
L9A83:  LDA #$00
L9A85:  STA $0406,X
L9A88:  LDA EnStatus,X
L9A8B:  CMP #$03
L9A8D:  BEQ $9ACA
L9A8F:  LDA $81
L9A91:  CMP #$01
L9A93:  BEQ $9ACA
L9A95:  CMP #$03
L9A97:  BEQ $9ACF
L9A99:  JSR $8036
L9A9C:  LDX $4B
L9A9E:  LDA #$00
L9AA0:  STA $05
L9AA2:  LDA #$1D
L9AA4:  LDY $00
L9AA6:  STY $04
L9AA8:  BMI $9AAC
L9AAA:  LDA #$20
L9AAC:  STA $6AF9,X
L9AAF:  JSR StorePositionToTemp
L9AB2:  JSR $8027
L9AB5:  LDA #$E8
L9AB7:  BCC $9ABD
L9AB9:  CMP $08
L9ABB:  BCS $9AC7
L9ABD:  STA $08
L9ABF:  LDA $0405,X
L9AC2:  ORA #$20
L9AC4:  STA $0405,X
L9AC7:  JSR LoadPositionFromTemp
L9ACA:  LDA #$02
L9ACC:  JMP $8003
L9ACF:  JMP $8006
L9AD2:  INC $F8,X
L9AD4:  INC $FA,X

;-------------------------------------------------------------------------------
; Bouncy Orb Routine (Multiviola?)
L9AD6:  LDA EnStatus,X
L9AD9:  CMP #$02
L9ADB:  BNE $9AE0
L9ADD:  JSR $801E
L9AE0:  LDA #$02
L9AE2:  STA $00
L9AE4:  STA $01
L9AE6:  JMP $9839

;-------------------------------------------------------------------------------
; Lava Seahorse Routine
L9AE9:  LDA EnStatus,X
L9AEC:  CMP #$01
L9AEE:  BNE $9AF5
L9AF0:  LDA #$E8
L9AF2:  STA $0400,X
L9AF5:  CMP #$02
L9AF7:  BNE $9B4F
L9AF9:  LDA $0406,X
L9AFC:  BEQ $9B4F
L9AFE:  LDA $6B01,X
L9B01:  BNE $9B4F
L9B03:  LDA $2D
L9B05:  AND #$1F
L9B07:  BNE $9B3C
L9B09:  LDA $2E
L9B0B:  AND #$03
L9B0D:  BEQ $9B59
L9B0F:  LDA #$02
L9B11:  STA $87
L9B13:  LDA #$00
L9B15:  STA $88
L9B17:  LDA #$43
L9B19:  STA $83
L9B1B:  LDA #$47
L9B1D:  STA $84
L9B1F:  LDA #$03
L9B21:  STA $85
L9B23:  JSR $8021
L9B26:  LDA $0680
L9B29:  ORA #$04
L9B2B:  STA $0680
L9B2E:  LDA $0405,X
L9B31:  AND #$01
L9B33:  TAY 
L9B34:  LDA $0083,Y
L9B37:  JSR $800F
L9B3A:  BEQ $9B59
L9B3C:  CMP #$0F
L9B3E:  BCC $9B59
L9B40:  LDA $0405,X
L9B43:  AND #$01
L9B45:  TAY 
L9B46:  LDA $9B62,Y
L9B49:  JSR $800F
L9B4C:  JMP $9B59
L9B4F:  LDA EnStatus,X
L9B52:  CMP #$03
L9B54:  BEQ $9B59
L9B56:  JSR $801E
L9B59:  LDA #$01
L9B5B:  STA $00
L9B5D:  STA $01
L9B5F:  JMP $9839
L9B62:  EOR $49

;-------------------------------------------------------------------------------
; Polyp Routine (mini volcano)
L9B64:  LDA #$00
L9B66:  STA $6AF5,X
L9B69:  STA $6AF6,X
L9B6C:  LDA #$10
L9B6E:  STA $0405,X
L9B71:  TXA 
L9B72:  ASL 
L9B73:  ASL 
L9B74:  STA $00
L9B76:  TXA 
L9B77:  LSR 
L9B78:  LSR 
L9B79:  LSR 
L9B7A:  LSR 
L9B7B:  ADC $2D
L9B7D:  ADC $00
L9B7F:  AND #$47
L9B81:  BNE $9B9D
L9B83:  LSR $0405,X
L9B86:  LDA #$03
L9B88:  STA $87
L9B8A:  LDA $2E
L9B8C:  LSR 
L9B8D:  ROL $0405,X
L9B90:  AND #$03
L9B92:  BEQ $9B9D
L9B94:  STA $88
L9B96:  LDA #$02
L9B98:  STA $85
L9B9A:  JMP $8021
L9B9D:  RTS

L9B9E:  .byte $22, $FF, $FF, $FF, $FF

L9BA3:  .byte $22, $80, $81, $82, $83

L9BA8:  .byte $22, $84, $85, $86, $87

L9BAD:  .byte $22, $88, $89, $8A, $8B

L9BB2:  .byte $22, $8C, $8D, $8E, $8F

L9BB7:  .byte $22, $94, $95, $96, $97

L9BBC:  .byte $22, $9C, $9D, $9D, $9C

L9BC1:  .byte $22, $9E, $9F, $9F, $9E

L9BC6:  .byte $22, $90, $91, $92, $93

L9BCB:  .byte $22, $70, $71, $72, $73

L9BD0:  .byte $22, $74, $75, $75, $74

L9BD5:  .byte $22, $76, $76, $76, $76

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9BDA:  .byte $00, $01, $FF

L9BDD:  .byte $02, $FF

L9BDF:  .byte $03, $04, $FF

L9BE2:  .byte $07, $08, $FF

L9BE5:  .byte $05, $06, $FF

L9BE8:  .byte $09, $0A, $FF

L9BEB:  .byte $0B, $FF

L9BED:  .byte $0C, $0D, $0E, $0F, $FF

L9BF2:  .byte $10, $11, $12, $13, $FF

L9BF7:  .byte $15, $14, $FF

L9BFA:  .byte $16, $FF

L9BFC:  .byte $17, $18, $FF

L9BFF:  .byte $19, $1A, $FF

L9C02:  .byte $1B, $FF

L9C04:  .byte $1C, $1D, $FF

L9C07:  .byte $1E, $1F, $FF

L9C0A:  .byte $20, $FF

L9C0C:  .byte $21, $22, $FF

L9C0F:  .byte $23, $FF

L9C11:  .byte $27, $28, $29, $2A, $FF

L9C16:  .byte $2B, $2C, $2D, $2E, $FF

L9C1B:  .byte $2F, $FF

L9C1D:  .byte $30, $FF

L9C1F:  .byte $31, $FF

L9C21:  .byte $32, $FF

L9C23:  .byte $33, $FF

L9C25:  .byte $34, $FF

L9C27:  .byte $42, $FF

L9C29:  .byte $43, $44, $F7, $FF

L9C2D:  .byte $3B, $FF

L9C2F:  .byte $3C, $FF

L9C31:  .byte $3D, $FF, $3E, $FF

L9C35:  .byte $3F, $3F, $3F, $3F, $3F, $41, $41, $41, $41, $40, $40, $40, $F7, $FF

L9C43:  .byte $58, $59, $FF

L9C46:  .byte $5A, $5B, $FF

L9C49:  .byte $5C, $5D, $FF

L9C4C:  .byte $5E, $5F, $FF

L9C4F:  .byte $60, $FF

L9C51:  .byte $61, $F7, $62, $F7, $FF

L9C56:  .byte $66, $67, $FF

L9C59:  .byte $69, $6A, $FF

L9C5C:  .byte $68, $FF

L9C5E:  .byte $6B, $FF

L9C60:  .byte $66, $FF

L9C62:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9C64:  .word $9E0A, $9E0F, $9E14, $9E19, $9E2C, $9E40, $9E56, $9E6C
L9C74:  .word $9E7F, $9E93, $9EA9, $9EBF, $9EC9, $9ECE, $9ED3, $9ED8
L9C84:  .word $9EDD, $9EE2, $9EE7, $9EEC, $9EF1, $9EFF, $9F0D, $9F1B
L9C94:  .word $9F2A, $9F39, $9F4A, $9F5B, $9F63, $9F69, $9F6F, $9F75
L9CA4:  .word $9F7B, $9F81, $9F89, $9F91, $9F99, $9F99, $9F99, $9F99
L9CB4:  .word $9FA5, $9FB3, $9FC1, $9FCF, $9FDB, $9FE9, $9FF7, $A005
L9CC4:  .word $A010, $A01F, $A02E, $A03D, $A04C, $A059, $A059, $A059
L9CD4:  .word $A059, $A059, $A059, $A059, $A061, $A069, $A071, $A079
L9CE4:  .word $A081, $A089, $A093, $A098, $A0A0, $A0A8, $A0A8, $A0A8
L9CF4:  .word $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8
L9D04:  .word $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8
L9D14:  .word $A0A8, $A0B4, $A0C0, $A0CC, $A0D8, $A0E4, $A0F0, $A0FC
L9D24:  .word $A108, $A110, $A11E, $A138, $A138, $A138, $A138, $A140
L9D34:  .word $A148, $A150, $A158, $A160, $A168, $A168, $A168, $A168
L9D44:  .word $A168, $A168, $A168, $A168, $A168, $A168, $A168, $A168
L9D54:  .word $A168, $A168, $A168, $A168, $A168, $A168, $A168, $A168

EnemyFramePtrTbl2:
L9D64:  .word $A168, $A16E, $A173, $A173, $A173, $A173, $A173, $A173
L9D74:  .word $A173, $A173

EnemyPlacePtrTbl:
L9D78:  .word $9D94, $9D96, $9DAE, $9DAE, $9DC0, $9DB2, $9DBC, $9DC4
L9D88:  .word $9DD0, $9DD8, $9DD8, $9DF8, $9E06, $9E0A

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D94:  .byte $FC, $FC

L9D96:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9DA6:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9DAE:  .byte $F4, $F4, $F4, $04

L9DB2:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9DBC:  .byte $FC, $F8, $FC, $00

L9DC0:  .byte $F0, $F8, $F0, $00

L9DC4:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9DD0:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9DD8:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9DE8:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DF8:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9E06:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

L9E0A:  .byte $00, $02, $02, $14, $FF

L9E0F:  .byte $00, $02, $02, $24, $FF

L9E14:  .byte $00, $00, $00, $04, $FF

L9E19:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E29:  .byte $F9, $F8, $FF

L9E2C:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E3C:  .byte $D8, $FE, $E8, $FF

L9E40:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E50:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E56:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E66:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E6C:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E7C:  .byte $F9, $F8, $FF

L9E7F:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E8F:  .byte $D8, $FE, $E8, $FF

L9E93:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EA3:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9EA9:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EB9:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9EBF:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9EC9:  .byte $20, $04, $04, $EC, $FF

L9ECE:  .byte $20, $04, $04, $FB, $FF

L9ED3:  .byte $E0, $04, $04, $EC, $FF

L9ED8:  .byte $E0, $04, $04, $FB, $FF

L9EDD:  .byte $60, $04, $04, $EC, $FF

L9EE2:  .byte $60, $04, $04, $FB, $FF

L9EE7:  .byte $A0, $04, $04, $EC, $FF

L9EEC:  .byte $A0, $04, $04, $FB, $FF

L9EF1:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FB, $FD, $62, $FB, $FF

L9EFF:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FA, $FD, $62, $FA, $FF

L9F0D:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $EB, $FD, $62, $EB, $FF

L9F1B:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9F2A:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9F39:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9F49:  .byte $FF

L9F4A:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9F5A:  .byte $FF

L9F5B:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F63:  .byte $39, $04, $08, $F6, $F7, $FF

L9F69:  .byte $39, $04, $08, $E7, $F7, $FF

L9F6F:  .byte $79, $04, $08, $F6, $F7, $FF

L9F75:  .byte $79, $04, $08, $E7, $F7, $FF

L9F7B:  .byte $31, $00, $00, $F6, $F7, $FF

L9F81:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F89:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF

L9F91:  .byte $21, $00, $00, $EA, $EA, $EB, $EB, $FF

L9F99:  .byte $27, $08, $08, $EE, $EF, $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9FA5:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9FB3:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9FC1:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9FCF:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9FDB:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9FE9:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9FF7:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

LA005:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

LA010:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA01F:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA02E:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA03D:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA04C:  .byte $21, $00, $00, $FC, $FC, $00, $C8, $C9, $D8, $D9, $E8, $E9, $FF

LA059:  .byte $37, $04, $04, $E0, $E1, $F0, $F1, $FF

LA061:  .byte $B7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA069:  .byte $77, $04, $04, $E0, $E1, $F0, $F1, $FF

LA071:  .byte $F7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA079:  .byte $37, $00, $00, $E2, $FD, $63, $E2, $FF

LA081:  .byte $38, $00, $00, $E2, $FD, $62, $E2, $FF

LA089:  .byte $38, $00, $00, $FE, $FE, $E2, $FD, $62, $E2, $FF

LA093:  .byte $30, $04, $04, $C0, $FF

LA098:  .byte $30, $00, $00, $FC, $F8, $00, $D0, $FF

LA0A0:  .byte $33, $00, $00, $D1, $FD, $63, $D1, $FF

LA0A8:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA0B4:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA0C0:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA0CC:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA0D8:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA0E4:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA0F0:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA0FC:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA108:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA110:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA11E:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA12E:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA138:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA140:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA148:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA150:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA158:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA160:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA168:  .byte $0C, $08, $04, $14, $24, $FF

LA16E:  .byte $00, $04, $04, $8A, $FF

LA173:  .byte $00, $04, $04, $8A, $FF

;-----------------------------------------[ Palette data ]-------------------------------------------

.include norfair/palettes.asm

;--------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include norfair/room_ptrs.asm

StrctPtrTbl:
.include norfair/structure_ptrs.asm

;---------------------------------[ Special items table ]-----------------------------------------

include norfair/items.asm

;-----------------------------------------[ Room definitions ]---------------------------------------

.include norfair/rooms.asm

;---------------------------------------[ Structure definitions ]------------------------------------

.include norfair/structures.asm

;----------------------------------------[ Macro definitions ]---------------------------------------

MacroDefs:
.include norfair/metatiles.asm

;------------------------------------------[ Area music data ]---------------------------------------

.include norfair/music.asm

;Unused.
B099:   .byte $B9, $30, $3A, $3E, $B6, $42, $B9, $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A
B0A9:   .byte $44, $48, $B4, $4C, $B3, $48, $46, $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2
B0B9:   .byte $44, $B9, $44, $4C, $52, $B4, $54, $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9
B0C9:   .byte $26, $3E, $34, $B2, $26, $B9, $26, $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2
B0D9:   .byte $2C, $B9, $2C, $3A, $2C, $FF, $C4, $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9
B0E9:   .byte $18, $26, $18, $B2, $18, $FF, $C2, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9
B0F9:   .byte $1E, $18, $1E, $B2, $1C, $B9, $1C, $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF
B109:   .byte $B2, $26, $12, $16, $18, $1C, $20, $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2
B119:   .byte $10, $B9, $30, $2C, $28, $B2, $1E, $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9 
B129:   .byte $2A, $FF, $E8, $B2, $04, $04, $04, $B9, $04, $04, $04, $FF, $E0, $E0, $F0, $00
B139:   .byte $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05, $26, $52, $63, $00
B149:   .byte $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B, $8D, $A7, $B1, $00
B159:   .byte $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0, $F0, $F8, $FC, $00
B169:   .byte $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07, $03, $03, $01, $00
B179:   .byte $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7, $CF, $FE, $EC, $00
B189:   .byte $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9, $1E, $0E, $44, $07
B199:   .byte $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B
B1A9:   .byte $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF, $C7, $00
B1B9:   .byte $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00
B1C9:   .byte $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $80
B1D9:   .byte $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A
B1E9:   .byte $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8
B1F9:   .byte $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include reset.asm

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.org $BFFA, $FF
LBFFA:  .word NMI                       ;($C0D9)NMI vector.
LBFFC:  .word RESET                     ;($FFB0)Reset vector.
LBFFE:  .word RESET                     ;($FFB0)IRQ vector.
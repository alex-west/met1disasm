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

;Tourian (memory page 3)

.org $8000

.include "MetroidDefines.txt"

BANK = 3

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

;Kraid hideout enemy tile patterns.
.include kraid/sprite_tiles.asm

;Ridley hideout enemy tile patterns.
.include ridley/sprite_tiles.asm

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A718)
L9562:  .word Palette01                 ;($A73C)
L9564:  .word Palette02                 ;($A748)
L9566:  .word Palette03                 ;($A742)
L9568:  .word Palette04                 ;($A74E)
L956A:  .word Palette05                 ;($A754)
L956C:  .word Palette05                 ;($A754)
L956E:  .word Palette06                 ;($A759)
L9570:  .word Palette07                 ;($A75E)
L9572:  .word Palette08                 ;($A773)
L9574:  .word Palette09                 ;($A788)
L9576:  .word Palette0A                 ;($A78D)
L9578:  .word Palette0A                 ;($A78D)
L957A:  .word Palette0A                 ;($A78D)
L957C:  .word Palette0A                 ;($A78D)
L957E:  .word Palette0A                 ;($A78D)
L9580:  .word Palette0A                 ;($A78D)
L9582:  .word Palette0A                 ;($A78D)
L9584:  .word Palette0A                 ;($A78D)
L9586:  .word Palette0A                 ;($A78D)
L9588:  .word Palette0B                 ;($A794)
L958A:  .word Palette0C                 ;($A79B)
L958C:  .word Palette0D                 ;($A7A2)
L958E:  .word Palette0E                 ;($A7A9)
L9590:  .word Palette0F                 ;($A7B1)
L9592:  .word Palette10                 ;($A7B9)
L9594:  .word Palette11                 ;($A7C1)
L9596:  .word Palette12                 ;($A7C9)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A83B)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A7D1)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A7FB)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AE49)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($A42C)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($A52C)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($A540)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($A406)Index to values in addr tables for enemy animations.

; Special Tourian Routines
L95A8:  JMP $A320 
L95AB:  JMP $A315
L95AE:  JMP $9C6F
TourianCannonHandler:
L95B1:  JMP $9CE6
TourianMotherBrainHandler:
L95B4:  JMP $9D21
TourianZebetiteHandler:
L95B7:  JMP $9D3D
TourianRinkaHandler:
L95BA:  JMP $9D6C
L95BD:  JMP $A0C6
L95C0:  JMP $A142

AreaRoutine:
L95C3:  JMP L9B25                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
Exit__:
L95CB:  RTS                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $40                       ;Tourian music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $03                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $03                       ;Samus start x coord on world map.
L95D8:  .byte $04                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $21, $00, $00, $00, $00, $00, $10, $00

; Enemy AI Jump Table
L95E5:  LDA $6B02,X
L95E8:  JSR $8024

L95EB:  .word $97F9 ; 00 - metroid
L95ED:  .word $97F9 ; 01 - same as 0
L95EF:  .word $9A27 ; 02 - i dunno but it takes 30 damage with varia
L95F1:  .word $97DC ; 03 - disappears
L95F3:  .word $9A2C ; 04 - rinka ?
L95F5:  .word $97DC ; 05 - same as 3
L95F7:  .word $97DC ; 06 - same as 3
L95F9:  .word $97DC ; 07 - same as 3
L95FB:  .word $97DC ; 08 - same as 3
L95FD:  .word $97DC ; 09 - same as 3
L95FF:  .word $97DC ; 0A - same as 3
L9601:  .word $97DC ; 0B - same as 3
L9603:  .word $97DC ; 0C - same as 3
L9605:  .word $97DC ; 0D - same as 3
L9607:  .word $97DC ; 0E - same as 3
L9609:  .word $97DC ; 0F - same as 3


L960B:  .byte $08, $08, $08, $08, $16, $16, $18, $18, $1F, $1F, $00, $00, $00, $00, $00, $00

L961B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L962B:  .byte $FF, $FF, $01, $FF, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1B, $1B, $00, $00, $00, $00, $00, $00

L964B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1D, $1D, $00, $00, $00, $00, $00, $00

L966B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L968B:  .byte $FE, $FE, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L969B:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96AB:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96CB:  .byte $00, $02, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyMovementPtrs:
L96DB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L96EB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L96FB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L970B:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L971B:  .word $97D5, $97D5, $97D5, $97D5

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $C0, $D0, $00, $00, $7F
L9733:  .byte $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $50, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L978B:  .byte $00, $00, $26, $26, $26, $26, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $97D5, $97D5, $97D8, $97DB, $A32B, $A330, $A337, $A348
L97B7:  .word $A359, $A36A, $A37B, $A388, $A391, $A3A2, $A3B3, $A3C4
L97C7:  .word $A3D5, $A3DE, $A3E7, $A3F0, $A3F9

L97D1:  .byte $00, $00, $00, $01

L97D5:  .byte $50, $22, $FF

L97D8:  .byte $50, $30, $FF

L97DB:  .byte $FF

L97DC:  LDA #$00
L97DE:  STA $6AF4,X
L97E1:  RTS

L97E2:  LDA $81
L97E4:  CMP #$01
L97E6:  BEQ $97F1
L97E8:  CMP #$03
L97EA:  BEQ $97F6
L97EC:  LDA $00
L97EE:  JMP $8000
L97F1:  LDA $01
L97F3:  JMP $8003
L97F6:  JMP $8006

;-------------------------------------------------------------------------------
; Metroid Routine
L97F9:  LDY $010B
L97FC:  INY 
L97FD:  BEQ $9804
L97FF:  LDA #$00
L9801:  STA $6AF4,X
L9804:  LDA #$0F
L9806:  STA $00
L9808:  STA $01
L980A:  LDA $0405,X
L980D:  ASL 
L980E:  BMI $97E2
L9810:  LDA $6AF4,X
L9813:  CMP #$03
L9815:  BEQ $97E2
L9817:  JSR $99B7
L981A:  LDA $77F8,Y
L981D:  BEQ $9822
L981F:  JMP $9899
L9822:  LDY $0408,X
L9825:  LDA $77F6,Y
L9828:  PHA 
L9829:  LDA $0402,X
L982C:  BPL $983B
L982E:  PLA 
L982F:  JSR $95C6
L9832:  PHA 
L9833:  LDA #$00
L9835:  CMP $0406,X
L9838:  SBC $0402,X
L983B:  CMP $77F6,Y
L983E:  PLA 
L983F:  BCC $9849
L9841:  STA $0402,X
L9844:  LDA #$00
L9846:  STA $0406,X
L9849:  LDA $77F6,Y
L984C:  PHA 
L984D:  LDA $0403,X
L9850:  BPL $985F
L9852:  PLA 
L9853:  JSR $95C6
L9856:  PHA 
L9857:  LDA #$00
L9859:  CMP $0407,X
L985C:  SBC $0403,X
L985F:  CMP $77F6,Y
L9862:  PLA 
L9863:  BCC $986D
L9865:  STA $0403,X
L9868:  LDA #$00
L986A:  STA $0407,X
L986D:  LDA $0405,X
L9870:  PHA 
L9871:  JSR $9A06
L9874:  STA $6AFF,X
L9877:  PLA 
L9878:  LSR 
L9879:  LSR 
L987A:  JSR $9A06
L987D:  STA $6AFE,X
L9880:  LDA $6AF4,X
L9883:  CMP #$04
L9885:  BNE $9894
L9887:  LDY $040B,X
L988A:  INY 
L988B:  BNE $9899
L988D:  LDA #$05
L988F:  STA $040B,X
L9892:  BNE $9899
L9894:  LDA #$FF
L9896:  STA $040B,X
L9899:  LDA $81
L989B:  CMP #$06
L989D:  BNE $98A9
L989F:  CMP $6AF4,X
L98A2:  BEQ $98A9
L98A4:  LDA #$04
L98A6:  STA $6AF4,X
L98A9:  LDA $0404,X
L98AC:  AND #$20
L98AE:  BEQ $990F
L98B0:  JSR $99B7
L98B3:  LDA $77F8,Y
L98B6:  BEQ $98EF
L98B8:  LDA $040E,X
L98BB:  CMP #$07
L98BD:  BEQ $98C3
L98BF:  CMP #$0A
L98C1:  BNE $9932
L98C3:  LDA $2D
L98C5:  AND #$02
L98C7:  BNE $9932
L98C9:  LDA $77F8,Y
L98CC:  CLC 
L98CD:  ADC #$10
L98CF:  STA $77F8,Y
L98D2:  AND #$70
L98D4:  CMP #$50
L98D6:  BNE $9932
L98D8:  LDA #$02
L98DA:  ORA $040F,X
L98DD:  STA $040C,X
L98E0:  LDA #$06
L98E2:  STA $6AF4,X
L98E5:  LDA #$20
L98E7:  STA $040F,X
L98EA:  LDA #$01
L98EC:  STA $040D,X
L98EF:  LDA #$00
L98F1:  STA $0404,X
L98F4:  STA $77F8,Y
L98F7:  STA $0406,X
L98FA:  STA $0407,X
L98FD:  LDA $6AFE,X
L9900:  JSR $9A10
L9903:  STA $0402,X
L9906:  LDA $6AFF,X
L9909:  JSR $9A10
L990C:  STA $0403,X
L990F:  JSR $99B7
L9912:  LDA $77F8,Y
L9915:  BNE $9932
L9917:  LDA $0404,X
L991A:  AND #$04
L991C:  BEQ $9964
L991E:  LDA $0403,X
L9921:  AND #$80
L9923:  ORA #$01
L9925:  TAY 
L9926:  JSR $99C3
L9929:  JSR $99BD
L992C:  TYA 
L992D:  STA $77F8,X
L9930:  TXA 
L9931:  TAY 
L9932:  TYA 
L9933:  TAX 
L9934:  LDA $77F8,X
L9937:  PHP 
L9938:  AND #$0F
L993A:  CMP #$0C
L993C:  BEQ $9941
L993E:  INC $77F8,X
L9941:  TAY 
L9942:  LDA $99D7,Y
L9945:  STA $04
L9947:  STY $05
L9949:  LDA #$0C
L994B:  SEC 
L994C:  SBC $05
L994E:  LDX $4B
L9950:  PLP 
L9951:  BMI $9956
L9953:  JSR $95C6
L9956:  STA $05
L9958:  JSR $99E4
L995B:  JSR $8027
L995E:  JSR $99F4
L9961:  JMP $9967
L9964:  JSR $99AE
L9967:  LDA $6AF4,X
L996A:  CMP #$03
L996C:  BNE $9971
L996E:  JSR $99AE
L9971:  LDY #$00
L9973:  LDA $77F8
L9976:  ORA $77F9
L9979:  ORA $77FA
L997C:  ORA $77FB
L997F:  ORA $77FC
L9982:  ORA $77FD
L9985:  AND #$0C
L9987:  CMP #$0C
L9989:  BNE $999E
L998B:  LDA $0106
L998E:  ORA $0107
L9991:  BEQ $999E
L9993:  STY $6F
L9995:  LDY #$04
L9997:  STY $6E
L9999:  JSR $8042
L999C:  LDY #$01
L999E:  STY $92
L99A0:  LDA $6B
L99A2:  BMI $99AB
L99A4:  LDA $6B02,X
L99A7:  ORA #$A2
L99A9:  STA $6B
L99AB:  JMP $97E2
L99AE:  JSR $99B7
L99B1:  LDA #$00
L99B3:  STA $77F8,Y
L99B6:  RTS

L99B7:  TXA 
L99B8:  JSR $9B1B
L99BB:  TAY 
L99BC:  RTS 
L99BD:  TXA 
L99BE:  JSR $9B1B
L99C1:  TAX 
L99C2:  RTS

L99C3:  LDA #$00
L99C5:  STA $0402,X
L99C8:  STA $0403,X
L99CB:  STA $0407,X
L99CE:  STA $0406,X
L99D1:  STA $6AFF,X
L99D4:  STA $6AFE,X
L99D7:  RTS

L99D8:  .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8
 
L99E4:  LDA $030E
L99E7:  STA $09
L99E9:  LDA $030D
L99EC:  STA $08
L99EE:  LDA $030C
L99F1:  STA $0B
L99F3:  RTS

L99F4:  LDA $09
L99F6:  STA $0401,X
L99F9:  LDA $08
L99FB:  STA $0400,X
L99FE:  LDA $0B
L9A00:  AND #$01
L9A02:  STA $6AFB,X
L9A05:  RTS

L9A06:  LSR 
L9A07:  LDA $0408,X
L9A0A:  ROL 
L9A0B:  TAY 
L9A0C:  LDA $77F2,Y
L9A0F:  RTS

L9A10:  ASL 
L9A11:  ROL 
L9A12:  AND #$01
L9A14:  TAY 
L9A15:  LDA $77F0,Y
L9A18:  RTS

L9A19:  .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00

;-------------------------------------------------------------------------------
; ???
L9A27:  LDA #$01
L9A29:  JMP $8003

;-------------------------------------------------------------------------------
; Rinka Routine??
L9A2C:  LDY $6AF4,X
L9A2F:  CPY #$02
L9A31:  BNE $9AB0
L9A33:  DEY 
L9A34:  CPY $81
L9A36:  BNE $9AB0
L9A38:  LDA #$00
L9A3A:  JSR $99D1
L9A3D:  STA $6AFC,X
L9A40:  STA $6AFD,X
L9A43:  LDA $030E
L9A46:  SEC 
L9A47:  SBC $0401,X
L9A4A:  STA $01
L9A4C:  LDA $0405,X
L9A4F:  PHA 
L9A50:  LSR 
L9A51:  PHA 
L9A52:  BCC $9A5A
L9A54:  LDA #$00
L9A56:  SBC $01
L9A58:  STA $01
L9A5A:  LDA $030D
L9A5D:  SEC 
L9A5E:  SBC $0400,X
L9A61:  STA $00
L9A63:  PLA 
L9A64:  LSR 
L9A65:  LSR 
L9A66:  BCC $9A6E
L9A68:  LDA #$00
L9A6A:  SBC $00
L9A6C:  STA $00
L9A6E:  LDA $00
L9A70:  ORA $01
L9A72:  LDY #$03
L9A74:  ASL 
L9A75:  BCS $9A7A
L9A77:  DEY 
L9A78:  BNE $9A74
L9A7A:  DEY 
L9A7B:  BMI $9A83
L9A7D:  LSR $00
L9A7F:  LSR $01
L9A81:  BPL $9A7A
L9A83:  JSR $9AF9
L9A86:  PLA 
L9A87:  LSR 
L9A88:  PHA 
L9A89:  BCC $9A9B
L9A8B:  LDA #$00
L9A8D:  SBC $0407,X
L9A90:  STA $0407,X
L9A93:  LDA #$00
L9A95:  SBC $0403,X
L9A98:  STA $0403,X
L9A9B:  PLA 
L9A9C:  LSR 
L9A9D:  LSR 
L9A9E:  BCC $9AB0
L9AA0:  LDA #$00
L9AA2:  SBC $0406,X
L9AA5:  STA $0406,X
L9AA8:  LDA #$00
L9AAA:  SBC $0402,X
L9AAD:  STA $0402,X
L9AB0:  LDA $0405,X
L9AB3:  ASL 
L9AB4:  BMI $9AF4
L9AB6:  LDA $0406,X
L9AB9:  CLC 
L9ABA:  ADC $6AFC,X
L9ABD:  STA $6AFC,X
L9AC0:  LDA $0402,X
L9AC3:  ADC #$00
L9AC5:  STA $04
L9AC7:  LDA $0407,X
L9ACA:  CLC 
L9ACB:  ADC $6AFD,X
L9ACE:  STA $6AFD,X
L9AD1:  LDA $0403,X
L9AD4:  ADC #$00
L9AD6:  STA $05
L9AD8:  LDA $0400,X
L9ADB:  STA $08
L9ADD:  LDA $0401,X
L9AE0:  STA $09
L9AE2:  LDA $6AFB,X
L9AE5:  STA $0B
L9AE7:  JSR $8027
L9AEA:  BCS $9AF1
L9AEC:  LDA #$00
L9AEE:  STA $6AF4,X
L9AF1:  JSR $99F4
L9AF4:  LDA #$08
L9AF6:  JMP $8003
L9AF9:  LDA $00
L9AFB:  PHA 
L9AFC:  JSR $9B1B
L9AFF:  STA $0402,X
L9B02:  PLA 
L9B03:  JSR $9B20
L9B06:  STA $0406,X
L9B09:  LDA $01
L9B0B:  PHA 
L9B0C:  JSR $9B1B
L9B0F:  STA $0403,X
L9B12:  PLA 
L9B13:  JSR $9B20
L9B16:  STA $0407,X
L9B19:  RTS

L9B1A:  LSR 
L9B1B:  LSR 
L9B1C:  LSR 
L9B1D:  LSR 
L9B1E:  LSR 
L9B1F:  RTS

L9B20:  ASL 
L9B21:  ASL 
L9B22:  ASL 
L9B23:  ASL 
L9B24:  RTS

;-------------------------------------------------------------------------------
; Tourian specific routine -- called every active frame
L9B25:  JSR L9B37
L9B28:  JSR L9DD4
L9B2B:  JSR LA1E7
L9B2E:  JSR LA238
L9B31:  JSR LA28B
L9B34:  JMP LA15E

;-------------------------------------------------------------------------------
L9B37:  LDX #$78
L9B39:  JSR $9B44
L9B3C:  LDA $97
L9B3E:  SEC 
L9B3F:  SBC #$08
L9B41:  TAX 
L9B42:  BNE $9B39
L9B44:  STX $97
L9B46:  LDY $6BF4,X
L9B49:  BNE $9B4C
L9B4B:  RTS

L9B4C:  JSR $9C4D
L9B4F:  TYA 
L9B50:  BNE $9B4B
L9B52:  LDY $010B
L9B55:  INY 
L9B56:  BNE $9B65
L9B58:  LDA $6BF8,X
L9B5B:  CMP #$05
L9B5D:  BEQ $9B4B
L9B5F:  JSR $9B70
L9B62:  JMP $9C2B
L9B65:  LDA $2D
L9B67:  AND #$02
L9B69:  BNE $9B4B
L9B6B:  LDA #$19
L9B6D:  JMP $9C31
L9B70:  LDY $6BF8,X
L9B73:  LDA $6BFA,X
L9B76:  BNE $9B81
L9B78:  LDA $9D8F,Y
L9B7B:  STA $6BFA,X
L9B7E:  INC $6BFB,X
L9B81:  DEC $6BFA,X
L9B84:  LDA $9D94,Y
L9B87:  CLC 
L9B88:  ADC $6BFB,X
L9B8B:  TAY 
L9B8C:  LDA $9D99,Y
L9B8F:  BPL $9BAB
L9B91:  CMP #$FF
L9B93:  BNE $9B9F
L9B95:  LDY $6BF8,X
L9B98:  LDA #$00
L9B9A:  STA $6BFB,X
L9B9D:  BEQ $9B84
L9B9F:  INC $6BFB,X
L9BA2:  JSR $9BAF
L9BA5:  LDY $6BF8,X
L9BA8:  JMP $9B84
L9BAB:  STA $6BF9,X
L9BAE:  RTS

L9BAF:  PHA 
L9BB0:  LDA MotherBrainStatus
L9BB2:  CMP #$04
L9BB4:  BCS $9BC6
L9BB6:  LDY #$60
L9BB8:  LDA $6AF4,Y
L9BBB:  BEQ $9BC8
L9BBD:  TYA 
L9BBE:  CLC 
L9BBF:  ADC #$10
L9BC1:  TAY 
L9BC2:  CMP #$A0
L9BC4:  BNE $9BB8
L9BC6:  PLA 
L9BC7:  RTS

L9BC8:  STY $4B
L9BCA:  LDA $6BF5,X
L9BCD:  STA $0400,Y
L9BD0:  LDA $6BF6,X
L9BD3:  STA $0401,Y
L9BD6:  LDA $6BF7,X
L9BD9:  STA $6AFB,Y
L9BDC:  LDA #$02
L9BDE:  STA $6AF4,Y
L9BE1:  LDA #$00
L9BE3:  STA $0409,Y
L9BE6:  STA $6AF8,Y
L9BE9:  STA $0408,Y
L9BEC:  PLA 
L9BED:  JSR $95C6
L9BF0:  TAX 
L9BF1:  STA $040A,Y
L9BF4:  ORA #$02
L9BF6:  STA $0405,Y
L9BF9:  LDA $9C26,X
L9BFC:  STA $6AF9,Y
L9BFF:  STA $6AFA,Y
L9C02:  LDA $9DCC,X
L9C05:  STA $05
L9C07:  LDA $9DCF,X
L9C0A:  STA $04
L9C0C:  LDX $97
L9C0E:  LDA $6BF5,X
L9C11:  STA $08
L9C13:  LDA $6BF6,X
L9C16:  STA $09
L9C18:  LDA $6BF7,X
L9C1B:  STA $0B
L9C1D:  TYA 
L9C1E:  TAX 
L9C1F:  JSR $8027
L9C22:  JSR $99F4
L9C25:  LDX $97
L9C27:  RTS

L9C28:  .byte $0C, $0A, $0E

L9c2B:  LDY $6BF9,X
L9C2E:  LDA $9DC6,Y
L9C31:  STA $6BD7
L9C34:  LDA $6BF5,X
L9C37:  STA $04E0
L9C3A:  LDA $6BF6,X
L9C3D:  STA $04E1
L9C40:  LDA $6BF7,X
L9C43:  STA $6BDB
L9C46:  LDA #$E0
L9C48:  STA $4B
L9C4A:  JMP $803C
L9C4D:  LDY #$00
L9C4F:  LDA $6BF6,X
L9C52:  CMP $FD
L9C54:  LDA $49
L9C56:  AND #$02
L9C58:  BNE $9C5F
L9C5A:  LDA $6BF5,X
L9C5D:  CMP $FC
L9C5F:  LDA $6BF7,X
L9C62:  EOR $FF
L9C64:  AND #$01
L9C66:  BEQ $9C6B
L9C68:  BCS $9C6D
L9C6A:  SEC 
L9C6B:  BCS $9C6E
L9C6D:  INY 
L9C6E:  RTS

;-------------------------------------------------------------------------------
L9C6F:  STY $02
L9C71:  LDY #$00
L9C73:  LDA $6BF7,Y
L9C76:  EOR $02
L9C78:  LSR 
L9C79:  BCS $9C80
L9C7B:  LDA #$00
L9C7D:  STA $6BF4,Y
L9C80:  TYA 
L9C81:  CLC 
L9C82:  ADC #$08
L9C84:  TAY 
L9C85:  BPL $9C73
L9C87:  LDX #$00
L9C89:  LDA $0758,X
L9C8C:  BEQ $9C99
L9C8E:  JSR $9D64
L9C91:  EOR $075A,X
L9C94:  BNE $9C99
L9C96:  STA $0758,X
L9C99:  TXA 
L9C9A:  CLC 
L9C9B:  ADC #$08
L9C9D:  TAX 
L9C9E:  CMP #$28
L9CA0:  BNE $9C89
L9CA2:  LDX #$00
L9CA4:  JSR $9CD6
L9CA7:  LDX #$03
L9CA9:  JSR $9CD6
L9CAC:  LDA MotherBrainStatus
L9CAE:  BEQ $9CC3
L9CB0:  CMP #$07
L9CB2:  BEQ $9CC3
L9CB4:  CMP #$0A
L9CB6:  BEQ $9CC3
L9CB8:  LDA $9D
L9CBA:  EOR $02
L9CBC:  LSR 
L9CBD:  BCS $9CC3
L9CBF:  LDA #$00
L9CC1:  STA MotherBrainStatus
L9CC3:  LDA $010D
L9CC6:  BEQ $9CD5
L9CC8:  LDA $010C
L9CCB:  EOR $02
L9CCD:  LSR 
L9CCE:  BCS $9CD5
L9CD0:  LDA #$00
L9CD2:  STA $010D
L9CD5:  RTS

L9CD6:  LDA $8B,X
L9CD8:  BMI $9CE5
L9CDA:  LDA $8C,X
L9CDC:  EOR $02
L9CDE:  LSR 
L9CDF:  BCS $9CE5
L9CE1:  LDA #$FF
L9CE3:  STA $8B,X
L9CE5:  RTS

;-------------------------------------------------------------------------------
; Tourian Cannon Handler
L9CE6:  LDX #$00
L9CE8:  LDA $6BF4,X
L9CEB:  BEQ $9CF6
L9CED:  TXA 
L9CEE:  CLC 
L9CEF:  ADC #$08
L9CF1:  TAX 
L9CF2:  BPL $9CE8
L9CF4:  BMI $9D20
L9CF6:  LDA ($00),Y
L9CF8:  JSR $9B1B
L9CFB:  STA $6BF8,X
L9CFE:  LDA #$01
L9D00:  STA $6BF4,X
L9D03:  STA $6BFB,X
L9D06:  INY 
L9D07:  LDA ($00),Y
L9D09:  PHA 
L9D0A:  AND #$F0
L9D0C:  ORA #$07
L9D0E:  STA $6BF5,X
L9D11:  PLA 
L9D12:  JSR $9B20
L9D15:  ORA #$07
L9D17:  STA $6BF6,X
L9D1A:  JSR $9D88
L9D1D:  STA $6BF7,X
L9D20:  RTS

;-------------------------------------------------------------------------------
; Mother Brain Handler
L9D21:  LDA #$01
L9D23:  STA MotherBrainStatus
L9D25:  JSR $9D88
L9D28:  STA $9D
L9D2A:  EOR #$01
L9D2C:  TAX 
L9D2D:  LDA $9D3C
L9D30:  ORA $6C,X
L9D32:  STA $6C,X
L9D34:  LDA #$20
L9D36:  STA $9A
L9D38:  STA $9B
L9D3A:  RTS 

L9D3B:  .byte $02, $01 

;-------------------------------------------------------------------------------
; Zebetite Handler
L9D3D:  LDA ($00),Y
L9D3F:  AND #$F0
L9D41:  LSR
L9D42:  TAX 
L9D43:  ASL 
L9D44:  AND #$10
L9D46:  EOR #$10
L9D48:  ORA #$84
L9D4A:  STA $0759,X
L9D4D:  JSR $9D64
L9D50:  STA $075A,X
L9D53:  LDA #$01
L9D55:  STA $0758,X
L9D58:  LDA #$00
L9D5A:  STA $075B,X
L9D5D:  STA $075C,X
L9D60:  STA $075D,X
L9D63:  RTS

L9D64:  JSR $9D88
L9D67:  ASL 
L9D68:  ASL 
L9D69:  ORA #$61
L9D6B:  RTS

;-------------------------------------------------------------------------------
; Rinka Handler
L9D6C:  LDX #$03
L9D6E:  JSR $9D75
L9D71:  BMI $9D87
L9D73:  LDX #$00
L9D75:  LDA $8B,X
L9D77:  BPL $9D87
L9D79:  LDA ($00),Y
L9D7B:  JSR $9B1B
L9D7E:  STA $8B,X
L9D80:  JSR $9D88
L9D83:  STA $8C,X
L9D85:  LDA #$FF
L9D87:  RTS

L9D88:  LDA $FF
L9D8A:  EOR $49
L9D8C:  AND #$01
L9D8E:  RTS

L9D8F:  .byte $28, $28, $28, $28, $28, $00, $0B, $16, $21, $27, $00, $01, $02, $FD, $03, $04
L9D9F:  .byte $FD, $03, $02, $01, $FF, $00, $07, $06, $FE, $05, $04, $FE, $05, $06, $07, $FF
L9DAF:  .byte $02, $03, $FC, $04, $05, $06, $05, $FC, $04, $03, $FF, $02, $03, $FC, $04, $03
L9DBF:  .byte $FF, $06, $05, $FC, $04, $05, $FF, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $09

L9DCF:  .byte $F7, $00, $09, $09, $0B

;-------------------------------------------------------------------------------
; This is code:
L9DD4:
    LDA MotherBrainStatus
    BEQ $9DF1
    JSR CommonJump_ChooseRoutine
    .word Exit__    ;#$00=Mother brain not in room, 
    .word L9E22     ;#$01=Mother brain in room
    .word L9E36     ;#$02=Mother brain hit
    .word L9E52     ;#$03=Mother brain dying
    .word L9E86     ;#$04=Mother brain dissapearing
    .word L9F02     ;#$05=Mother brain gone
    .word L9F49     ;#$06=Time bomb set, 
    .word L9FC0     ;#$07=Time bomb exploded
    .word L9F02     ;#$08=Initialize mother brain
    .word L9FDA     ;#$09
    .word Exit__    ;#$0A=Mother brain already dead.
L9DF1:  RTS

;-------------------------------------------------------------------------------
L9DF2:  LDA $030C
L9DF5:  EOR $9D
L9DF7:  BNE $9DF1
L9DF9:  LDA $030E
L9DFC:  SEC 
L9DFD:  SBC #$48
L9DFF:  CMP #$2F
L9E01:  BCS $9DF1
L9E03:  LDA $030D
L9E06:  SEC 
L9E07:  SBC #$80
L9E09:  BPL $9E0E
L9E0B:  JSR $95C6
L9E0E:  CMP #$20
L9E10:  BCS $9DF1
L9E12:  LDA #$00
L9E14:  STA $6E
L9E16:  LDA #$02
L9E18:  STA $6F
L9E1A:  LDA #$38
L9E1C:  STA $030A
L9E1F:  JMP $8042

;-------------------------------------------------------------------------------
L9E22:  JSR L9DF2
L9E25:  JSR L9FED
L9E28:  JSR LA01B
L9E2B:  JSR LA02E
L9E2E:  JSR LA041
L9E31:  LDA #$00
L9E33:  STA $9E
L9E35:  RTS

;-------------------------------------------------------------------------------
L9E36:  JSR L9E43
L9E39:  LDA $9E41,Y
L9E3C:  STA $1C
L9E3E:  JMP $9E31

L9E41:  .byte $08, $07

L9E43:  DEC $9F
L9E45:  BNE $9E4B
L9E47:  LDA #$01
L9E49:  STA MotherBrainStatus
L9E4B:  LDA $9F
L9E4D:  AND #$02
L9E4F:  LSR 
L9E50:  TAY 
L9E51:  RTS

;-------------------------------------------------------------------------------
L9E52:  JSR L9E43
L9E55:  LDA $9E41,Y
L9E58:  STA $1C
L9E5A:  TYA 
L9E5B:  ASL 
L9E5C:  ASL 
L9E5D:  STA $FC
L9E5F:  LDY MotherBrainStatus
L9E61:  DEY 
L9E62:  BNE $9E83
L9E64:  STY MotherBrainHits
L9E66:  TYA 
L9E67:  TAX 
L9E68:  TYA 
L9E69:  STA $6AF4,X
L9E6C:  JSR $9EF9
L9E6F:  CPX #$C0
L9E71:  BNE $9E68
L9E73:  LDA #$04
L9E75:  STA MotherBrainStatus
L9E77:  LDA #$28
L9E79:  STA $9F
L9E7B:  LDA $0680
L9E7E:  ORA #$01
L9E80:  STA $0680
L9E83:  JMP $9E2E

;-------------------------------------------------------------------------------
L9E86:  LDA #$10
L9E88:  ORA $0680
L9E8B:  STA $0680
L9E8E:  JSR $A072
L9E91:  INC $9A
L9E93:  JSR L9E43
L9E96:  LDX #$00
L9E98:  LDA $6AF4,X
L9E9B:  CMP #$05
L9E9D:  BNE $9EA4
L9E9F:  LDA #$00
L9EA1:  STA $6AF4,X
L9EA4:  JSR $9EF9
L9EA7:  CMP #$40
L9EA9:  BNE $9E98
L9EAB:  LDA $07A0
L9EAE:  BNE $9EB5
L9EB0:  LDA $9F00,Y
L9EB3:  STA $1C
L9EB5:  LDY MotherBrainStatus
L9EB7:  DEY 
L9EB8:  BNE $9ED5
L9EBA:  STY $9A
L9EBC:  LDA #$04
L9EBE:  STA MotherBrainStatus
L9EC0:  LDA #$1C
L9EC2:  STA $9F
L9EC4:  LDY MotherBrainHits
L9EC6:  INC MotherBrainHits
L9EC8:  CPY #$04
L9ECA:  BEQ $9ED3
L9ECC:  LDX #$00
L9ECE:  BCC $9ED5
L9ED0:  JMP $9ED6
L9ED3:  LSR $9F
L9ED5:  RTS

L9ED6:  LDA $0685
L9ED9:  ORA #$04
L9EDB:  STA $0685
L9EDE:  LDA #$05
L9EE0:  STA MotherBrainStatus
L9EE2:  LDA #$80
L9EE4:  STA MotherBrainHits
L9EE6:  RTS

L9EE7:  PHA 
L9EE8:  AND #$F0
L9EEA:  ORA #$07
L9EEC:  STA $0400,X
L9EEF:  PLA 
L9EF0:  JSR $9B20
L9EF3:  ORA #$07
L9EF5:  STA $0401,X
L9EF8:  RTS

L9EF9:  TXA 
L9EFA:  CLC 
L9EFB:  ADC #$10
L9EFD:  TAX 
L9EFE:  RTS

L9EFF:  .byte $60

L9F00:  ORA #$0A

;-------------------------------------------------------------------------------
L9F02:  LDA MotherBrainHits
L9F04:  BMI $9F33
L9F06:  CMP #$08
L9F08:  BEQ $9F36
L9F0A:  TAY 
L9F0B:  LDA $9F41,Y
L9F0E:  STA $0503
L9F11:  LDA $9F39,Y
L9F14:  CLC 
L9F15:  ADC #$42
L9F17:  STA $0508
L9F1A:  PHP 
L9F1B:  LDA $9D
L9F1D:  ASL 
L9F1E:  ASL 
L9F1F:  PLP 
L9F20:  ADC #$61
L9F22:  STA $0509
L9F25:  LDA #$00
L9F27:  STA $4B
L9F29:  LDA $07A0
L9F2C:  BNE $9F38
L9F2E:  JSR $803F
L9F31:  BCS $9F38
L9F33:  INC MotherBrainHits
L9F35:  RTS

L9F36:  INC MotherBrainStatus
L9F38:  RTS

L9F39:  .byte $00, $40, $08, $48, $80, $C0, $88, $C8, $08, $02, $09, $03, $0A, $04, $0B, $05

L9F49:  JSR $9F69
L9F4C:  BCS $9F64
L9F4E:  LDA #$00
L9F50:  STA MotherBrainStatus
L9F52:  LDA #$99
L9F54:  STA $010A
L9F57:  STA $010B
L9F5A:  LDA #$01
L9F5C:  STA $010D
L9F5F:  LDA $9D
L9F61:  STA $010C
L9F64:  RTS 

L9F65:  .byte $80, $B0, $A0, $90

L9F69:  LDA $50 
L9F6B:  CLC
L9F6C:  ADC $4F
L9F6E:  SEC 
L9F6F:  ROL 
L9F70:  AND #$03
L9F72:  TAY 
L9F73:  LDX $9F65,Y
L9F76:  LDA #$01
L9F78:  STA $030F,X
L9F7B:  LDA #$01
L9F7D:  STA $0307,X
L9F80:  LDA #$03
L9F82:  STA $0300,X
L9F85:  LDA $9D
L9F87:  STA $030C,X
L9F8A:  LDA #$10
L9F8C:  STA $030E,X
L9F8F:  LDA #$68
L9F91:  STA $030D,X
L9F94:  LDA #$55
L9F96:  STA $0305,X
L9F99:  STA $0306,X
L9F9C:  LDA #$00
L9F9E:  STA $0304,X
L9FA1:  LDA #$F7
L9FA3:  STA $0303,X
L9FA6:  LDA #$10
L9FA8:  STA $0503
L9FAB:  LDA #$40
L9FAD:  STA $0508
L9FB0:  LDA $9D
L9FB2:  ASL 
L9FB3:  ASL 
L9FB4:  ORA #$61
L9FB6:  STA $0509
L9FB9:  LDA #$00
L9FBB:  STA $4B
L9FBD:  JMP $803F

;-------------------------------------------------------------------------------
L9FC0:  LDA #$10
L9FC2:  ORA $0680
L9FC5:  STA $0680
L9FC8:  LDA $2C
L9FCA:  BNE $9FD9
L9FCC:  LDA #$08
L9FCE:  STA $0300
L9FD1:  LDA #$0A
L9FD3:  STA MotherBrainStatus
L9FD5:  LDA #$01
L9FD7:  STA $1C
L9FD9:  RTS

;-------------------------------------------------------------------------------
L9FDA:  JSR $9F69
L9FDD:  BCS $9FEC
L9FDF:  LDA $9D
L9FE1:  STA $010C
L9FE4:  LDY #$01
L9FE6:  STY $010D
L9FE9:  DEY 
L9FEA:  STY MotherBrainStatus
L9FEC:  RTS

;-------------------------------------------------------------------------------
L9FED:  LDA $9E
L9FEF:  BEQ $A01A
L9FF1:  LDA $0684
L9FF4:  ORA #$02
L9FF6:  STA $0684
L9FF9:  INC MotherBrainHits
L9FFB:  LDA MotherBrainHits
L9FFD:  CMP #$20
L9FFF:  LDY #$02
LA001:  LDA #$10
LA003:  BCC $A016
LA005:  LDX #$00
LA007:  LDA #$00
LA009:  STA $0500,X
LA00C:  JSR $9EF9
LA00F:  CMP #$D0
LA011:  BNE $A007
LA013:  INY 
LA014:  LDA #$80
LA016:  STY MotherBrainStatus
LA018:  STA $9F
LA01A:  RTS

;-------------------------------------------------------------------------------
LA01B:  DEC $9A
LA01D:  BNE $A02D
LA01F:  LDA $2E
LA021:  AND #$03
LA023:  STA $9C
LA025:  LDA #$20
LA027:  SEC 
LA028:  SBC MotherBrainHits
LA02A:  LSR 
LA02B:  STA $9A
LA02D:  RTS

;-------------------------------------------------------------------------------
LA02E:  DEC $9B
LA030:  LDA $9B
LA032:  ASL 
LA033:  BNE $A040
LA035:  LDA #$20
LA037:  SEC 
LA038:  SBC MotherBrainHits
LA03A:  ORA #$80
LA03C:  EOR $9B
LA03E:  STA $9B
LA040:  RTS

;-------------------------------------------------------------------------------
LA041:  LDA #$E0
LA043:  STA $4B
LA045:  LDA $9D
LA047:  STA $6BDB
LA04A:  LDA #$70
LA04C:  STA $04E0
LA04F:  LDA #$48
LA051:  STA $04E1
LA054:  LDY $9C
LA056:  LDA $A06D,Y
LA059:  STA $6BD7
LA05C:  JSR $803C
LA05F:  LDA $9B
LA061:  BMI $A06C
LA063:  LDA $A071
LA066:  STA $6BD7
LA069:  JSR $803C
LA06C:  RTS

LA06D:  .byte $13, $14, $15, $16, $17

LA072:  LDY MotherBrainHits
LA074:  BEQ $A086
LA076:  LDA $A0C0,Y
LA079:  CLC 
LA07A:  ADC $9A
LA07C:  TAY 
LA07D:  LDA $A0A3,Y
LA080:  CMP #$FF
LA082:  BNE $A087
LA084:  DEC $9A
LA086:  RTS

LA087:  ADC #$44
LA089:  STA $0508
LA08C:  PHP 
LA08D:  LDA $9D
LA08F:  ASL 
LA090:  ASL 
LA091:  ORA #$61
LA093:  PLP 
LA094:  ADC #$00
LA096:  STA $0509
LA099:  LDA #$00
LA09B:  STA $0503
LA09E:  STA $4B
LA0A0:  JMP $803F

LA0A3:  .byte $00, $02, $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27
LA0B3:  .byte $FF, $82, $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86, $FF, $00, $0C
LA0C3:  .byte $11, $16, $1A

;-------------------------------------------------------------------------------
LA0C6:  LDA $71
LA0C8:  BEQ $A13E
LA0CA:  LDX $4B
LA0CC:  LDA $0300,X
LA0CF:  CMP #$0B
LA0D1:  BNE $A13E
LA0D3:  CPY #$98
LA0D5:  BNE $A103
LA0D7:  LDX #$00
LA0D9:  LDA $0500,X
LA0DC:  BEQ $A0E7
LA0DE:  JSR $9EF9
LA0E1:  CMP #$D0
LA0E3:  BNE $A0D9
LA0E5:  BEQ $A13E
LA0E7:  LDA #$8C
LA0E9:  STA $0508,X
LA0EC:  LDA $05
LA0EE:  STA $0509,X
LA0F1:  LDA #$01
LA0F3:  STA $0503,X
LA0F6:  LDA $4B
LA0F8:  PHA 
LA0F9:  STX $4B
LA0FB:  JSR $803F
LA0FE:  PLA 
LA0FF:  STA $4B
LA101:  BNE $A13E
LA103:  LDA $04
LA105:  LSR 
LA106:  BCC $A10A
LA108:  DEC $04
LA10A:  LDY #$00
LA10C:  LDA ($04),Y
LA10E:  LSR 
LA10F:  BCS $A13E
LA111:  CMP #$48
LA113:  BCC $A13E
LA115:  CMP #$4C
LA117:  BCS $A13E
LA119:  LDA $0758,Y
LA11C:  BEQ $A12E
LA11E:  LDA $04
LA120:  AND #$9E
LA122:  CMP $0759,Y
LA125:  BNE $A12E
LA127:  LDA $05
LA129:  CMP $075A,Y
LA12C:  BEQ $A139
LA12E:  TYA 
LA12F:  CLC 
LA130:  ADC #$08
LA132:  TAY 
LA133:  CMP #$28
LA135:  BNE $A119
LA137:  BEQ $A13E
LA139:  LDA #$01
LA13B:  STA $075D,Y
LA13E:  PLA 
LA13F:  PLA 
LA140:  CLC 
LA141:  RTS

;-------------------------------------------------------------------------------
LA142:  TAY 
LA143:  LDA $71
LA145:  BEQ $A15C
LA147:  LDX $4B
LA149:  LDA $0300,X
LA14C:  CMP #$0B
LA14E:  BNE $A15C
LA150:  CPY #$5E
LA152:  BCC $A15C
LA154:  CPY #$72
LA156:  BCS $A15C
LA158:  LDA #$01
LA15A:  STA $9E
LA15C:  TYA 
LA15D:  RTS

;-------------------------------------------------------------------------------
LA15E:  LDY $010B
LA161:  INY 
LA162:  BNE $A1DA
LA164:  LDY #$03
LA166:  JSR $A16B
LA169:  LDY #$00
LA16B:  STY $4B
LA16D:  LDA $008B,Y
LA170:  BMI $A15D
LA172:  LDA $008C,Y
LA175:  EOR $2D
LA177:  LSR 
LA178:  BCC $A15D
LA17A:  LDA MotherBrainStatus
LA17C:  CMP #$04
LA17E:  BCS $A15D
LA180:  LDA $2D
LA182:  AND #$06
LA184:  BNE $A15D
LA186:  LDX #$20
LA188:  LDA $6AF4,X
LA18B:  BEQ $A19C
LA18D:  LDA $0405,X
LA190:  AND #$02
LA192:  BEQ $A19C
LA194:  TXA 
LA195:  SEC 
LA196:  SBC #$10
LA198:  TAX 
LA199:  BPL $A188
LA19B:  RTS

LA19C:  LDA #$01
LA19E:  STA $6AF4,X
LA1A1:  LDA #$04
LA1A3:  STA $6B02,X
LA1A6:  LDA #$00
LA1A8:  STA $040F,X
LA1AB:  STA $0404,X
LA1AE:  JSR $802A
LA1B1:  LDA #$F7
LA1B3:  STA $6AF7,X
LA1B6:  LDY $4B
LA1B8:  LDA $008C,Y
LA1BB:  STA $6AFB,X
LA1BE:  LDA $008D,Y
LA1C1:  ASL 
LA1C2:  ORA $008B,Y
LA1C5:  TAY 
LA1C6:  LDA $A1DB,Y
LA1C9:  JSR $9EE7
LA1CC:  LDX $4B
LA1CE:  INC $8D,X
LA1D0:  LDA $8D,X
LA1D2:  CMP #$06
LA1D4:  BNE $A1DA
LA1D6:  LDA #$00
LA1D8:  STA $8D,X
LA1DA:  RTS

LA1DB:  .byte $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA, $BA, $BA

;-------------------------------------------------------------------------------
LA1E7:  LDY $010B
LA1EA:  INY 
LA1EB:  BEQ $A237
LA1ED:  LDA $010A
LA1F0:  STA $03
LA1F2:  LDA #$01
LA1F4:  SEC 
LA1F5:  JSR $8045
LA1F8:  STA $010A
LA1FB:  LDA $010B
LA1FE:  STA $03
LA200:  LDA #$00
LA202:  JSR $8045
LA205:  STA $010B
LA208:  LDA $2D
LA20A:  AND #$1F
LA20C:  BNE $A216
LA20E:  LDA $0681
LA211:  ORA #$08
LA213:  STA $0681
LA216:  LDA $010A
LA219:  ORA $010B
LA21C:  BNE $A237
LA21E:  DEC $010B
LA221:  STA MotherBrainHits
LA223:  LDA #$07
LA225:  STA MotherBrainStatus
LA227:  LDA $0680
LA22A:  ORA #$01
LA22C:  STA $0680
LA22F:  LDA #$0C
LA231:  STA $2C
LA233:  LDA #$0B
LA235:  STA $1C
LA237:  RTS

;-------------------------------------------------------------------------------
LA238:  LDA $010D
LA23B:  BEQ $A28A
LA23D:  LDA $010C
LA240:  STA $6BDB
LA243:  LDA #$84
LA245:  STA $04E0
LA248:  LDA #$64
LA24A:  STA $04E1
LA24D:  LDA #$1A
LA24F:  STA $6BD7
LA252:  LDA #$E0
LA254:  STA $4B
LA256:  LDA $5B
LA258:  PHA 
LA259:  JSR $803C
LA25C:  PLA 
LA25D:  CMP $5B
LA25F:  BEQ $A28A
LA261:  TAX 
LA262:  LDA $010B
LA265:  LSR 
LA266:  LSR 
LA267:  LSR 
LA268:  SEC 
LA269:  ROR 
LA26A:  AND #$0F
LA26C:  ORA #$A0
LA26E:  STA $0201,X
LA271:  LDA $010B
LA274:  AND #$0F
LA276:  ORA #$A0
LA278:  STA $0205,X
LA27B:  LDA $010A
LA27E:  LSR 
LA27F:  LSR 
LA280:  LSR 
LA281:  SEC 
LA282:  ROR 
LA283:  AND #$0F
LA285:  ORA #$A0
LA287:  STA $0209,X
LA28A:  RTS

;-------------------------------------------------------------------------------
LA28B:  LDA #$10
LA28D:  STA $4B
LA28F:  LDX #$20
LA291:  JSR $A29B
LA294:  TXA 
LA295:  SEC 
LA296:  SBC #$08
LA298:  TAX 
LA299:  BNE $A291
LA29B:  LDA $0758,X
LA29E:  AND #$0F
LA2A0:  CMP #$01
LA2A2:  BNE $A28A
LA2A4:  LDA $075D,X
LA2A7:  BEQ $A2F2
LA2A9:  INC $075B,X
LA2AC:  LDA $075B,X
LA2AF:  LSR 
LA2B0:  BCS $A2F2
LA2B2:  TAY 
LA2B3:  SBC #$03
LA2B5:  BNE $A2BA
LA2B7:  INC $0758,X
LA2BA:  LDA $A310,Y
LA2BD:  STA $0513
LA2C0:  LDA $0759,X
LA2C3:  STA $0518
LA2C6:  LDA $075A,X
LA2C9:  STA $0519
LA2CC:  LDA $07A0
LA2CF:  BNE $A2DA
LA2D1:  TXA 
LA2D2:  PHA 
LA2D3:  JSR $803F
LA2D6:  PLA 
LA2D7:  TAX 
LA2D8:  BCC $A2EB
LA2DA:  LDA $0758,X
LA2DD:  AND #$80
LA2DF:  ORA #$01
LA2E1:  STA $0758,X
LA2E4:  STA $075D,X
LA2E7:  DEC $075B,X
LA2EA:  RTS

LA2EB:  LDA #$40
LA2ED:  STA $075C,X
LA2F0:  BNE $A30A
LA2F2:  LDY $075B,X
LA2F5:  BEQ $A30A
LA2F7:  DEC $075C,X
LA2FA:  BNE $A30A
LA2FC:  LDA #$40
LA2FE:  STA $075C,X
LA301:  DEY 
LA302:  TYA 
LA303:  STA $075B,X
LA306:  LSR 
LA307:  TAY 
LA308:  BCC $A2BA
LA30A:  LDA #$00
LA30C:  STA $075D,X
LA30F:  RTS

LA310:  .byte $0C, $0D, $0E, $0F, $07

LA315:  LDY #$05
LA317:  JSR $99B1
LA31A:  DEY 
LA31B:  BPL $A317
LA31D:  STA $92
LA31F:  RTS
;-----------------
LA320:  TXA 
LA321:  JSR $9B1B
LA324:  TAY 
LA325:  JSR $99B1
LA328:  STA $92
LA32A:  RTS

LA32B:  .byte $22, $FF, $FF, $FF, $FF

LA330:  .byte $32, $FF, $FF, $FF, $FF, $FF, $FF

LA337:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E0, $DE, $ED, $FF, $E8
LA347:  .byte $EE 

LA348:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $FF, $DF, $DA, $EC, $ED, $F4
LA358:  .byte $FF

LA359:  .byte $28, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA369:  .byte $FF

LA36A:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA37A:  .byte $FF

LA37B:  .byte $62, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA388:  .byte $42, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA391:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF
LA3A1:  .byte $DB

LA3A2:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E8, $E6, $DB, $FF, $EC, $DE, $ED
LA3B2:  .byte $FF

LA3B3:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA3C3:  .byte $FF

LA3C4:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA3D4:  .byte $FF

LA3D5:  .byte $42, $90, $91, $90, $91, $90, $91, $90, $91

LA3DE:  .byte $42, $92, $93, $92, $93, $92, $93, $92, $93

LA3E7:  .byte $42, $94, $95, $94, $95, $94, $95, $94, $95

LA3F0:  .byte $42, $96, $97, $96, $97, $96, $97, $96, $97

LA3F9:  .byte $62, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
LA406:  .byte $00, $01, $FF

LA409:  .byte $02, $FF

LA40B:  .byte $03, $04, $FF

LA40E:  .byte $05, $FF

LA410:  .byte $0E, $FF

LA412:  .byte $0F, $FF

LA414:  .byte $10, $FF

LA416:  .byte $11, $11, $12, $12, $F7, $FF

LA41C:  .byte $18, $FF

LA41E:  .byte $19, $F7, $FF

LA421:  .byte $1B, $1C, $1D, $FF

LA425:  .byte $1E, $FF

LA427:  .byte $61, $F7, $62, $F7, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
LA42C:  .word $A5C8, $A5CD, $A5D2, $A5D7, $A5E4, $A5F1, $A5FB, $A600
LA43C:  .word $A606, $A60D, $A613, $A618, $A61E, $A625, $A62B, $A630
LA44C:  .word $A635, $A63A, $A641, $A651, $A65F, $A66B, $A678, $A687
LA45C:  .word $A691, $A69C, $A6A3, $A6AC, $A6BC, $A6CC, $A6DC, $A6E0
LA46C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA47C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA48C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA49C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4AC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4BC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4CC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4DC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4EC:  .word $A6E0, $A6E0, $A6EE, $A708, $A708, $A708, $A708, $A708
LA4FC:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708
LA50C:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708
LA51C:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708

EnemyFramePtrTbl2:
LA52C:  .word $A708, $A70E, $A713, $A713, $A713, $A713, $A713, $A713
LA53C:  .word $A713, $A713

EnemyPlacePtrTbl:
LA540:  .word $A560, $A562, $A57A, $A58C, $A592, $A59E, $A5A4, $A5A4
LA550:  .word $A5A4, $A5A4, $A5A4, $A5C4, $A5C4, $A5C8, $A5C8, $A5C8

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

LA560:  .byte $FC, $FC

LA562:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
LA572:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA57A:  .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
LA58A:  .byte $04, $04

LA58C:  .byte $F1, $FC, $F3, $F3, $FC, $F1

LA592:  .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA59E:  .byte $FC, $F4, $FC, $FC, $FC, $04

LA5A4:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
LA5B4:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

LA5C4:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

LA5C8:  .byte $00, $02, $02, $14, $FF

LA5CD:  .byte $00, $02, $02, $24, $FF

LA5D2:  .byte $00, $00, $00, $04, $FF

LA5D7:  .byte $32, $0C, $0C, $C0, $C1, $C2, $D0, $D1, $D2, $E0, $E1, $E2, $FF

LA5E4:  .byte $32, $0C, $0C, $C3, $C4, $C5, $D3, $D4, $D5, $E3, $E4, $E5, $FF

LA5F1:  .byte $31, $00, $00, $C0, $C2, $D0, $D2, $E0, $E2, $FF

LA5FB:  .byte $23, $07, $07, $EA, $FF

LA600:  .byte $23, $07, $07, $FE, $EB, $FF

LA606:  .byte $23, $07, $07, $FE, $FE, $EC, $FF

LA60D:  .byte $A3, $07, $07, $FE, $EB, $FF

LA613:  .byte $A3, $07, $07, $EA, $FF

LA618:  .byte $E3, $07, $07, $FE, $EB, $FF

LA61E:  .byte $63, $07, $07, $FE, $FE, $EC, $FF

LA625:  .byte $63, $07, $07, $FE, $EB, $FF

LA62B:  .byte $30, $04, $04, $F1, $FF

LA630:  .byte $70, $04, $04, $F1, $FF

LA635:  .byte $30, $04, $04, $F2, $FF

LA63A:  .byte $30, $00, $00, $FD, $03, $F3, $FF

LA641:  .byte $0A, $00, $00, $FD, $00, $F4, $FD, $40, $F4, $FD, $80, $F4, $FD, $C0, $F4, $FF

LA651:  .byte $24, $08, $14, $FD, $02, $FC, $04, $F0, $D8, $D9, $E8, $E9, $F8, $FF

LA65F:  .byte $24, $14, $0C, $FD, $02, $FC, $F4, $F8, $DA, $FE, $C9, $FF

LA66B:  .byte $24, $20, $04, $FD, $02, $FC, $EC, $00, $CB, $CC, $DB, $DC, $FF

LA678:  .byte $24, $18, $14, $FD, $02, $FC, $F4, $10, $DD, $CE, $FE, $DE, $FE, $DD, $FF

LA687:  .byte $24, $08, $0C, $FD, $02, $FC, $0C, $10, $CD, $FF

LA691:  .byte $21, $00, $00, $FE, $F5, $F5, $F5, $F5, $F5, $F5, $FF

LA69C:  .byte $30, $00, $00, $FD, $03, $ED, $FF

LA6A3:  .byte $05, $04, $08, $FD, $00, $00, $00, $00, $FF

LA6AC:  .byte $3A, $08, $08, $FD, $03, $EF, $FD, $43, $EF, $FD, $83, $EF, $FD, $C3, $EF, $FF

LA6BC:  .byte $3A, $08, $08, $FD, $03, $DF, $FD, $43, $DF, $FD, $83, $DF, $FD, $C3, $DF, $FF

LA6CC:  .byte $2A, $08, $08, $FD, $03, $CF, $FD, $43, $CF, $FD, $83, $CF, $FD, $C3, $CF, $FF

LA6DC:  .byte $01, $00, $00, $FF

LA6E0:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA6EE:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA6FE:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA708:  .byte $0C, $08, $04, $14, $24, $FF

LA70E:  .byte $00, $04, $04, $8A, $FF

LA713:  .byte $00, $04, $04, $8A, $FF

;-----------------------------------------[ Palette data ]-------------------------------------------

.include tourian/palettes.asm

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include tourian/room_ptrs.asm

StrctPtrTbl:
.include tourian/structure_ptrs.asm

;------------------------------------[ Special items table ]-----------------------------------------

.include tourian/items.asm 

;-----------------------------------------[ Room definitions ]---------------------------------------

.include tourian/rooms.asm

;---------------------------------------[ Structure definitions ]------------------------------------

.include tourian/structures.asm

;----------------------------------------[ Macro definitions ]---------------------------------------

MacroDefs:
.include tourian/metatiles.asm

;------------------------------------------[ Area music data ]---------------------------------------

;There are 3 control bytes associated with the music data and the rest are musical note indexes.
;If the byte has the binary format 1011xxxx ($Bx), then the byte is an index into the corresponding
;musical notes table and is used to set the note length until it is set by another note length
;byte. The lower 4 bits are the index into the note length table. Another control byte is the loop
;and counter btye. The loop and counter byte has the format 11xxxxxx. Bits 0 thru 6 contain the
;number of times to loop.  The third control byte is #$FF. This control byte marks the end of a loop
;and decrements the loop counter. If #$00 is found in the music data, the music has reached the end.
;A #$00 in any of the different music channel data segments will mark the end of the music. The
;remaining bytes are indexes into the MusicNotesTbl and should only be even numbers as there are 2
;bytes of data per musical note.

EscapeSQ2Data:
LB000:  .byte $C4                               ;
LB001:  .byte $B3                               ;3/4 seconds    +
LB002:  .byte $3E                               ;G4             |
LB003:  .byte $44                               ;A#4            | Repeat 4 times
LB004:  .byte $B4                               ;1 1/2 seconds  |
LB005:  .byte $42                               ;A4             +
LB006:  .byte $FF                               ;
LB007:  .byte $C2                               ;
LB008:  .byte $B6                               ;1 3/16 seconds +
LB009:  .byte $30                               ;C4             |
LB00A:  .byte $B9                               ;1/8 seconds    |
LB00B:  .byte $26                               ;G3             |
LB00C:  .byte $30                               ;C4             |
LB00D:  .byte $36                               ;D#4            |
LB00E:  .byte $B4                               ;1 1/2 seconds  |
LB00F:  .byte $34                               ;D4             |
LB010:  .byte $B6                               ;1 3/16 seconds |
LB011:  .byte $30                               ;C4             |
LB012:  .byte $B9                               ;1/8 seconds    |
LB013:  .byte $26                               ;G3             |
LB014:  .byte $30                               ;C4             |
LB015:  .byte $36                               ;D#4            |
LB016:  .byte $B4                               ;1 1/2 seconds  | Repeat 2 times
LB017:  .byte $34                               ;D4             |
LB018:  .byte $B6                               ;1 3/16 seconds |
LB019:  .byte $30                               ;C4             |
LB01A:  .byte $B9                               ;1/8 seconds    |
LB01B:  .byte $26                               ;G3             |
LB01C:  .byte $30                               ;C4             |
LB01D:  .byte $38                               ;E4             |
LB01E:  .byte $B4                               ;1 1/2 seconds  |
LB01F:  .byte $34                               ;D4             |
LB020:  .byte $B6                               ;1 3/16 seconds |
LB021:  .byte $30                               ;C4             |
LB022:  .byte $B9                               ;1/8 seconds    |
LB023:  .byte $26                               ;G3             |
LB024:  .byte $30                               ;C4             |
LB025:  .byte $38                               ;E4             |
LB026:  .byte $B4                               ;1 1/2 seconds  |
LB027:  .byte $34                               ;D4             +
LB028:  .byte $FF                               ;
LB029:  .byte $C2                               ;
LB02A:  .byte $B6                               ;1 3/16 seconds +
LB02B:  .byte $48                               ;C5             |
LB02C:  .byte $B9                               ;1/8 seconds    |
LB02D:  .byte $46                               ;B4             |
LB02E:  .byte $02                               ;No sound       |
LB02F:  .byte $48                               ;C5             |
LB030:  .byte $B6                               ;1 3/16 seconds |
LB031:  .byte $4C                               ;D5             |
LB032:  .byte $B2                               ;3/8 seconds    |
LB033:  .byte $48                               ;C5             |
LB034:  .byte $B6                               ;1 3/16 seconds |
LB035:  .byte $46                               ;B4             |
LB036:  .byte $B9                               ;1/8 second     |
LB037:  .byte $42                               ;A4             |
LB038:  .byte $02                               ;No sound       |
LB039:  .byte $46                               ;B4             | Repeat 2 times
LB03A:  .byte $B3                               ;3/4 seconds    |
LB03B:  .byte $48                               ;C5             |
LB03C:  .byte $3E                               ;G4             |
LB03D:  .byte $B6                               ;1 3/16 seconds |
LB03E:  .byte $3A                               ;F4             |
LB03F:  .byte $B9                               ;1/8 seconds    |
LB040:  .byte $3E                               ;G4             |
LB041:  .byte $02                               ;No sound       |
LB042:  .byte $3A                               ;F4             |
LB043:  .byte $B3                               ;3/4 seconds    |
LB044:  .byte $38                               ;E4             |
LB045:  .byte $30                               ;C4             |
LB046:  .byte $B4                               ;1 1/2 seconds  |
LB047:  .byte $36                               ;D#4            |
LB048:  .byte $B3                               ;3/4 seconds    |
LB049:  .byte $30                               ;C4             |
LB04A:  .byte $2E                               ;B3             +
LB04B:  .byte $FF                               ;
LB04C:  .byte $00                               ;End escape music.

EscapeSQ1Data:
LB04D:  .byte $C4                               ;
LB04E:  .byte $B3                               ;3/4 seconds    +
LB04F:  .byte $34                               ;D4             |
LB050:  .byte $3A                               ;F4             | Repeat 4 times
LB051:  .byte $B4                               ;1 1/2 seconds  |
LB052:  .byte $32                               ;C#4            +
LB053:  .byte $FF                               ;
LB054:  .byte $C2                               ;
LB055:  .byte $B4                               ;1 1/2 seconds  +
LB056:  .byte $2A                               ;A3             |
LB057:  .byte $28                               ;Ab3            |
LB058:  .byte $2A                               ;A3             |
LB059:  .byte $B6                               ;1 3/16 seconds |
LB05A:  .byte $28                               ;Ab3            |
LB05B:  .byte $B9                               ;1/8 seconds    |
LB05C:  .byte $26                               ;G3             |
LB05D:  .byte $24                               ;F#3            |
LB05E:  .byte $22                               ;F3             |
LB05F:  .byte $B6                               ;1 3/16 seconds |
LB060:  .byte $20                               ;E3             |
LB061:  .byte $B2                               ;3/8 seconds    |
LB062:  .byte $22                               ;F3             |
LB063:  .byte $B6                               ;1 3/16 seconds | Repeat 2 times
LB064:  .byte $28                               ;Ab3            |
LB065:  .byte $B9                               ;1/8 seconds    |
LB066:  .byte $26                               ;G3             |
LB067:  .byte $24                               ;F#3            |
LB068:  .byte $22                               ;F3             |
LB069:  .byte $B4                               ;1 1/2 seconds  |
LB06A:  .byte $26                               ;G3             |
LB06B:  .byte $B9                               ;1/8 seconds    |
LB06C:  .byte $22                               ;F3             |
LB06D:  .byte $20                               ;E3             |
LB06E:  .byte $22                               ;F3             |
LB06F:  .byte $26                               ;G3             |
LB070:  .byte $22                               ;F3             |
LB071:  .byte $26                               ;G3             |
LB072:  .byte $2A                               ;A3             |
LB073:  .byte $26                               ;G3             |
LB074:  .byte $2A                               ;A3             |
LB075:  .byte $2E                               ;B3             |
LB076:  .byte $2A                               ;A3             |
LB077:  .byte $2E                               ;B3             +
LB078:  .byte $FF                               ;
LB079:  .byte $C2                               ;
LB07A:  .byte $B9                               ;1/8 seconds    +
LB07B:  .byte $20                               ;E3             |
LB07C:  .byte $1E                               ;D#3            |
LB07D:  .byte $20                               ;E3             |
LB07E:  .byte $26                               ;G3             |
LB07F:  .byte $30                               ;C4             |
LB080:  .byte $38                               ;E4             |
LB081:  .byte $B2                               ;3/8 seconds    |
LB082:  .byte $3E                               ;G4             |
LB083:  .byte $38                               ;E4             |
LB084:  .byte $B0                               ;3/32 seconds   |
LB085:  .byte $24                               ;F#3            |
LB086:  .byte $20                               ;E3             |
LB087:  .byte $24                               ;F#3            |
LB088:  .byte $2A                               ;A3             |
LB089:  .byte $B9                               ;1/8 seconds    |
LB08A:  .byte $34                               ;D4             |
LB08B:  .byte $3A                               ;F4             |
LB08C:  .byte $3C                               ;F#4            |
LB08D:  .byte $B2                               ;3/8 seconds    |
LB08E:  .byte $42                               ;A4             |
LB08F:  .byte $3C                               ;F#4            |
LB090:  .byte $B2                               ;3/8 seconds    |
LB091:  .byte $3E                               ;G4             |
LB092:  .byte $B9                               ;1/8 seconds    |
LB093:  .byte $34                               ;D4             |
LB094:  .byte $02                               ;No sound       |
LB095:  .byte $2E                               ;B3             |
LB096:  .byte $B3                               ;3/4 seconds    |
LB097:  .byte $34                               ;D4             |
LB098:  .byte $B2                               ;3/8 seconds    |
LB099:  .byte $3E                               ;G4             |
LB09A:  .byte $3A                               ;F4             |
LB09B:  .byte $38                               ;E4             |
LB09C:  .byte $34                               ;D4             |
LB09D:  .byte $B9                               ;1/8 seconds    |
LB09E:  .byte $30                               ;C4             |
LB09F:  .byte $26                               ;G3             |
LB0A0:  .byte $30                               ;C4             |
LB0A1:  .byte $B9                               ;1/8 seconds    |
LB0A2:  .byte $34                               ;D4             |
LB0A3:  .byte $02                               ;No sound       |
LB0A4:  .byte $26                               ;G3             |
LB0A5:  .byte $B3                               ;3/4 seconds    | Repeat 2 times
LB0A6:  .byte $30                               ;C4             |
LB0A7:  .byte $B9                               ;1/8 seconds    |
LB0A8:  .byte $30                               ;C4             |
LB0A9:  .byte $20                               ;E3             |
LB0AA:  .byte $3E                               ;G4             |
LB0AB:  .byte $B9                               ;1/8 seconds    |
LB0AC:  .byte $34                               ;D4             |
LB0AD:  .byte $02                               ;No sound       |
LB0AE:  .byte $26                               ;G3             |
LB0AF:  .byte $3A                               ;F4             |
LB0B0:  .byte $38                               ;E4             |
LB0B1:  .byte $34                               ;D4             |
LB0B2:  .byte $30                               ;C4             |
LB0B3:  .byte $26                               ;G3             |
LB0B4:  .byte $24                               ;F#3            |
LB0B5:  .byte $22                               ;F3             |
LB0B6:  .byte $20                               ;E3             |
LB0B7:  .byte $22                               ;F3             |
LB0B8:  .byte $26                               ;G3             |
LB0B9:  .byte $22                               ;F3             |
LB0BA:  .byte $26                               ;G3             |
LB0BB:  .byte $28                               ;Ab3            |
LB0BC:  .byte $26                               ;G3             |
LB0BD:  .byte $28                               ;Ab3            |
LB0BE:  .byte $2C                               ;A#3            |
LB0BF:  .byte $28                               ;Ab3            |
LB0C0:  .byte $2C                               ;A#3            |
LB0C1:  .byte $B9                               ;1/8 seconds    |
LB0C2:  .byte $22                               ;F3             |
LB0C3:  .byte $20                               ;E3             |
LB0C4:  .byte $22                               ;F3             |
LB0C5:  .byte $20                               ;E3             |
LB0C6:  .byte $22                               ;F3             |
LB0C7:  .byte $20                               ;E3             |
LB0C8:  .byte $22                               ;F3             |
LB0C9:  .byte $1C                               ;D3             |
LB0CA:  .byte $22                               ;F3             |
LB0CB:  .byte $1C                               ;D3             |
LB0CC:  .byte $22                               ;F3             |
LB0CD:  .byte $1C                               ;D3             +
LB0CE:  .byte $FF                               ;

EscapeTriData:
LB0CF:  .byte $D0                               ;
LB0D0:  .byte $B2                               ;3/8 seconds    +
LB0D1:  .byte $3E                               ;G4             |
LB0D2:  .byte $B9                               ;1/8 seconds    | Repeat 16 times
LB0D3:  .byte $3E                               ;G4             |
LB0D4:  .byte $3E                               ;G4             |
LB0D5:  .byte $3E                               ;G4             +
LB0D6:  .byte $FF                               ;
LB0D7:  .byte $C2                               ;
LB0D8:  .byte $B2                               ;3/8 seconds    +
LB0D9:  .byte $2A                               ;A3             |
LB0DA:  .byte $B9                               ;1/8 seconds    |
LB0DB:  .byte $2A                               ;A3             |
LB0DC:  .byte $12                               ;A2             |
LB0DD:  .byte $2A                               ;A3             |
LB0DE:  .byte $B2                               ;3/8 seconds    |
LB0DF:  .byte $2A                               ;A3             |
LB0E0:  .byte $2A                               ;A3             |
LB0E1:  .byte $2A                               ;A3             |
LB0E2:  .byte $B9                               ;1/8 seconds    |
LB0E3:  .byte $2A                               ;A3             |
LB0E4:  .byte $2A                               ;A3             |
LB0E5:  .byte $2A                               ;A3             |
LB0E6:  .byte $B2                               ;3/8 seconds    |
LB0E7:  .byte $2A                               ;A3             |
LB0E8:  .byte $2A                               ;A3             |
LB0E9:  .byte $2A                               ;A3             |
LB0EA:  .byte $B9                               ;1/8 seconds    |
LB0EB:  .byte $2A                               ;A3             |
LB0EC:  .byte $2A                               ;A3             |
LB0ED:  .byte $2A                               ;A3             |
LB0EE:  .byte $B2                               ;3/8 seconds    |
LB0EF:  .byte $2A                               ;A3             |
LB0F0:  .byte $2A                               ;A3             |
LB0F1:  .byte $2A                               ;A3             |
LB0F2:  .byte $2A                               ;A3             |
LB0F3:  .byte $2A                               ;A3             |
LB0F4:  .byte $B9                               ;1/8 seconds    |
LB0F5:  .byte $2A                               ;A3             |
LB0F6:  .byte $12                               ;A2             |
LB0F7:  .byte $2A                               ;A3             |
LB0F8:  .byte $B2                               ;3/8 seconds    |
LB0F9:  .byte $26                               ;G3             |
LB0FA:  .byte $B9                               ;1/8 seconds    | Repeat 2 times
LB0FB:  .byte $0E                               ;G2             |
LB0FC:  .byte $26                               ;G3             |
LB0FD:  .byte $26                               ;G3             |
LB0FE:  .byte $B2                               ;3/8 seconds    |
LB0FF:  .byte $26                               ;G3             |
LB100:  .byte $B9                               ;1/8 seconds    |
LB101:  .byte $0E                               ;G2             |
LB102:  .byte $26                               ;G3             |
LB103:  .byte $26                               ;G3             |
LB104:  .byte $B2                               ;3/8 seconds    |
LB105:  .byte $22                               ;F3             |
LB106:  .byte $B9                               ;1/8 seconds    |
LB107:  .byte $0A                               ;F2             |
LB108:  .byte $22                               ;F3             |
LB109:  .byte $22                               ;F3             |
LB10A:  .byte $B2                               ;3/8 seconds    |
LB10B:  .byte $22                               ;F3             |
LB10C:  .byte $B9                               ;1/8 seconds    |
LB10D:  .byte $0A                               ;F2             |
LB10E:  .byte $22                               ;F3             |
LB10F:  .byte $22                               ;F3             |
LB110:  .byte $B2                               ;3/8 seconds    |
LB111:  .byte $20                               ;E3             |
LB112:  .byte $20                               ;E3             |
LB113:  .byte $B9                               ;1/8 seconds    |
LB114:  .byte $20                               ;E3             |
LB115:  .byte $20                               ;E3             |
LB116:  .byte $20                               ;E3             |
LB117:  .byte $B2                               ;3/8 seconds    |
LB118:  .byte $20                               ;E3             |
LB119:  .byte $B9                               ;1/8 seconds    |
LB11A:  .byte $34                               ;D4             |
LB11B:  .byte $30                               ;C4             |
LB11C:  .byte $34                               ;D4             |
LB11D:  .byte $38                               ;E4             |
LB11E:  .byte $34                               ;D4             |
LB11F:  .byte $38                               ;E4             |
LB120:  .byte $3A                               ;F4             |
LB121:  .byte $38                               ;E4             |
LB122:  .byte $3A                               ;F4             |
LB123:  .byte $3E                               ;G4             |
LB124:  .byte $3A                               ;F4             |
LB125:  .byte $3E                               ;G4             +
LB126:  .byte $FF                               ;
LB127:  .byte $C2                               ;
LB128:  .byte $B2                               ;3/8 seconds    +
LB129:  .byte $18                               ;C3             |
LB12A:  .byte $30                               ;C4             |
LB12B:  .byte $18                               ;C3             |
LB12C:  .byte $30                               ;C4             |
LB12D:  .byte $18                               ;C3             |
LB12E:  .byte $30                               ;C4             |
LB12F:  .byte $18                               ;C3             |
LB130:  .byte $30                               ;C4             |
LB131:  .byte $22                               ;F3             |
LB132:  .byte $22                               ;F3             |
LB133:  .byte $B1                               ;3/16 seconds   |
LB134:  .byte $22                               ;F3             |
LB135:  .byte $22                               ;F3             |
LB136:  .byte $B2                               ;3/8 seconds    |
LB137:  .byte $22                               ;F3             |
LB138:  .byte $20                               ;E3             |
LB139:  .byte $1C                               ;D3             |
LB13A:  .byte $18                               ;C3             |
LB13B:  .byte $16                               ;B2             |
LB13C:  .byte $14                               ;A#2            |
LB13D:  .byte $14                               ;A#2            |
LB13E:  .byte $14                               ;A#2            |
LB13F:  .byte $2C                               ;A#3            | Repeat 2 times
LB140:  .byte $2A                               ;A3             |
LB141:  .byte $2A                               ;A3             |
LB142:  .byte $B9                               ;1/8 seconds    |
LB143:  .byte $2A                               ;A3             |
LB144:  .byte $2A                               ;A3             |
LB145:  .byte $2A                               ;A3             |
LB146:  .byte $B2                               ;3/8 seconds    |
LB147:  .byte $2A                               ;A3             |
LB148:  .byte $28                               ;Ab3            |
LB149:  .byte $28                               ;Ab3            |
LB14A:  .byte $B9                               ;1/8 seconds    |
LB14B:  .byte $28                               ;Ab3            |
LB14C:  .byte $28                               ;Ab3            |
LB14D:  .byte $28                               ;Ab3            |
LB14E:  .byte $B2                               ;3/8 seconds    |
LB14F:  .byte $28                               ;Ab3            |
LB150:  .byte $26                               ;G3             |
LB151:  .byte $26                               ;G3             |
LB152:  .byte $B9                               ;1/8 seconds    |
LB153:  .byte $26                               ;G3             |
LB154:  .byte $26                               ;G3             |
LB155:  .byte $3E                               ;G4             |
LB156:  .byte $26                               ;G3             |
LB157:  .byte $26                               ;G3             |
LB158:  .byte $3E                               ;G4             +
LB159:  .byte $FF                               ;

EscapeNoiseData:
LB15A:  .byte $F0                               ;
LB15B:  .byte $B2                               ;3/8 seconds    +
LB15C:  .byte $01                               ;Drumbeat 00    |
LB15D:  .byte $04                               ;Drumbeat 01    | Repeat 48 times
LB15E:  .byte $01                               ;Drumbeat 00    |
LB15F:  .byte $04                               ;Drumbeat 01    +
LB160:  .byte $FF                               ;

MthrBrnRoomTriData:
LB161:  .byte $E0                               ;
LB162:  .byte $BA                               ;3/64 seconds   +
LB163:  .byte $2A                               ;A3             |
LB164:  .byte $1A                               ;C#3            |
LB165:  .byte $02                               ;No sound       |
LB166:  .byte $3A                               ;F4             |
LB167:  .byte $40                               ;Ab4            |
LB168:  .byte $02                               ;No sound       |
LB169:  .byte $1C                               ;D3             |
LB16A:  .byte $2E                               ;B3             |
LB16B:  .byte $38                               ;E4             |
LB16C:  .byte $2C                               ;A#3            |
LB16D:  .byte $3C                               ;F#4            |
LB16E:  .byte $38                               ;E4             |
LB16F:  .byte $02                               ;No sound       |
LB170:  .byte $40                               ;Ab4            |
LB171:  .byte $44                               ;A#4            |
LB172:  .byte $46                               ;B4             |
LB173:  .byte $02                               ;No sound       |
LB174:  .byte $1E                               ;D#3            |
LB175:  .byte $02                               ;No sound       | Repeat 32 times
LB176:  .byte $2C                               ;A#3            |
LB177:  .byte $38                               ;E4             |
LB178:  .byte $46                               ;B4             |
LB179:  .byte $26                               ;G3             |
LB17A:  .byte $02                               ;No sound       |
LB17B:  .byte $3A                               ;F4             |
LB17C:  .byte $20                               ;E3             |
LB17D:  .byte $02                               ;No sound       |
LB17E:  .byte $28                               ;Ab3            |
LB17F:  .byte $2E                               ;B3             |
LB180:  .byte $02                               ;No sound       |
LB181:  .byte $18                               ;C3             |
LB182:  .byte $44                               ;A#4            |
LB183:  .byte $02                               ;No sound       |
LB184:  .byte $46                               ;B4             |
LB185:  .byte $48                               ;C5             |
LB186:  .byte $4A                               ;C#5            |
LB187:  .byte $4C                               ;D5             |
LB188:  .byte $02                               ;No sound       |
LB189:  .byte $18                               ;C3             |
LB18A:  .byte $1E                               ;D#3            +
LB18B:  .byte $FF                               ;

MthrBrnRoomSQ1Data:
LB18C:  .byte $B8                               ;1/4 seconds
LB18D:  .byte $02                               ;No sound

;SQ1 music data runs down into the SQ2 music data.
MthrBrnRoomSQ2Data:
LB18E:  .byte $C8                               ;
LB18F:  .byte $B0                               ;3/32 seconds   +
LB190:  .byte $0A                               ;F2             | Repeat 8 times
LB191:  .byte $0C                               ;F#2            +
LB192:  .byte $FF                               ;
LB193:  .byte $C8                               ;
LB194:  .byte $0E                               ;G2             + Repeat 8 times
LB195:  .byte $0C                               ;F#2            +
LB196:  .byte $FF                               ;
LB197:  .byte $C8                               ;
LB198:  .byte $10                               ;Ab2            + Repeat 8 times
LB199:  .byte $0E                               ;G2             +
LB19A:  .byte $FF                               ;
LB19B:  .byte $C8                               ;
LB19C:  .byte $0E                               ;G2             + Repeat 8 times
LB19D:  .byte $0C                               ;F#2            +
LB19E:  .byte $FF                               ;
LB19F:  .byte $00                               ;End mother brain room music.

;Unused tile patterns.
LB1A0:  .byte $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0
LB1B0:  .byte $2C, $23, $20, $20, $30, $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30
LB1C0:  .byte $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00 
LB1D0:  .byte $01, $00, $00, $00, $00, $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80
LB1E0:  .byte $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04
LB1F0:  .byte $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00 

;-----------------------------------------[ Sound engine ]-------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include reset.asm

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.org $BFFA, $FF
LBFFA:  .word NMI                       ;($C0D9)NMI vector.
LBFFC:  .word RESET                     ;($FFB0)Reset vector.
LBFFE:  .word RESET                     ;($FFB0)IRQ vector.
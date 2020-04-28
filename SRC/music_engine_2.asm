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

;Music Engine (part 2)

ItemRoomTriangleIndexData:
LBDCD:  .byte $C8                       ;
LBDCE:  .byte $B0                       ;3/32 seconds   +
LBDCF:  .byte $38                       ;E3             |
LBDD0:  .byte $3A                       ;F3             |
LBDD1:  .byte $3C                       ;F#3            |
LBDD2:  .byte $3E                       ;G3             |
LBDD3:  .byte $40                       ;Ab3            | Repeat 8 times
LBDD4:  .byte $3E                       ;G3             |
LBDD5:  .byte $3C                       ;F#3            |
LBDD6:  .byte $3A                       ;F3             |
LBDD7:  .byte $B6                       ;1 3/16 seconds |
LBDD8:  .byte $02                       ;no sound       +
LBDD9:  .byte $FF                       ;

ItemRoomSQ1IndexData:
LBDDA:  .byte $B8                       ;1/4 seconds
LBDDB:  .byte $02                       ;No sound

ItemRoomSQ2IndexData:
LBDDC:  .byte $B3                       ;3/4 seconds
LBDDD:  .byte $02                       ;No sound
LBDDE:  .byte $B2                       ;3/8 seconds
LBDDF:  .byte $74                       ;A#6
LBDE0:  .byte $02                       ;No sound
LBDE1:  .byte $6A                       ;F5
LBDE2:  .byte $02                       ;No sound
LBDE3:  .byte $72                       ;A6
LBDE4:  .byte $02                       ;No sound
LBDE5:  .byte $62                       ;C#5
LBDE6:  .byte $B4                       ;1 1/2 seconds
LBDE7:  .byte $02                       ;No sound
LBDE8:  .byte $B2                       ;3/8 seconds
LBDE9:  .byte $60                       ;C5
LBDEA:  .byte $02                       ;No sound
LBDEB:  .byte $6C                       ;F#5
LBDEC:  .byte $02                       ;No sound
LBDED:  .byte $76                       ;B6
LBDEE:  .byte $B3                       ;3/4 seconds
LBDEF:  .byte $02                       ;No sound
LBDF0:  .byte $B2                       ;3/8 seconds
LBDF1:  .byte $7E                       ;F6
LBDF2:  .byte $02                       ;No sound
LBDF3:  .byte $7C                       ;D6
LBDF4:  .byte $B3                       ;3/4 seconds
LBDF5:  .byte $02                       ;No sound
LBDF6:  .byte $00                       ;End item room music.

PowerUpSQ1IndexData:
LBDF7:  .byte $B3                       ;1/2 seconds
LBDF8:  .byte $48                       ;C4
LBDF9:  .byte $42                       ;A4
LBDFA:  .byte $B2                       ;1/4 seconds
LBDFB:  .byte $3E                       ;G3
LBDFC:  .byte $38                       ;E3
LBDFD:  .byte $30                       ;C3
LBDFE:  .byte $38                       ;E3
LBDFF:  .byte $4C                       ;D4
LBE00:  .byte $44                       ;A#4
LBE01:  .byte $3E                       ;G3
LBE02:  .byte $36                       ;D#3
LBE03:  .byte $C8                       ;
LBE04:  .byte $B0                       ;1/16 seconds   +
LBE05:  .byte $38                       ;E3             | Repeat 8 times
LBE06:  .byte $3C                       ;F#3            +
LBE07:  .byte $FF

PowerUpTriangleIndexData:
LBE08:  .byte $B4                       ;1 second
LBE09:  .byte $2C                       ;A#3
LBE0A:  .byte $2A                       ;A3
LBE0B:  .byte $1E                       ;D#2
LBE0C:  .byte $1C                       ;D2

PowerUpSQ2IndexData:
LBE0D:  .byte $B2                       ;1/4 seconds
LBE0E:  .byte $22                       ;F2
LBE0F:  .byte $2C                       ;A#3
LBE10:  .byte $30                       ;C3
LBE11:  .byte $34                       ;D3
LBE12:  .byte $38                       ;E3
LBE13:  .byte $30                       ;C3
LBE14:  .byte $26                       ;G2
LBE15:  .byte $30                       ;C3
LBE16:  .byte $3A                       ;F3
LBE17:  .byte $34                       ;D3
LBE18:  .byte $2C                       ;A#3
LBE19:  .byte $26                       ;G2
LBE1A:  .byte $B4                       ;1 second
LBE1B:  .byte $2A                       ;A3
LBE1C:  .byte $00                       ;End power up music.

FadeInSQ2IndexData:
LBE1D:  .byte $C4
LBE1E:  .byte $B0                       ;3/32 seconds   +
LBE1F:  .byte $3E                       ;G3             | Repeat 4 times
LBE20:  .byte $30                       ;C3             +
LBE21:  .byte $FF                       ;
LBE22:  .byte $C4                       ;
LBE23:  .byte $42                       ;A4             + Repeat 4 times
LBE24:  .byte $30                       ;C3             +
LBE25:  .byte $FF                       ;
LBE26:  .byte $C4                       ;
LBE27:  .byte $3A                       ;F3             + Repeat 4 times
LBE28:  .byte $2C                       ;A#3            +
LBE29:  .byte $FF                       ;
LBE2A:  .byte $C4                       ;
LBE2B:  .byte $38                       ;E3             + Repeat 4 times
LBE2C:  .byte $26                       ;G2             +
LBE2D:  .byte $FF                       ;
LBE2E:  .byte $C4                       ;
LBE2F:  .byte $34                       ;D3             + Repeat 4 times
LBE30:  .byte $20                       ;E2             +
LBE31:  .byte $FF                       ;
LBE32:  .byte $E0                       ;
LBE33:  .byte $34                       ;D3             + Repeat 32 times
LBE34:  .byte $24                       ;F#2            +
LBE35:  .byte $FF                       ;

FadeInTriangleIndexData:
LBE36:  .byte $B3                       ;3/4 seconds
LBE37:  .byte $36                       ;D#3
LBE38:  .byte $34                       ;D3
LBE39:  .byte $30                       ;C3
LBE3A:  .byte $2A                       ;A3
LBE3B:  .byte $B4                       ;1 1/2 seconds
LBE3C:  .byte $1C                       ;D2
LBE3D:  .byte $1C                       ;D2

FadeInSQ1IndexData:
LBE3E:  .byte $B3                       ;3/4 seconds
LBE3F:  .byte $34                       ;D3
LBE40:  .byte $3A                       ;F3
LBE41:  .byte $34                       ;D3
LBE42:  .byte $30                       ;C3
LBE43:  .byte $B4                       ;1 1/2 seconds
LBE44:  .byte $2A                       ;A3
LBE45:  .byte $2A                       ;A3
LBE46:  .byte $00                       ;End fade in music.

TourianSQ2IndexData:
LBE47:  .byte $B4                       ;1 1/2 seconds
LBE48:  .byte $12                       ;A2
LBE49:  .byte $B3                       ;3/4 seconds
LBE4A:  .byte $10                       ;Ab1
LBE4B:  .byte $18                       ;C2
LBE4C:  .byte $16                       ;B2
LBE4D:  .byte $0A                       ;F1
LBE4E:  .byte $B4                       ;1 1/2 seconds
LBE4F:  .byte $14                       ;A#2
LBE50:  .byte $12                       ;A2
LBE51:  .byte $B3                       ;3/4 seconds
LBE52:  .byte $10                       ;Ab1
LBE53:  .byte $06                       ;D1
LBE54:  .byte $0E                       ;G1
LBE55:  .byte $04                       ;C#1
LBE56:  .byte $B4                       ;1 1/2 seconds
LBE57:  .byte $0C                       ;F#1
LBE58:  .byte $00                       ;End Tourian music.

TourianSQ1IndexData:
LBE59:  .byte $E0                       ;
LBE5A:  .byte $B0                       ;3/32 seconds   +
LBE5B:  .byte $54                       ;F#4            |
LBE5C:  .byte $4E                       ;D#4            |
LBE5D:  .byte $48                       ;C4             | Repeat 32 times
LBE5E:  .byte $42                       ;A4             |
LBE5F:  .byte $48                       ;C4             |
LBE60:  .byte $4E                       ;D#4            +
LBE61:  .byte $FF                       ;

TourianTriangleIndexData:
LBE62:  .byte $E0                       ;
LBE63:  .byte $B3                       ;3/4 seconds    +
LBE64:  .byte $02                       ;No sound       |
LBE65:  .byte $B0                       ;3/32 seconds   |
LBE66:  .byte $3C                       ;F#3            |
LBE67:  .byte $40                       ;Ab3            |
LBE68:  .byte $44                       ;A#4            |
LBE69:  .byte $4A                       ;C#4            |
LBE6A:  .byte $4E                       ;D#4            |
LBE6B:  .byte $54                       ;F#4            |
LBE6C:  .byte $58                       ;Ab4            | Repeat 32 times
LBE6D:  .byte $5C                       ;A#5            |
LBE6E:  .byte $62                       ;C#5            |
LBE6F:  .byte $66                       ;D#5            |
LBE70:  .byte $6C                       ;F#5            |
LBE71:  .byte $70                       ;Ab5            |
LBE72:  .byte $74                       ;A#6            |
LBE73:  .byte $7A                       ;C#6            |
LBE74:  .byte $B3                       ;3/4 seconds    |
LBE75:  .byte $02                       ;No sound       +
LBE76:  .byte $FF

;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)

MusicNotesTbl:
LBE77:  .byte $07                       ;55.0Hz (A1)    Index #$00 (Not used)
LBE78:  .byte $F0                       ;

LBE79:  .byte $00                       ;No sound       Index #$02
LBE7A:  .byte $00                       ;

LBE7B:  .byte $06                       ;69.3Hz (C#2)   Index #$04
LBE7C:  .byte $4E                       ;

LBE7D:  .byte $05                       ;73.4Hz (D2)    Index #$06
LBE7E:  .byte $F3                       ;

LBE7F:  .byte $05                       ;82.4Hz (E2)    Index #$08
LBE80:  .byte $4D                       ;

LBE81:  .byte $05                       ;87.3Hz (F2)    Index #$0A
LBE82:  .byte $01                       ;

LBE83:  .byte $04                       ;92.5Hz (F#2)   Index #$0C
LBE84:  .byte $B9                       ;

LBE85:  .byte $04                       ;98.0Hz (G2)    Index #$0E
LBE86:  .byte $75                       ;

LBE87:  .byte $04                       ;103.8Hz (Ab2)  Index #$10
LBE88:  .byte $35                       ;

LBE89:  .byte $03                       ;110.0Hz (A2)   Index #$12
LBE8A:  .byte $F8                       ;

LBE8B:  .byte $03                       ;116.5Hz (A#2)  Index #$14
LBE8C:  .byte $BF                       ;

LBE8D:  .byte $03                       ;123.5Hz (B2)   Index #$16
LBE8E:  .byte $89                       ;

LBE8F:  .byte $03                       ;130.7Hz (C3)   Index #$18
LBE90:  .byte $57                       ;

LBE91:  .byte $03                       ;138.5Hz (C#3)  Index #$1A
LBE92:  .byte $27                       ;

LBE93:  .byte $02                       ;146.8Hz (D3)   Index #$1C
LBE94:  .byte $F9                       ;

LBE95:  .byte $02                       ;155.4Hz (D#3)  Index #$1E
LBE96:  .byte $CF                       ;

LBE97:  .byte $02                       ;164.8Hz (E3)   Index #$20
LBE98:  .byte $A6                       ;

LBE99:  .byte $02                       ;174.5Hz (F3)   Index #$22
LBE9A:  .byte $80                       ;

LBE9B:  .byte $02                       ;184.9Hz (F#3)  Index #$24
LBE9C:  .byte $5C                       ;

LBE9D:  .byte $02                       ;196.0Hz (G3)   Index #$26
LBE9E:  .byte $3A                       ;       
        
LBE9F:  .byte $02                       ;207.6Hz (Ab3)  Index #$28
LBEA0:  .byte $1A                       ;

LBEA1:  .byte $01                       ;219.8Hz (A3)   Index #$2A
LBEA2:  .byte $FC                       ;

LBEA3:  .byte $01                       ;233.1Hz (A#3)  Index #$2C
LBEA4:  .byte $DF                       ;

LBEA5:  .byte $01                       ;247.0Hz (B3)   Index #$2E
LBEA6:  .byte $C4                       ;

LBEA7:  .byte $01                       ;261.4Hz (C4)   Index #$30
LBEA8:  .byte $AB                       ;

LBEA9:  .byte $01                       ;276.9Hz (C#4)  Index #$32
LBEAA:  .byte $93                       ;

LBEAB:  .byte $01                       ;293.6Hz (D4)   Index #$34
LBEAC:  .byte $7C                       ;

LBEAD:  .byte $01                       ;310.8Hz (D#4)  Index #$36
LBEAE:  .byte $67                       ;

LBEAF:  .byte $01                       ;330.0Hz (E4)   Index #$38
LBEB0:  .byte $52                       ;

LBEB1:  .byte $01                       ;349.6Hz (F4)   Index #$3A
LBEB2:  .byte $3F                       ;

LBEB3:  .byte $01                       ;370.4Hz (F#4)  Index #$3C
LBEB4:  .byte $2D                       ;

LBEB5:  .byte $01                       ;392.5Hz (G4)   Index #$3E
LBEB6:  .byte $1C                       ;

LBEB7:  .byte $01                       ;415.9Hz (Ab4)  Index #$40
LBEB8:  .byte $0C                       ;

LBEB9:  .byte $00                       ;440.4Hz (A4)   Index #$42
LBEBA:  .byte $FD                       ;

LBEBB:  .byte $00                       ;468.1Hz (A#4)  Index #$44
LBEBC:  .byte $EE                       ;

LBEBD:  .byte $00                       ;495.0Hz (B4)   Index #$46
LBEBE:  .byte $E1                       ;

LBEBF:  .byte $00                       ;525.2Hz (C5)   Index #$48
LBEC0:  .byte $D4                       ;

LBEC1:  .byte $00                       ;556.6Hz (C#5)  Index #$4A
LBEC2:  .byte $C8                       ;

LBEC3:  .byte $00                       ;588.8Hz (D5)   Index #$4C
LBEC4:  .byte $BD                       ;

LBEC5:  .byte $00                       ;625.0Hz (D#5)  Index #$4E
LBEC6:  .byte $B2                       ;

LBEC7:  .byte $00                       ;662.0Hz (E5)   Index #$50
LBEC8:  .byte $A8                       ;

LBEC9:  .byte $00                       ;699.2Hz (F5)   Index #$52
LBECA:  .byte $9F                       ;

LBECB:  .byte $00                       ;740.9Hz (F#5)  Index #$54
LBECC:  .byte $96                       ;

LBECD:  .byte $00                       ;787.9Hz (G5)   Index #$56
LBECE:  .byte $8D                       ;

LBECF:  .byte $00                       ;834.9Hz (Ab5)  Index #$58
LBED0:  .byte $85                       ;

LBED1:  .byte $00                       ;880.9HZ (A5)   Index #$5A
LBED2:  .byte $7E                       ;

LBED3:  .byte $00                       ;940.1Hz (A#5)  Index #$5C
LBED4:  .byte $76                       ;

LBED5:  .byte $00                       ;990.0Hz (B5)   Index #$5E
LBED6:  .byte $70                       ;

LBED7:  .byte $00                       ;1055Hz (C6)    Index #$60
LBED8:  .byte $69                       ;

LBED9:  .byte $00                       ;1118Hz (C#6)   Index #$62
LBEDA:  .byte $63                       ;

LBEDB:  .byte $00                       ;1178Hz (D6)    Index #$64
LBEDC:  .byte $5E                       ;

LBEDD:  .byte $00                       ;1257Hz (D#6)   Index #$66
LBEDE:  .byte $58                       ;

LBEDF:  .byte $00                       ;1332Hz (E6)    Index #$68
LBEE0:  .byte $53                       ;

LBEE1:  .byte $00                       ;1398Hz (F6)    Index #$6A
LBEE2:  .byte $4F                       ;

LBEE3:  .byte $00                       ;1492Hz (F#6)   Index #$6C
LBEE4:  .byte $4A                       ;

LBEE5:  .byte $00                       ;1576Hz (G6)    Index #$6E
LBEE6:  .byte $46                       ;

LBEE7:  .byte $00                       ;1670Hz (Ab6)   Index #$70
LBEE8:  .byte $42                       ;

LBEE9:  .byte $00                       ;1776Hz (A6)    Index #$72
LBEEA:  .byte $3E                       ;

LBEEB:  .byte $00                       ;1896Hz (A#6)   Index #$74
LBEEC:  .byte $3A                       ;

LBEED:  .byte $00                       ;1998Hz (B6)    Index #$76
LBEEE:  .byte $37                       ;

LBEEF:  .byte $00                       ;2111Hz (C7)    Index #$78
LBEF0:  .byte $34                       ;

LBEF1:  .byte $00                       ;2238Hz (C#7)   Index #$7A
LBEF2:  .byte $31                       ;

LBEF3:  .byte $00                       ;2380Hz (D7)    Index #$7C
LBEF4:  .byte $2E                       ;

LBEF5:  .byte $00                       ;2796Hz (F7)    Index #$7E
LBEF6:  .byte $27                       ;

;The following tables are used to load the music frame count addresses ($0640 thru $0643). The
;larger the number, the longer the music will play a solid note.  The number represents how
;many frames the note will play.  There is a small discrepancy in time length because the
;Nintendo runs at 60 frames pers second and I am using 64 frames per second to make the
;numbers below divide more evenly.

;Used by power up music and Kraid area music.

NoteLengths0Tbl:
LBEF7:  .byte $04                       ;About    1/16 seconds ($B0)
LBEF8:  .byte $08                       ;About    1/8  seconds ($B1)
LBEF9:  .byte $10                       ;About    1/4  seconds ($B2)
LBEFA:  .byte $20                       ;About    1/2  seconds ($B3)
LBEFB:  .byte $40                       ;About 1       seconds ($B4)
LBEFC:  .byte $18                       ;About    3/8  seconds ($B5)
LBEFD:  .byte $30                       ;About    3/4  seconds ($B6)
LBEFE:  .byte $0C                       ;About    3/16 seconds ($B7)
LBEFF:  .byte $0B                       ;About   11/64 seconds ($B8)
LBF00:  .byte $05                       ;About    5/64 seconds ($B9)
LBF01:  .byte $02                       ;About    1/32 seconds ($BA)

;Used by item room, fade in, Brinstar music, Ridley area music, Mother brain music,
;escape music, Norfair music and Tourian music.

NoteLengths1Tbl:
LBF02:  .byte $06                       ;About    3/32 seconds ($B0)
LBF03:  .byte $0C                       ;About    3/16 seconds ($B1)
LBF04:  .byte $18                       ;About    3/8  seconds ($B2)
LBF05:  .byte $30                       ;About    3/4  seconds ($B3)
LBF06:  .byte $60                       ;About 1  1/2  seconds ($B4)
LBF07:  .byte $24                       ;About    9/16 seconds ($B5)
LBF08:  .byte $48                       ;About 1  3/16 seconds ($B6)
LBF09:  .byte $12                       ;About    9/32 seconds ($B7)
LBF0A:  .byte $10                       ;About    1/4  seconds ($B8)
LBF0B:  .byte $08                       ;About    1/8  seconds ($B9)
LBF0C:  .byte $03                       ;About    3/64 seconds ($BA)

;Used by intro and end game music.

NoteLengths2Tbl:
LBF0D:  .byte $10                       ;About    1/4  seconds ($B0)
LBF0E:  .byte $07                       ;About    7/64 seconds ($B1)
LBF0F:  .byte $0E                       ;About    7/32 seconds ($B2)
LBF10:  .byte $1C                       ;About    7/16 seconds ($B3)
LBF11:  .byte $38                       ;About    7/8  seconds ($B4)
LBF12:  .byte $70                       ;About 1 13/16 seconds ($B5)
LBF13:  .byte $2A                       ;About   21/32 seconds ($B6)
LBF14:  .byte $54                       ;About 1  5/16 seconds ($B7)
LBF15:  .byte $15                       ;About   21/64 seconds ($B8)
LBF16:  .byte $12                       ;About    9/32 seconds ($B9)
LBF17:  .byte $02                       ;About    1/32 seconds ($BA)
LBF18:  .byte $03                       ;About    3/64 seconds ($BB)

InitializeMusic:                                        
LBF19:  JSR CheckMusicFlags             ;($B3FC)Check to see if restarting current music.
LBF1C:  LDA CurrentSFXFlags             ;Load current SFX flags and store CurrentMusic address.
LBF1F:  STA CurrentMusic                ;
LBF22:  LDA MusicInitIndex              ;
LBF25:  TAY                             ;
LBF26:  LDA InitMusicIndexTbl,Y         ;($BBFA)Find index for music in InitMusicInitIndexTbl.
LBF29:  TAY                             ;
LBF2A:  LDX #$00                        ;

LBF2C:* LDA InitMusicTbl,Y              ;Base is $BD31.
LBF2F:  STA NoteLengthTblOffset,X       ;
LBF32:  INY                             ;The following loop repeats 13 times to-->
LBF33:  INX                             ;load the initial music addresses -->
LBF34:  TXA                             ;(registers $062B thru $0637).
LBF35:  CMP #$0D                        ;
LBF37:  BNE -                           ;

LBF39:  LDA #$01                        ;Resets addresses $0640 thru $0643 to #$01.-->
LBF3B:  STA SQ1MusicFrameCount          ;These addresses are used for counting the-->
LBF3E:  STA SQ2MusicFrameCount          ;number of frames music channels have been playing.
LBF41:  STA TriangleMusicFrameCount     ;
LBF44:  STA NoiseMusicFrameCount        ;
LBF47:  LDA #$00                        ;
LBF49:  STA SQ1MusicIndexIndex          ;
LBF4C:  STA SQ2MusicIndexIndex          ;Resets addresses $0638 thru $063B to #$00.-->
LBF4F:  STA TriangleMusicIndexIndex     ;These are the index to find sound channel data index.
LBF52:  STA NoiseMusicIndexIndex        ;
LBF55:  RTS                             ;

;Not used.
LBF56:  .byte $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $2C, $B4, $AD
LBF66:  .byte $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9, $2A, $BC, $A8, $A2, $00, $B9
LBF76:  .byte $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40
LBF86:  .byte $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D
LBF96:  .byte $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF, $00, $00, $00, $00, $00, $00
LBFA6:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
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

;Kraid Music Data

KraidSQ1IndexData:
LB03F:  .byte $B8                       ;11/64 seconds
LB040:  .byte $02                       ;No sound

;SQ1 music data runs down into the SQ2 music data.
KraidSQ2IndexData:
LB041:  .byte $C4                       ;
LB042:  .byte $B3                       ;1/2 seconds    +
LB043:  .byte $38                       ;E4             |
LB044:  .byte $B2                       ;1/4 seconds    |
LB045:  .byte $2E                       ;B3             |
LB046:  .byte $B3                       ;1/2 seconds    |
LB047:  .byte $42                       ;A4             |
LB048:  .byte $B2                       ;1/4 seconds    |
LB049:  .byte $30                       ;C4             | Repeat 4 times
LB04A:  .byte $B3                       ;1/2 seconds    |
LB04B:  .byte $3C                       ;F#4            |
LB04C:  .byte $B2                       ;1/4 seconds    |
LB04D:  .byte $34                       ;D4             |
LB04E:  .byte $B3                       ;1/2 seconds    |
LB04F:  .byte $2E                       ;B3             |
LB050:  .byte $B2                       ;1/4 seconds    |
LB051:  .byte $2C                       ;A#3            +
LB052:  .byte $FF                       ;
LB053:  .byte $C2                       ;
LB054:  .byte $B3                       ;1/2 seconds    +
LB055:  .byte $3E                       ;G4             |
LB056:  .byte $B2                       ;1/4 seconds    |
LB057:  .byte $34                       ;D4             |
LB058:  .byte $B3                       ;1/2 seconds    |
LB059:  .byte $38                       ;E4             |
LB05A:  .byte $B2                       ;1/4 seconds    |
LB05B:  .byte $2E                       ;B3             | Repeat 2 times
LB05C:  .byte $B3                       ;1/2 seconds    |
LB05D:  .byte $3C                       ;F#4            |
LB05E:  .byte $B2                       ;1/4 seconds    |
LB05F:  .byte $34                       ;D4             |
LB060:  .byte $B3                       ;1/2 seconds    |
LB061:  .byte $42                       ;A4             |
LB062:  .byte $B2                       ;1/4 seconds    |
LB063:  .byte $38                       ;E4             +
LB064:  .byte $FF                       ;
LB065:  .byte $C4                       ;
LB066:  .byte $B1                       ;1/8 seconds    +
LB067:  .byte $3E                       ;G4             |
LB068:  .byte $2E                       ;B3             |
LB069:  .byte $3E                       ;G4             |
LB06A:  .byte $2E                       ;B3             |
LB06B:  .byte $3E                       ;G4             |
LB06C:  .byte $2E                       ;B3             |
LB06D:  .byte $44                       ;A#4            |
LB06E:  .byte $38                       ;E4             |
LB06F:  .byte $44                       ;A#4            |
LB070:  .byte $38                       ;E4             |
LB071:  .byte $44                       ;A#4            | Repeat 4 times
LB072:  .byte $38                       ;E4             |
LB073:  .byte $42                       ;A4             |
LB074:  .byte $30                       ;C4             |
LB075:  .byte $42                       ;A4             |
LB076:  .byte $30                       ;C4             |
LB077:  .byte $42                       ;A4             |
LB078:  .byte $30                       ;C4             |
LB079:  .byte $42                       ;A4             |
LB07A:  .byte $36                       ;D#4            |
LB07B:  .byte $3C                       ;F#4            |
LB07C:  .byte $36                       ;D#4            |
LB07D:  .byte $46                       ;B4             |
LB07E:  .byte $36                       ;D#4            +
LB07F:  .byte $FF                       ;
LB080:  .byte $C2                       ;
LB081:  .byte $3C                       ;F#4            +
LB082:  .byte $3E                       ;G4             |
LB083:  .byte $42                       ;A4             |
LB084:  .byte $46                       ;B4             |
LB085:  .byte $4C                       ;D5             |
LB086:  .byte $46                       ;B4             |
LB087:  .byte $54                       ;F#5            |
LB088:  .byte $4C                       ;D5             |
LB089:  .byte $42                       ;A4             |
LB08A:  .byte $3E                       ;G4             |
LB08B:  .byte $3C                       ;F#4            | Repeat 2 times
LB08C:  .byte $46                       ;B4             |
LB08D:  .byte $5A                       ;A5             |
LB08E:  .byte $54                       ;F#5            |
LB08F:  .byte $4C                       ;D5             |
LB090:  .byte $42                       ;A4             |
LB091:  .byte $3E                       ;G4             |
LB092:  .byte $3C                       ;F#4            |
LB093:  .byte $38                       ;E4             |
LB094:  .byte $3E                       ;G4             |
LB095:  .byte $42                       ;A4             |
LB096:  .byte $4C                       ;D5             |
LB097:  .byte $50                       ;E5             |
LB098:  .byte $02                       ;No sound       +
LB099:  .byte $FF                       ;
LB09A:  .byte $C4                       ;
LB09B:  .byte $B1                       ;1/8 seconds    +
LB09C:  .byte $5A                       ;A5             |
LB09D:  .byte $02                       ;No sound       |
LB09E:  .byte $56                       ;G5             |
LB09F:  .byte $02                       ;No sound       |
LB0A0:  .byte $54                       ;F#5            |
LB0A1:  .byte $02                       ;No sound       | Repeat 4 times
LB0A2:  .byte $50                       ;E5             |
LB0A3:  .byte $02                       ;No sound       |
LB0A4:  .byte $54                       ;F#5            |
LB0A5:  .byte $02                       ;No sound       |
LB0A6:  .byte $56                       ;G5             |
LB0A7:  .byte $02                       ;No sound       +
LB0A8:  .byte $FF                       ;
LB0A9:  .byte $00                       ;End Kraid area music.

KraidTriangleIndexData:
LB0AA:  .byte $D0                       ;
LB0AB:  .byte $B2                       ;1/4 seconds    +
LB0AC:  .byte $20                       ;E3             | Repeat 16 times
LB0AD:  .byte $B3                       ;1/2 seconds    |
LB0AE:  .byte $38                       ;E4             +
LB0AF:  .byte $FF                       ;
LB0B0:  .byte $C2                       ;
LB0B1:  .byte $B2                       ;1/4 seconds    +
LB0B2:  .byte $18                       ;C3             |
LB0B3:  .byte $B3                       ;1/2 seconds    |
LB0B4:  .byte $30                       ;C4             |
LB0B5:  .byte $B2                       ;1/4 seconds    |
LB0B6:  .byte $18                       ;C3             |
LB0B7:  .byte $B3                       ;1/2 seconds    |
LB0B8:  .byte $30                       ;C4             | Repeat 2 times
LB0B9:  .byte $B2                       ;1/4 seconds    |
LB0BA:  .byte $1C                       ;D3             |
LB0BB:  .byte $B3                       ;1/2 seconds    |
LB0BC:  .byte $34                       ;D4             |
LB0BD:  .byte $B2                       ;1/4 seconds    |
LB0BE:  .byte $1C                       ;D3             |
LB0BF:  .byte $B3                       ;1/2 seconds    |
LB0C0:  .byte $34                       ;D4             +
LB0C1:  .byte $FF                       ;
LB0C2:  .byte $C4                       ;
LB0C3:  .byte $B2                       ;1/4 seconds    +
LB0C4:  .byte $20                       ;E3             |
LB0C5:  .byte $38                       ;E4             |
LB0C6:  .byte $50                       ;E5             |
LB0C7:  .byte $24                       ;F#3            |
LB0C8:  .byte $3C                       ;F#4            | Repeat 4 times
LB0C9:  .byte $54                       ;F#5            |
LB0CA:  .byte $22                       ;F3             |
LB0CB:  .byte $3A                       ;F4             |
LB0CC:  .byte $52                       ;F5             |
LB0CD:  .byte $16                       ;B2             |
LB0CE:  .byte $2E                       ;B3             |
LB0CF:  .byte $46                       ;B4             +
LB0D0:  .byte $FF                       ;
LB0D1:  .byte $C2                       ;
LB0D2:  .byte $B3                       ;1/2 seconds    +
LB0D3:  .byte $20                       ;E3             |
LB0D4:  .byte $B2                       ;1/4 seconds    |
LB0D5:  .byte $2E                       ;B3             |
LB0D6:  .byte $B3                       ;1/2 seconds    |
LB0D7:  .byte $30                       ;C4             |
LB0D8:  .byte $B2                       ;1/4 seconds    |
LB0D9:  .byte $2E                       ;B3             | Repeat 2 times
LB0DA:  .byte $B3                       ;1/2 seconds    |
LB0DB:  .byte $18                       ;C3             |
LB0DC:  .byte $B2                       ;1/4 seconds    |
LB0DD:  .byte $26                       ;G3             |
LB0DE:  .byte $B3                       ;1/2 seconds    |
LB0DF:  .byte $2A                       ;A3             |
LB0E0:  .byte $B2                       ;1/4 seconds    |
LB0E1:  .byte $2E                       ;B3             +
LB0E2:  .byte $FF                       ;
LB0E3:  .byte $C8                       ;
LB0E4:  .byte $B4                       ;1 second       + Repeat 8 times
LB0E5:  .byte $08                       ;E2             +
LB0E6:  .byte $FF                       ;
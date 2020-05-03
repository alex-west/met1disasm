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

;Ridley Music Data

RidleyTriangleIndexData:
LB000:  .byte $B6                       ;1 3/16 seconds
LB001:  .byte $20                       ;E3
LB002:  .byte $B2                       ;3/8 seconds
LB003:  .byte $28                       ;Ab3
LB004:  .byte $B3                       ;3/4 seconds
LB005:  .byte $2C                       ;A#3
LB006:  .byte $34                       ;D4
LB007:  .byte $B4                       ;1 1/2 seconds
LB008:  .byte $30                       ;C4
LB009:  .byte $30                       ;C4
LB00A:  .byte $B3                       ;3/4 seconds
LB00B:  .byte $3C                       ;F#4
LB00C:  .byte $38                       ;E4
LB00D:  .byte $30                       ;C4
LB00E:  .byte $28                       ;Ab3
LB00F:  .byte $B4                       ;1 1/2 seconds
LB010:  .byte $24                       ;F#3
LB011:  .byte $24                       ;F#3
LB012:  .byte $1E                       ;D#3
LB013:  .byte $B3                       ;3/4 seconds
LB014:  .byte $2A                       ;A3
LB015:  .byte $26                       ;G3
LB016:  .byte $B4                       ;1 1/2 seconds
LB017:  .byte $2E                       ;B3
LB018:  .byte $2E                       ;B3
LB019:  .byte $B3                       ;3/4 seconds
LB01A:  .byte $32                       ;C#4
LB01B:  .byte $36                       ;D#4
LB01C:  .byte $2E                       ;B3
LB01D:  .byte $32                       ;C#4
LB01E:  .byte $B4                       ;1 1/2 seconds
LB01F:  .byte $2A                       ;A3
LB020:  .byte $2A                       ;A3
LB021:  .byte $00                       ;End Ridley area music.

RidleySQ1IndexData:
LB022:  .byte $BA                       ;3/64 seconds
LB023:  .byte $02                       ;No sound
LB024:  .byte $D0                       ;
LB025:  .byte $B1                       ;3/16 seconds   +
LB026:  .byte $3C                       ;F#4            |
LB027:  .byte $40                       ;Ab4            | Repeat 16 times
LB028:  .byte $44                       ;A#4            |
LB029:  .byte $40                       ;Ab4            +
LB02A:  .byte $FF                       ;
LB02B:  .byte $D0                       ;
LB02C:  .byte $42                       ;A4             +
LB02D:  .byte $46                       ;B4             | Repeat 16 times
LB02E:  .byte $4A                       ;C#5            |
LB02F:  .byte $46                       ;B4             +
LB030:  .byte $FF                       ;

RidleySQ2IndexData:
LB031:  .byte $D0                       ;
LB032:  .byte $B1                       ;3/16 seconds   +
LB033:  .byte $44                       ;A#4            |
LB034:  .byte $48                       ;C5             | Repeat 16 times
LB035:  .byte $4C                       ;D5             |
LB036:  .byte $48                       ;C5             +
LB037:  .byte $FF                       ;
LB038:  .byte $D0                       ;
LB039:  .byte $4A                       ;C#5            +
LB03A:  .byte $4E                       ;D#5            | Repeat 16 times
LB03B:  .byte $52                       ;F5             |
LB03C:  .byte $4E                       ;D#5            +
LB03D:  .byte $FF                       ;
LB03E:  .byte $00                       ;End Ridley area music.
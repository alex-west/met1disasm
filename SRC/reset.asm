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

;Common Reset Routine

RESET:
LBFB0:  SEI                             ;Disables interrupt.
LBFB1:  CLD                             ;Sets processor to binary mode.
LBFB2:  LDX #$00                        ;
LBFB4:  STX PPUControl0                 ;Clear PPU control registers.
LBFB7:  STX PPUControl1                 ;
LBFBA:
      + LDA PPUStatus                   ;
LBFBD:  BPL LBFBA                       ;Wait for VBlank.
LBFBF:
      + LDA PPUStatus                   ;
LBFC2:  BPL LBFBF                       ;
LBFC4:  ORA #$FF                        ;
LBFC6:  STA MMC1Reg0                    ;Reset MMC1 chip.-->
LBFC9:  STA MMC1Reg1                    ;(MSB is set).
LBFCC:  STA MMC1Reg2                    ;
LBFCF:  STA MMC1Reg3                    ;
LBFD2:  JMP Startup                     ;($C01A)Does preliminry housekeeping.

;Not used.
LBFD5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
LBFE5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LBFF5:  .byte $00, $00, $00, $00, $00
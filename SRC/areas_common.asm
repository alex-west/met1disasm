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

;Common area code (shared between banks)

;-----------------------------------------[ Start of code ]------------------------------------------

; These first three all jump to different points within the same procedure
CommonJump_00:
L8000:  JMP $F410
CommonJump_01:
L8003:  JMP $F438
CommonJump_02:
L8006:  JMP $F416

CommonJump_03:
L8009:  JMP $F852
CommonJump_UpdateEnemyAnim:
L800C:  JMP UpdateEnemyAnim             ;($E094)
CommonJump_05:
L800F:  JMP $F68D
CommonJump_06:
L8012:  JMP $F83E
CommonJump_07:
L8015:  JMP $F85A
CommonJump_08:
L8018:  JMP $FBB9
CommonJump_09:
L801B:  JMP $FB88
CommonJump_0A:
L801E:  JMP $FBCA
CommonJump_0B:
L8021:  JMP $F870
CommonJump_ChooseRoutine:
L8024:  JMP ChooseRoutine               ;($C27C)
CommonJump_0D:
L8027:  JMP $FD8F
CommonJump_0E:
L802A:  JMP $EB6E
CommonJump_0F:
L802D:  JMP $8244
CommonJump_10:
L8030:  JMP $8318
CommonJump_11:
L8033:  JMP $FA1E
CommonJump_12:
L8036:  JMP $833F
CommonJump_13:
L8039:  JMP $8395
CommonJump_14:
L803C:  JMP $DD8B
CommonJump_15:
L803F:  JMP $FEDC
CommonJump_SubtractHealth:
L8042:  JMP SubtractHealth              ;($CE92)
CommonJump_Base10Subtract:
L8045:  JMP Base10Subtract              ;($C3FB)

; Zoomer jump table
L8048:  .word L84FE-1, L84A7-1, L844B-1, L844B-1, L84A7-1, L84FE-1, L83F5-1, L83F5-1

;-------------------------------------------------------------------------------
L8058:  LDX PageIndex
L805A:  LDA EnData05,X
L805D:  ASL 
L805E:  BMI L80AF
L8060:  LDA EnStatus,X
L8063:  CMP #$02
L8065:  BNE L80AF
L8067:  JSR L8244
L806A:  LDA $00
L806C:  BPL L807D
L806E:  JSR TwosCompliment              ;($C3D4)
L8071:  STA $66
L8073:
      + JSR L83F5
L8076:  JSR L80B8
L8079:  DEC $66
L807B:  BNE L8073
L807D:
      + BEQ L808B
L807F:  STA $66
L8081:
      + JSR L844B
L8084:  JSR L80FB
L8087:  DEC $66
L8089:  BNE L8081
L808B:
      + JSR L8318
L808E:  LDA $00
L8090:  BPL L80A1
L8092:  JSR TwosCompliment              ;($C3D4)
L8095:  STA $66
L8097:
      + JSR L84A7
L809A:  JSR L816E
L809D:  DEC $66
L809F:  BNE L8097
L80A1:
      + BEQ L80AF
L80A3:  STA $66
L80A5:
      + JSR L84FE
L80A8:  JSR L8134
L80AB:  DEC $66
L80AD:  BNE L80A5
L80AF:
      + RTS

;-------------------------------------------------------------------------------
; A = TableAtL977B[EnemyType]*2
L80B0:  LDY EnDataIndex,X
L80B3:  LDA L977B,Y
L80B6:  ASL                             ;*2 
L80B7:  RTS

;-------------------------------------------------------------------------------

L80B8:  LDX PageIndex
L80BA:  BCS $80FA
L80BC:  LDA EnData05,X
L80BF:  BPL $80C7
L80C1:  JSR $81FC
L80C4:  JMP $80F6
L80C7:  JSR $80B0
L80CA:  BPL $80EA
L80CC:  LDA EnData1F,X
L80CF:  BEQ $80C1
L80D1:  BPL $80D8
L80D3:  JSR $81B1
L80D6:  BEQ $80E2
L80D8:  SEC 
L80D9:  ROR EnData02,X
L80DC:  ROR EnCounter,X
L80DF:  JMP $80F6
L80E2:  STA EnData02,X
L80E5:  STA EnCounter,X
L80E8:  BEQ $80F6
L80EA:  LDA $977B,Y
L80ED:  LSR 
L80EE:  LSR 
L80EF:  BCC $80F6
L80F1:  LDA #$04
L80F3:  JSR $856B
L80F6:  LDA #$01
L80F8:  STA $66
L80FA:  RTS
 
L80FB:  LDX PageIndex
L80FD:  BCS $8133
L80FF:  LDA EnData05,X
L8102:  BPL $810A
L8104:  JSR $81FC
L8107:  JMP $812F
L810A:  JSR $80B0
L810D:  BPL $8123
L810F:  LDA EnData1F,X
L8112:  BEQ $8104
L8114:  BPL $8120
L8116:  CLC 
L8117:  ROR EnData02,X
L811A:  ROR EnCounter,X
L811D:  JMP $812F
L8120:  JSR $81B1
L8123:  LDA $977B,Y
L8126:  LSR 
L8127:  LSR 
L8128:  BCC $812F
L812A:  LDA #$04
L812C:  JSR $856B
L812F:  LDA #$01
L8131:  STA $66
L8133:  RTS
 
L8134:  LDX PageIndex
L8136:  BCS $816D
L8138:  JSR $80B0
L813B:  BPL $815E
L813D:  LDA EnData05,X
L8140:  BMI $8148
L8142:  JSR $81C7
L8145:  JMP $8169
L8148:  LDA EnData1F,X
L814B:  BEQ $8142
L814D:  BPL $8159
L814F:  CLC 
L8150:  ROR EnData03,X
L8153:  ROR EnData07,X
L8156:  JMP $8169
L8159:  JSR $81C0
L815C:  BEQ $8169
L815E:  LDA $977B,Y
L8161:  LSR 
L8162:  BCC $8169
L8164:  LDA #$01
L8166:  JSR $856B
L8169:  LDA #$01
L816B:  STA $66
L816D:  RTS

L816E:  LDX PageIndex
L8170:  BCS $81B0
L8172:  JSR $80B0
L8175:  BPL $81A0
L8177:  LDA EnData05,X
L817A:  BMI $8182
L817C:  JSR $81C7
L817F:  JMP $81AC
L8182:  LDA EnData1F,X
L8185:  BEQ $817C
L8187:  BPL $818E
L8189:  JSR $81C0
L818C:  BEQ $8198
L818E:  SEC 
L818F:  ROR EnData03,X
L8192:  ROR EnData07,X
L8195:  JMP $81AC
L8198:  STA EnData03,X
L819B:  STA EnData07,X
L819E:  BEQ $81AC
L81A0:  JSR $80B0
L81A3:  LSR 
L81A4:  LSR 
L81A5:  BCC $81AC
L81A7:  LDA #$01
L81A9:  JSR $856B
L81AC:  LDA #$01
L81AE:  STA $66
L81B0:  RTS
 
L81B1:  JSR $81B8
L81B4:  STA EnData1A,X
L81B7:  RTS

L81B8:  LDA #$20
L81BA:  JSR $F744
L81BD:  LDA #$00
L81BF:  RTS

L81C0:  JSR $81B8
L81C3:  STA EnData1B,X
L81C6:  RTS

L81C7:  JSR $81F6
L81CA:  BNE $81F5
L81CC:  LDA #$01
L81CE:  JSR $856B
L81D1:  LDA EnData1B,X
L81D4:  JSR $C3D4
L81D7:  STA EnData1B,X

L81DA:  JSR $81F6
L81DD:  BNE $81F5
L81DF:  JSR $80B0
L81E2:  SEC 
L81E3:  BPL $81ED
L81E5:  LDA #$00
L81E7:  SBC EnData07,X
L81EA:  STA EnData07,X
L81ED:  LDA #$00
L81EF:  SBC EnData03,X
L81F2:  STA EnData03,X
L81F5:  RTS

L81F6:  JSR $F74B
L81F9:  AND #$20
L81FB:  RTS

L81FC:  JSR $81F6
L81FF:  BNE $81F5
L8201:  LDA #$04
L8203:  JSR $856B
L8206:  LDA EnData1A,X
L8209:  JSR $C3D4
L820C:  STA EnData1A,X

L820F:  JSR $81F6
L8212:  BNE $822A
L8214:  JSR $80B0
L8217:  SEC 
L8218:  BPL $8222
L821A:  LDA #$00
L821C:  SBC EnCounter,X
L821F:  STA EnCounter,X
L8222:  LDA #$00
L8224:  SBC EnData02,X
L8227:  STA EnData02,X
L822A:  RTS 

L822B:  LDA EnData05,X
L822E:  BPL $8232
L8230:  LSR 
L8231:  LSR 
L8232:  LSR 
L8233:  LDA $0408,X
L8236:  ROL 
L8237:  ASL 
L8238:  TAY 
L8239:  LDA $96DB,Y
L823C:  STA $81
L823E:  LDA $96DC,Y
L8241:  STA $82
L8243:  RTS

;-------------------------------------------------------------------------------
L8244:  JSR $80B0
L8247:  BPL $824C
L8249:  JMP $833F
L824C:  LDA EnData05,X
L824F:  AND #$20
L8251:  EOR #$20
L8253:  BEQ $82A2
L8255:  JSR $822B
L8258:  LDY EnCounter,X
L825B:  LDA ($81),Y
L825D:  CMP #$F0
L825F:  BCC $827F
L8261:  CMP #$FA
L8263:  BEQ $827C
L8265:  CMP #$FB
L8267:  BEQ $82B0
L8269:  CMP #$FC
L826B:  BEQ $82B3
L826D:  CMP #$FD
L826F:  BEQ $82A5
L8271:  CMP #$FE
L8273:  BEQ $82DE
L8275:  LDA #$00
L8277:  STA EnCounter,X
L827A:  BEQ $8258

L827C:  JMP $8312

L827F:  SEC 
L8280:  SBC EnDelay,X
L8283:  BNE $8290
L8285:  STA EnDelay,X
L8288:  INY 
L8289:  INY 
L828A:  TYA 
L828B:  STA EnCounter,X
L828E:  BNE $825B
L8290:  INC EnDelay,X
L8293:  INY 
L8294:  LDA ($81),Y
L8296:  ASL 
L8297:  PHP 
L8298:  JSR Adiv32                      ;($C2BE)Divide by 32.
L829B:  PLP 
L829C:  BCC $82A2
L829E:  EOR #$FF
L82A0:  ADC #$00
L82A2:  STA $00
L82A4:  RTS

L82A5:  INC EnCounter,X
L82A8:  INY 
L82A9:  LDA #$00
L82AB:  STA EnData1D,X
L82AE:  BEQ $825B
L82B0:  PLA 
L82B1:  PLA 
L82B2:  RTS

L82B3:  LDA EnData1F,X
L82B6:  BPL $82BE
L82B8:  JSR $E770
L82BB:  JMP $82C3
L82BE:  BEQ $82D2
L82C0:  JSR $E77B
L82C3:  LDX PageIndex
L82C5:  BCS $82D2
L82C7:  LDY EnCounter,X
L82CA:  INY 
L82CB:  LDA #$00
L82CD:  STA EnData1F,X
L82D0:  BEQ $82D7

L82D2:  LDY EnCounter,X
L82D5:  DEY 
L82D6:  DEY 
L82D7:  TYA 
L82D8:  STA EnCounter,X
L82DB:  JMP $825B

L82DE:  DEY 
L82DF:  DEY 
L82E0:  TYA 
L82E1:  STA EnCounter,X
L82E4:  LDA EnData1F,X
L82E7:  BPL $82EF
L82E9:  JSR $E770
L82EC:  JMP $82F4
L82EF:  BEQ $82FB
L82F1:  JSR $E77B
L82F4:  LDX PageIndex
L82F6:  BCC $82FB
L82F8:  JMP $8258
L82FB:  LDY EnDataIndex,X
L82FE:  LDA $968B,Y
L8301:  AND #$20
L8303:  BEQ $8312
L8305:  LDA EnData05,X
L8308:  EOR #$05
L830A:  ORA $968B,Y
L830D:  AND #$1F
L830F:  STA EnData05,X
L8312:  JSR $81B1
L8315:  JMP $82A2
L8318:  JSR $80B0
L831B:  BPL $8320
L831D:  JMP $8395
L8320:  LDA EnData05,X
L8323:  AND #$20
L8325:  EOR #$20
L8327:  BEQ $833C
L8329:  LDY EnCounter,X
L832C:  INY 
L832D:  LDA ($81),Y
L832F:  TAX 
L8330:  AND #$08
L8332:  PHP 
L8333:  TXA 
L8334:  AND #$07
L8336:  PLP 
L8337:  BEQ $833C
L8339:  JSR $C3D4
L833C:  STA $00
L833E:  RTS

L833F:  LDY #$0E
L8341:  LDA EnData1A,X
L8344:  BMI L835E
L8346:  CLC 
L8347:  ADC EnCounter,X
L834A:  STA EnCounter,X
L834D:  LDA EnData02,X
L8350:  ADC #$00
L8352:  STA EnData02,X
L8355:  BPL L8376
L8357:  JSR $C3D4
L835A:  LDY #$F2
L835C:  BNE L8376
L835E:  JSR $C3D4
L8361:  SEC 
L8362:  STA $00
L8364:  LDA EnCounter,X
L8367:  SBC $00
L8369:  STA EnCounter,X
L836C:  LDA EnData02,X
L836F:  SBC #$00
L8371:  STA EnData02,X
L8374:  BMI L8357
L8376:  CMP #$0E
L8378:  BCC L8383
L837A:  LDA #$00
L837C:  STA EnCounter,X
L837F:  TYA 
L8380:  STA EnData02,X
L8383:  LDA EnData18,X
L8386:  CLC 
L8387:  ADC EnCounter,X
L838A:  STA EnData18,X
L838D:  LDA #$00
L838F:  ADC EnData02,X
L8392:  STA $00
L8394:  RTS

L8395:  LDA #$00
L8397:  STA $00
L8399:  STA $02
L839B:  LDA #$0E
L839D:  STA $01
L839F:  STA $03
L83A1:  LDA EnData07,X
L83A4:  CLC 
L83A5:  ADC EnData1B,X
L83A8:  STA EnData07,X
L83AB:  STA $04
L83AD:  LDA #$00
L83AF:  LDY EnData1B,X
L83B2:  BPL $83B6
L83B4:  LDA #$FF
L83B6:  ADC EnData03,X
L83B9:  STA EnData03,X
L83BC:  TAY 
L83BD:  BPL $83D0
L83BF:  LDA #$00
L83C1:  SEC 
L83C2:  SBC EnData07,X
L83C5:  STA $04
L83C7:  LDA #$00
L83C9:  SBC EnData03,X
L83CC:  TAY 
L83CD:  JSR $E449
L83D0:  LDA $04
L83D2:  CMP $02
L83D4:  TYA 
L83D5:  SBC $03
L83D7:  BCC $83E3
L83D9:  LDA $00
L83DB:  STA EnData07,X
L83DE:  LDA $01
L83E0:  STA EnData03,X
L83E3:  LDA EnData19,X
L83E6:  CLC 
L83E7:  ADC EnData07,X
L83EA:  STA EnData19,X
L83ED:  LDA #$00
L83EF:  ADC EnData03,X
L83F2:  STA $00
L83F4:  RTS

;-------------------------------------------------------------------------------
L83F5:  LDX PageIndex
L83F7:  LDA EnYRoomPos,X
L83FA:  SEC 
L83FB:  SBC EnRadY,X
L83FE:  AND #$07
L8400:  SEC 
L8401:  BNE L8406
L8403:  JSR $E770
L8406:  LDY #$00
L8408:  STY $00
L840A:  LDX PageIndex
L840C:  BCC L844A
L840E:  INC $00
L8410:  LDY EnYRoomPos,X
L8413:  BNE L8429
L8415:  LDY #$F0
L8417:  LDA $49
L8419:  CMP #$02
L841B:  BCS L8429
L841D:  LDA $FC
L841F:  BEQ L844A
L8421:  JSR GetOtherNameTableIndex
L8424:  BEQ L844A
L8426:  JSR L855A
L8429:  DEY 
L842A:  TYA 
L842B:  STA EnYRoomPos,X
L842E:  CMP EnRadY,X
L8431:  BNE $8441
L8433:  LDA $FC
L8435:  BEQ $843C
L8437:  JSR GetOtherNameTableIndex
L843A:  BNE $8441
L843C:  INC EnYRoomPos,X
L843F:  CLC 
L8440:  RTS

L8441:  LDA EnData05,X
L8444:  BMI $8449
L8446:  INC EnData1D,X
L8449:  SEC 
L844A:  RTS

;-------------------------------------------------------------------------------
L844B:  LDX PageIndex
L844D:  LDA EnYRoomPos,X
L8450:  CLC 
L8451:  ADC EnRadY,X
L8454:  AND #$07
L8456:  SEC 
L8457:  BNE L845C
L8459:  JSR $E77B
L845C:  LDY #$00
L845E:  STY $00
L8460:  LDX PageIndex
L8462:  BCC L84A6
L8464:  INC $00
L8466:  LDY EnYRoomPos,X
L8469:  CPY #$EF
L846B:  BNE L8481
L846D:  LDY #$FF
L846F:  LDA $49
L8471:  CMP #$02
L8473:  BCS L8481
L8475:  LDA $FC
L8477:  BEQ L84A6
L8479:  JSR GetOtherNameTableIndex
L847C:  BNE L84A6
L847E:  JSR L855A
L8481:  INY 
L8482:  TYA 
L8483:  STA EnYRoomPos,X
L8486:  CLC 
L8487:  ADC EnRadY,X
L848A:  CMP #$EF
L848C:  BNE L849D
L848E:  LDA $FC
L8490:  BEQ L8497
L8492:  JSR GetOtherNameTableIndex
L8495:  BEQ L849D
L8497:  DEC EnYRoomPos,X
L849A:  CLC 
L849B:  BCC L84A6
L849D:  LDA EnData05,X
L84A0:  BMI L84A5
L84A2:  DEC EnData1D,X
L84A5:  SEC 
L84A6:  RTS

;-------------------------------------------------------------------------------
L84A7:  LDX PageIndex
L84A9:  LDA EnXRoomPos,X
L84AC:  SEC 
L84AD:  SBC EnRadX,X
L84B0:  AND #$07
L84B2:  SEC 
L84B3:  BNE $84B8
L84B5:  JSR $E8F1
L84B8:  LDY #$00
L84BA:  STY $00
L84BC:  LDX PageIndex
L84BE:  BCC L84FD
L84C0:  INC $00
L84C2:  LDY EnXRoomPos,X
L84C5:  BNE $84DA
L84C7:  LDA $49
L84C9:  CMP #$02
L84CB:  BCC $84DA
L84CD:  LDA $FD
L84CF:  BEQ $84D4
L84D1:  JSR GetOtherNameTableIndex
L84D4:  CLC 
L84D5:  BEQ L84FD
L84D7:  JSR $855A
L84DA:  DEC EnXRoomPos,X
L84DD:  LDA EnXRoomPos,X
L84E0:  CMP EnRadX,X
L84E3:  BNE $84F4
L84E5:  LDA $FD
L84E7:  BEQ $84EE
L84E9:  JSR GetOtherNameTableIndex
L84EC:  BNE $84F4
L84EE:  INC EnXRoomPos,X
L84F1:  CLC 
L84F2:  BCC L84FD
L84F4:  LDA EnData05,X
L84F7:  BPL $84FC
L84F9:  INC EnData1D,X
L84FC:  SEC 
L84FD:  RTS

;-------------------------------------------------------------------------------
L84FE:  LDX PageIndex
L8500:  LDA EnXRoomPos,X
L8503:  CLC 
L8504:  ADC EnRadX,X
L8507:  AND #$07
L8509:  SEC 
L850A:  BNE $850F
L850C:  JSR $E8FC
L850F:  LDY #$00
L8511:  STY $00
L8513:  LDX PageIndex
L8515:  BCC $8559
L8517:  INC $00
L8519:  INC EnXRoomPos,X
L851C:  BNE $8536
L851E:  LDA $49
L8520:  CMP #$02
L8522:  BCC $8536
L8524:  LDA $FD
L8526:  BEQ $852D
L8528:  JSR GetOtherNameTableIndex
L852B:  BEQ $8533
L852D:  DEC EnXRoomPos,X
L8530:  CLC 
L8531:  BCC $8559
L8533:  JSR $855A
L8536:  LDA EnXRoomPos,X
L8539:  CLC 
L853A:  ADC EnRadX,X
L853D:  CMP #$FF
L853F:  BNE $8550
L8541:  LDA $FD
L8543:  BEQ $854A
L8545:  JSR GetOtherNameTableIndex
L8548:  BEQ $8550
L854A:  DEC EnXRoomPos,X
L854D:  CLC 
L854E:  BCC $8559
L8550:  LDA EnData05,X
L8553:  BPL $8558
L8555:  DEC EnData1D,X
L8558:  SEC 
L8559:  RTS

L855A:  LDA EnNameTable,X
L855D:  EOR #$01
L855F:  STA EnNameTable,X
L8562:  RTS

;-------------------------------------------------------------------------------
; Returns the index to the other nametable in A
GetOtherNameTableIndex:
    LDA EnNameTable,X
    EOR $FF
    AND #$01
    RTS

L856B:  EOR EnData05,X
L856E:  STA EnData05,X
L8571:  RTS 

;---------------------------------[ Object animation data tables ]----------------------------------
;----------------------------[ Sprite drawing pointer tables ]--------------------------------------
;------------------------------[ Sprite placement data tables ]-------------------------------------
;-------------------------------[ Sprite frame data tables ]---------------------------------------
.include common_sprite_data.asm

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
L8B13:  LDA DoorStatus                  ;The code determines if Samus has entered a door if the-->
L8B15:  BNE L8B6C                       ;door status is 0, but door data information has been-->
L8B17:  LDY SamusDoorData               ;written. If both conditions are met, Samus has just-->
L8B19:  BEQ L8B6C                       ;entered a door.
L8B1B:  STA CurrentMissilePickups       ;
L8B1D:  STA CurrentEnergyPickups        ;Reset current missile and energy power-up counters.
L8B1F:  LDA RandomNumber1               ;
L8B21:  AND #$0F                        ;Randomly recalculate max missile pickups(16 max, 0 min).
L8B23:  STA MaxMissilePickup            ;
L8B25:  ASL                             ;
L8B26:  ORA #$40                        ;*2 for energy pickups and set bit 6(128 max, 64 min).
L8B28:  STA MaxEnergyPickup             ;
L8B2A:  LDA PPUCNT0ZP                   ;
L8B2C:  EOR #$01                        ;
L8B2E:  AND #$01                        ;Erase name table door data for new room.
L8B30:  TAY                             ;
L8B31:  LSR                             ;
L8B32:  STA $006C,Y                     ;
L8B35:  LDA ScrollDir                   ;
L8B37:  AND #$02                        ;Is Samus scrolling horizontally?-->
L8B39:  BNE L8B4B                       ;If so, branch.
L8B3B:  LDX #$04                        ;Samus currently scrolling vertically.
L8B3D:  LDA ScrollY                     ;Is room centered on screen?-->
L8B3F:  BEQ L8B6D                       ;If so, branch.
L8B41:  LDA $FF                         ;
L8B43:  EOR ObjectHi                    ;Get inverse of Samus' current nametable.
L8B46:  LSR                             ;
L8B47:  BCC L8B53                       ;If Samus is on nametable 3, branch.
L8B49:  BCS L8B52                       ;If Samus is on nametable 0, branch to decrement x.

L8B4B:
      + LDX #$02                        ;Samus is currently scrolling horizontally.
L8B4D:  LDA ObjectX                     ;Is Samus entering a left hand door?-->
L8B50:  BPL L8B53                       ;If so, branch.
L8B52:
      + DEX                             ;

SetDoorEntryInfo:
L8B53:
      + TXA                             ;X contains door scroll status and is transferred to A.
L8B54:  STA DoorScrollStatus            ;Save door scroll status.
L8B56:  JSR SamusInDoor                 ;($8B74)Indicate Samus just entered a door.
L8B59:  LDA #$12                        ;
L8B5B:  STA DoorDelay                   ;Set DoorDelay to 18 frames(going into door).
L8B5D:  LDA SamusDoorData               ;
L8B5F:  JSR Amul16                      ;($C2C5)*16. Move scroll toggle data to upper 4 bits.
L8B62:  ORA ObjAction                   ;Keep Samus action so she will appear the same comming-->
L8B65:  STA SamusDoorData               ;out of the door as she did going in.
L8B67:  LDA #$05                        ;
L8B69:  STA ObjAction                   ;Indicate Samus is in a door.
L8B6C:
      + RTS                             ;

L8B6D:
      + JSR SetDoorEntryInfo            ;($8B53)Save Samus action and set door entry timer.
L8B70:  JSR VerticalRoomCentered        ;($E21B)Room is centered. Toggle scroll.

L8B73:  TXA                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
L8B74:  ORA #$80                        ;Set MSB of DoorStatus to indicate Samus has just-->
L8B76:  STA DoorStatus                  ;entered a door.
L8B78:  RTS                             ;

;----------------------------------------------------------------------------------------------------

L8B79:  LDX #$B0
L8B7B:
      + JSR $8B87
L8B7E:  LDA PageIndex
L8B80:  SEC 
L8B81:  SBC #$10
L8B83:  TAX 
L8B84:  BMI L8B7B
L8B86:  RTS

L8B87:  STX PageIndex
L8B89:  LDA ObjAction,X
L8B8C:  JSR ChooseRoutine               ;($C27C)

L8B8F:  .word $C45C
L8B91:  .word $8B9D
L8B93:  .word $8BD5
L8B95:  .word $8C01
L8B97:  .word $8C84
L8B99:  .word $8CC6
L8B9B:  .word $8CF0

L8B9D:  INC $0300,X
L8BA0:  LDA #$30
L8BA2:  JSR SetProjectileAnim           ;($D2FA)
L8BA5:  JSR $8CFB
L8BA8:  LDY $0307,X
L8BAB:  LDA $8BD1,Y
L8BAE:  STA $030F,X
L8BB1:  LDA $0307,X
L8BB4:  CMP #$03
L8BB6:  BNE $8BBA
L8BB8:  LDA #$01
L8BBA:  ORA #$A0
L8BBC:  STA ObjectCntrl
L8BBE:  LDA #$00
L8BC0:  STA $030A,X
L8BC3:  TXA 
L8BC4:  AND #$10
L8BC6:  EOR #$10
L8BC8:  ORA ObjectCntrl
L8BCA:  STA ObjectCntrl
L8BCC:  LDA #$06
L8BCE:  JMP $DE47

L8BD1:  .byte $05, $01, $0A, $01

L8BD5:  LDA $030A,X
L8BD8:  AND #$04
L8BDA:  BEQ $8BB1
L8BDC:  DEC $030F,X
L8BDF:  BNE $8BB1
L8BE1:  LDA #$03
L8BE3:  CMP $0307,X
L8BE6:  BNE $8BEE
L8BE8:  LDY $010B
L8BEB:  INY 
L8BEC:  BNE $8BB1
L8BEE:  STA $0300,X
L8BF1:  LDA #$50
L8BF3:  STA $030F,X
L8BF6:  LDA #$2C
L8BF8:  STA $0305,X
L8BFB:  SEC 
L8BFC:  SBC #$03
L8BFE:  JMP $8C7E
L8C01:  LDA DoorStatus
L8C03:  BEQ $8C1D
L8C05:  LDA $030C
L8C08:  EOR $030C,X
L8C0B:  LSR 
L8C0C:  BCS $8C1D
L8C0E:  LDA $030E
L8C11:  EOR $030E,X
L8C14:  BMI $8C1D
L8C16:  LDA #$04
L8C18:  STA $0300,X
L8C1B:  BNE $8C73
L8C1D:  LDA $0306,X
L8C20:  CMP $0305,X
L8C23:  BCC $8C73
L8C25:  LDA $030F,X
L8C28:  CMP #$50
L8C2A:  BNE $8C57
L8C2C:  JSR $8CF7
L8C2F:  LDA $0307,X
L8C32:  CMP #$01
L8C34:  BEQ $8C57
L8C36:  CMP #$03
L8C38:  BEQ $8C57
L8C3A:  LDA #$0A
L8C3C:  STA $09
L8C3E:  LDA $030C,X
L8C41:  STA $08
L8C43:  LDY $50
L8C45:  TXA 
L8C46:  JSR $C2C5
L8C49:  BCC $8C4C
L8C4B:  DEY 
L8C4C:  TYA 
L8C4D:  JSR $DC1E
L8C50:  LDA #$00
L8C52:  STA $0300,X
L8C55:  BEQ $8C73
L8C57:  LDA $2D
L8C59:  LSR 
L8C5A:  BCS $8C73
L8C5C:  DEC $030F,X
L8C5F:  BNE $8C73
L8C61:  LDA #$01
L8C63:  STA $030F,X
L8C66:  JSR $8CFB
L8C69:  LDA #$02
L8C6B:  STA $0300,X
L8C6E:  JSR $8C76
L8C71:  LDX PageIndex
L8C73:  JMP $8BB1
L8C76:  LDA #$30
L8C78:  STA $0305,X
L8C7B:  SEC 
L8C7C:  SBC #$02
L8C7E:  JSR $D2FD
L8C81:  JMP $CBDA
L8C84:  LDA DoorStatus
L8C86:  CMP #$05
L8C88:  BCS $8CC3
L8C8A:  JSR $8CFB
L8C8D:  JSR $8C76
L8C90:  LDX PageIndex
L8C92:  LDA $91
L8C94:  BEQ $8CA7
L8C96:  TXA 
L8C97:  JSR $C2BF
L8C9A:  EOR $91
L8C9C:  LSR 
L8C9D:  BCC $8CA7
L8C9F:  LDA $76
L8CA1:  EOR #$07
L8CA3:  STA $76
L8CA5:  STA $1C
L8CA7:  INC $0300,X
L8CAA:  LDA #$00
L8CAC:  STA $91
L8CAE:  LDA $0307,X
L8CB1:  CMP #$03
L8CB3:  BNE $8CC3
L8CB5:  TXA 
L8CB6:  JSR $C2C5
L8CB9:  BCS $8CC0
L8CBB:  JSR $CC07
L8CBE:  BNE $8CC3
L8CC0:  JSR $CC03
L8CC3:  JMP $8C71
L8CC6:  LDA DoorStatus
L8CC8:  CMP #$05
L8CCA:  BNE $8CED
L8CCC:  TXA 
L8CCD:  EOR #$10
L8CCF:  TAX 
L8CD0:  LDA #$06
L8CD2:  STA $0300,X
L8CD5:  LDA #$2C
L8CD7:  STA $0305,X
L8CDA:  SEC 
L8CDB:  SBC #$03
L8CDD:  JSR $D2FD
L8CE0:  JSR $CBDA
L8CE3:  JSR $CB73
L8CE6:  LDX PageIndex
L8CE8:  LDA #$02
L8CEA:  STA $0300,X
L8CED:  JMP $8BB1
L8CF0:  LDA DoorStatus
L8CF2:  BNE $8CED
L8CF4:  JMP $8C61
L8CF7:  LDA #$FF
L8CF9:  BNE $8CFD
L8CFB:  LDA #$4E
L8CFD:  PHA 
L8CFE:  LDA #$50
L8D00:  STA $02
L8D02:  TXA 
L8D03:  JSR Adiv16
L8D06:  AND #$01
L8D08:  TAY 
L8D09:  LDA $8D3A,Y
L8D0C:  STA $03
L8D0E:  LDA $030C,X
L8D11:  STA $0B
L8D13:  JSR $E96A
L8D16:  LDY #$00
L8D18:  PLA 
L8D19:  STA ($04),Y
L8D1B:  TAX 
L8D1C:  TYA 
L8D1D:  CLC 
L8D1E:  ADC #$20
L8D20:  TAY 
L8D21:  TXA 
L8D22:  CPY #$C0
L8D24:  BNE $8D19
L8D26:  LDX PageIndex
L8D28:  TXA 
L8D29:  JSR $C2C0
L8D2C:  AND #$06
L8D2E:  TAY 
L8D2F:  LDA $04
L8D31:  STA $005C,Y
L8D34:  LDA $05
L8D36:  STA $005D,Y
L8D39:  RTS

L8D3A:  .byte $E8, $10, $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9 
L8D4A:  .byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
L8D5A:  .byte $85, $00, $AD, $97, $69, $29

; EoF
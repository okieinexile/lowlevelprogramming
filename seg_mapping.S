;------------------------------------------------
; Assembly Code
;-------------------------------------------------
#define __SFR_OFFSET 0X00
#include "avr/io.h"
;------------------------------------------------
.global startSEGDB
.global writeSEGDB
.global writeSEGDBalt
.global testsegments
;-------------------------------------------------
startSEGDB:         ;This combines the high byte of portd and the lowbyte of portb
  IN R16, DDRD        ;We want to leave the parts of Ports D&B that are outside
  IN R17, DDRB        ;DB undisturbed when we clear it
  ORI R16, 0xF0       ;
  ORI R17, 0x0F       ; 
  OUT DDRD, R16      ;set bits 4-7 of portd as output
  OUT DDRB, R17      ;set bits 0-3 of portb as output
  LDI R24, 0x00
  RET
;-------------------------------------------------
writeSEGDB:  
  COM R24            
  CALL write24
  RET
;-------------------------------------------------

;-------------------------------------------------;---------------
testsegments:
  LDI R24, 0x01
  COM R24
  loop:
    CALL write24
    CALL mydelay
    ROL R24
    RJMP loop
  LDI R24, 0x00
  CALL write24
  RET
;-------------------------------------------------
write24:
  IN R16, PORTD        ;Clear DB hybrid reg. We want to leave the parts of Ports D&B that are outside
  IN R17, PORTB        ;DB undisturbed when we clear it. So we copy ports D&B
  ANDI R16, 0x0F       ;and mask the parts we want to leave alone
  ANDI R17, 0xF0       ;
  OUT PORTD, R16
  OUT PORTB, R17       ;Done with clear
  MOV R16, R24         ;R16 and R17 will contain copies of the input
  MOV R17, R24         ;
  IN R19, PORTB        ;Copy the ports into separate registers
  IN R18, PORTD
  ANDI R17, 0xF0       ;mask out the appropriate parts of the registers
  SWAP R17
  ANDI R16, 0x0F
  SWAP R16
  OR R19, R17          ;include the appropriate parts
  OR R18, R16
  OUT PORTB, R19       ;
  OUT PORTD, R18
  RET
;----------------------------------------------------  

mydelay:
  LDI R20, 0xFF
  loop1:
    LDI R21, 0x2F
    loop2:
      LDI R22, 0xFF      ;value passed from caller load into R18
      loop3:
        DEC R22
        BRNE loop3
      DEC R21
      BRNE loop2
    DEC R20
    BRNE loop1
RET 
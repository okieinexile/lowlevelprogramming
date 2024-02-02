#define __SFR_OFFSET 0X00
#include "avr/io.h"
;---------------------------------
.section .data
;---------------------------------
;we will begin our table at 0x0100
.equ table_lowbyte, 0x00
.equ table_highbyte, 0x01
;---------------------------------
.section .text 
;---------------------------------
.global storehexdigits
.global mysegmentvalue
;---------------------------------
;This function will store the coding
;that will allow us to wire hex digits
;to a 7-segment LED using the code in 
;seg_mapping
storehexdigits:
  LDI R16, table_lowbyte    ;load the low byte
  LDI R17, table_highbyte   ;load the high byte
  MOV XL, R16               ;move low and high bytes into X
  MOV XH, R17
  ;put our values into SRAM starting with the coding for 0
  ;going through the coding for F.
  LDI R18, 0x77             
  ST X+, R18   
  LDI R18, 0x14             
  ST X+, R18   
  LDI R18, 0xB3             
  ST X+, R18   
  LDI R18, 0xB6             
  ST X+, R18   
  LDI R18, 0xD4             
  ST X+, R18   
  LDI R18, 0xE6             
  ST X+, R18   
  LDI R18, 0xE7             
  ST X+, R18 
  LDI R18, 0x34             
  ST X+, R18   
  LDI R18, 0xF7             
  ST X+, R18   
  LDI R18, 0xF4             
  ST X+, R18   
  LDI R18, 0xF5             
  ST X+, R18 
  LDI R18, 0xC7             
  ST X+, R18 
  LDI R18, 0x63             
  ST X+, R18 
  LDI R18, 0x97             
  ST X+, R18                
  LDI R18, 0xE3
  ST X+, R18 
  LDI R18, 0xE1
  ST X, R18
  RET
;-----------------------------------
;This will allow us to read the data 
;from the table above
mysegmentvalue:
  LDI R16, table_lowbyte
  LDI R17, table_highbyte
  LDI R18, 0x00
  ADD R16, R24
  ADC R17, R18
  MOV XL, R16
  MOV XH, R17
  LD R24, X 
  RET
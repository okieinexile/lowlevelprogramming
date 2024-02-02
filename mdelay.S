;------------------------------------------------
; Assembly Code
;-------------------------------------------------
#define __SFR_OFFSET 0X00
#include "avr/io.h"
;------------------------------------------------
.global mdelay
;------------------------------------------------
mdelay:
    LDI R20, 200 
    l1:
        LDI R21, 100
        l2:
            LDI R22, 100
            l3:
                DEC R22
                NOP
                NOP
                NOP
                NOP
                BRNE l3
            DEC R21
            BRNE l3
        DEC R20 
        BRNE l1
    RET
#include <Arduino.h>
//const uint8_t hexdigits[] = {0x77, 0x14, 0xB3, 0xB6,0xD4, 0xE6, 0xE7, 0x34, 0xF7, 0xF4, 0xF5, 0xC7, 0x63, 0x97, 0xE3, 0xE1};
extern "C"
{
  void storehexdigits(void);
  uint8_t mysegmentvalue(uint8_t);
  void mdelay(void);
  void startSEGDB(void);
  void writeSEGDB(uint8_t);
  void testsegments(void);
}

void prepare_board(void){
  storehexdigits();
  startSEGDB();
}

void writeHEX(uint8_t digit){
  writeSEGDB(mysegmentvalue(digit));
}

void count_in_HEX(void){
  for(uint8_t digit = 0; digit<16; digit++)
    {
      writeHEX(digit);
      mdelay();
    }
}
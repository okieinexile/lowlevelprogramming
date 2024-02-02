#include <Arduino.h>
#include "special_functions.h"

int main(void){
  startSEGDB();
  storehexdigits();
  while(1){
    count_in_HEX();
  }
  return 0;
}
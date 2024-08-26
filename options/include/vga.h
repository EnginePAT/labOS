#pragma once
#include "stdint.h"

// blue green cyan red magneta brown lightgrey darkgrey
#define BLACK 0
#define BLUE 1
#define GREED 2
#define CYAN 3
#define RED 4
#define MAGNETA 5
#define BROWN 6
#define LIGHT_GREY 7
#define DARK_GREY 8
#define LIGHT_BLUE 9
#define LIGHT_GREEN 10
#define LIGHT_CYAN 11
#define LIGHT_RED 12
#define LIGHT_MAGNETA 13
#define LIGHT_BROWN 14
#define WHITE 15

#define width 80
#define height 25

// standard input/output functions
void printf(const char* s);
void scanf(const char* s);

void scrollUp();
void newLine();
void Reset();
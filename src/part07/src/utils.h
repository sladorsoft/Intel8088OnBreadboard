#pragma once

#include <stdint.h>
#include <stdbool.h>


void delay(uint16_t steps);
uint16_t byte_to_hex_str(char* str, uint8_t val);
uint16_t word_to_hex_str(char* str, uint16_t val);

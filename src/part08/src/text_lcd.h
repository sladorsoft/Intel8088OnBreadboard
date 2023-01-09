#pragma once

#include <stdint.h>
#include <stdbool.h>


void text_lcd_clear_display();
void text_lcd_return_home();
void text_lcd_entry_mode_set(bool increment, bool disp_shift);
void text_lcd_display_ctrl(bool is_on, bool cursor_visible, bool cursor_blink);
void text_lcd_function_set();
void text_lcd_set_char_gen_addr(uint8_t addr);
void text_lcd_set_xy(uint8_t x, uint8_t y);
void text_lcd_send_char(char c);
void text_lcd_send_char_at(uint8_t x, uint8_t y, char c);
void text_lcd_send_text(const char* str);
void text_lcd_send_text_at(uint8_t x, uint8_t y, const char* str);

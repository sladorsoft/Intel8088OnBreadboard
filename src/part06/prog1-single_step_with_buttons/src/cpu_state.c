#include <stdint.h>
#include <string.h>

#include "cpu_state.h"
#include "utils.h"
#include "text_lcd.h"


uint16_t flags_to_string(char* str, uint16_t flags)
{
    const char flags_str[] = "oditszapc";
    const uint8_t bits_no[] = { 11, 10, 9, 8, 7, 6, 4, 2, 0 };
    strcpy(str, flags_str);
    for (int i = 0; i < sizeof(bits_no); i++)
    {
        if ((flags & (1 << bits_no[i])) != 0)
        {
            str[i] -= 0x20;
        }
    }
    
    return sizeof(flags_str);
}

void display_state(const struct cpu_state* state)
{
    char buff[21];
    buff[10] = ' ';
    word_to_hex_str(buff, state->cs);
    word_to_hex_str(buff + 5, state->ip);
    word_to_hex_str(buff + 11, state->ss);
    word_to_hex_str(buff + 16, state->sp);
    buff[4] = ':';
    buff[9] = ' ';
    buff[15] = ':';
    text_lcd_send_text_at(0, 0, buff);

    word_to_hex_str(buff, state->ds);
    word_to_hex_str(buff + 5, state->es);
    word_to_hex_str(buff + 16, state->bp);
    memset(buff + 9, ' ', 7);
    buff[4] = ' ';
    text_lcd_send_text_at(0, 1, buff);

    word_to_hex_str(buff, state->si);
    word_to_hex_str(buff + 5, state->di);
    flags_to_string(buff + 11, state->flags);
    buff[4] = ' ';
    buff[9] = ' ';
    text_lcd_send_text_at(0, 2, buff);

    word_to_hex_str(buff, state->ax);
    word_to_hex_str(buff + 5, state->bx);
    word_to_hex_str(buff + 11, state->cx);
    word_to_hex_str(buff + 16, state->dx);
    buff[4] = ' ';
    buff[9] = ' ';
    buff[15] = ' ';
    text_lcd_send_text_at(0, 3, buff);
}

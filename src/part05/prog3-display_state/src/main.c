#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "utils.h"
#include "text_lcd.h"
#include "cpu_state.h"


void lcd_init()
{
    delay(2000);
    text_lcd_function_set();
    delay(400);
    text_lcd_function_set();
    delay(10);
    text_lcd_function_set();
    delay(4);
    text_lcd_function_set();
    delay(4);
    text_lcd_display_ctrl(false, false, false);
    delay(4);
    text_lcd_clear_display();
    delay(4);
    text_lcd_return_home();
    delay(150);
    text_lcd_entry_mode_set(true, false);
    delay(4);
    text_lcd_display_ctrl(true, false, false);
    delay(4);
}

void main()
{
    lcd_init();

    struct cpu_state state;
    state.cs = 0xc5c5;
    state.ds = 0xd5d5;
    state.es = 0xe5e5;
    state.ss = 0x5555;
    state.ax = 0xa11a;
    state.bx = 0xb22b;
    state.cx = 0xc33c;
    state.dx = 0xd44d;
    state.si = 0x5151;
    state.di = 0xd1d1;
    state.sp = 0x5678;
    state.bp = 0x8765;
    state.ip = 0xfedc;
    state.flags = 0xf046;
    display_state(&state);
}

#pragma once

#include <stdint.h>


// Structure holding the states of all CPU registers
struct cpu_state
{
    uint16_t cs;
    uint16_t ds;
    uint16_t es;
    uint16_t ss;
    uint16_t ax;
    uint16_t bx;
    uint16_t cx;
    uint16_t dx;
    uint16_t si;
    uint16_t di;
    uint16_t sp;
    uint16_t bp;
    uint16_t ip;
    uint16_t flags;
};

// Displays the CPU state on the text LCD
void display_state(const struct cpu_state* state);

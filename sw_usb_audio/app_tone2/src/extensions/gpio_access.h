#ifndef _GPIO_ACCESS_H_
#define _GPIO_ACCESS_H_

#include "customdefines.h"

/* General output port bit definitions */
#define mclk_441_enable      (1 << 3)
#define mclk_48_enable       (1 << 2)
#define high_rate_en         (1 << 1)
#define clk_100M_en          (1 << 0)

void set_gpio(unsigned bit, unsigned value);
void set_gpio_mute(unsigned bit, unsigned value);

void p_gpio_lock();
void p_gpio_unlock();
unsigned p_gpio_peek();
void p_gpio_out(unsigned x);
unsigned p_gpio_peek2();
void p_gpio_out2(unsigned x);

#endif   /* _GPIO_ACCESS_H_ */

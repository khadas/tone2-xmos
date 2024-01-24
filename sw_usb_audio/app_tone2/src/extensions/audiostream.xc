/* over-ridden Deafult implementations of AudioStreamStop() and AudioStreamStart().  */

#include "uart_test.h"
#include "gpio_access.h"
#include "xc_ptr.h"
unsigned char t2_input_source, tone2_input_source;

void UserAudioStreamStop()
{
    // tone2 input source: xmos, spdif, btmagic, i2S, can not mute while not xmos input
    GET_SHARED_GLOBAL(t2_input_source, tone2_input_source);
    if (t2_input_source == 0x01)
    {
        set_gpio_mute(1,0);  // mute on
    }

    transmitter(0x4b);
    transmitter(0x20);
    transmitter(0x04);
    transmitter(0x73);

    return;
}

void UserAudioStreamStart()
{
    transmitter(0x4b);
    transmitter(0x20);
    transmitter(0x03);
    transmitter(0x73);

    set_gpio_mute(1,1);  // mute off

    return;
}


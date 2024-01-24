#include <xs1.h>
#include <platform.h>

#define BIT_RATE 115200
#define BIT_TIME 100000000/BIT_RATE

on tile[0] : out port TXD = XS1_PORT_4C;

void transmitter(unsigned int value)
{
    unsigned int byte,time;
    timer t;
    byte = value;
    t :> time;
    TXD <: 0;
    time += BIT_TIME;
    t when timerafter(time) :> void;

    for (int i = 0; i < 8; i++)
    {
        TXD <: byte;
        byte >>= 1;
        time += BIT_TIME;
        t when timerafter(time) :> void;
    }

    TXD <: 1;
    time += BIT_TIME;
    t when timerafter(time) :> void;
}

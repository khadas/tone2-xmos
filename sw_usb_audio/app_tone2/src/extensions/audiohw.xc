#include <xs1.h>
#include <assert.h>
#include "devicedefines.h"
#include <platform.h>
#include "gpio_access.h"
//#include "i2c_shared.h"
#include "print.h"
#include "dsd_support.h"
#include "uart_test.h"
#include "xc_ptr.h"


on tile[0] : out port p_gpio = XS1_PORT_4D;
on tile[0] : out port p_mute = XS1_PORT_4F;
out port p_outputs = on tile[0]: XS1_PORT_4E;


unsigned char data[] = {0, 0};
unsigned char sys_first_time_to_run = 0;
unsigned char global_clk_sync_hwconfig,global_clk_sync;
extern unsigned char global_dsdMode_sync;
extern unsigned int multOut[NUM_USB_CHAN_OUT + 1];
extern unsigned char t2_input_source, tone2_input_source;

void wait_us1(int microseconds)
{
    timer t;
    unsigned time;

    t :> time;
    t when timerafter(time + (microseconds * 100)) :> void;
}

void AudioHwInit(chanend ?c_codec)
{
    // set xmos and dac clock source enable for default:44.1
    set_gpio(mclk_441_enable,1);
    set_gpio(mclk_48_enable,0);
    set_gpio(clk_100M_en,0);

	// mute ctrl
	set_gpio_mute(1,1);

    // sync one uart cmd to active uart
    transmitter(0x53);
    wait_us1(10000);

    // request sn from tone2-stm8
    transmitter(0x53);
    transmitter(0x4e);
    transmitter(0x3d);

    // set xmos for stop play mode
    wait_us1(10000);
    transmitter(0x4b);
    transmitter(0x20);
    transmitter(0x04);
    transmitter(0x73);

}

/* Configures the external audio hardware for the required sample frequency.*/
void AudioHwConfig(unsigned samFreq, unsigned mClk, chanend ?c_codec, unsigned dsdMode,unsigned sampRes_DAC, unsigned sampRes_ADC)
{
#ifndef OUT_VOLUME_IN_MIXER
	xc_ptr p_multOut = array_to_xc_ptr(multOut);
#endif
	global_clk_sync_hwconfig = 0x00;
	GET_SHARED_GLOBAL(t2_input_source, tone2_input_source);

    if (mClk == MCLK_441){
        set_gpio(mclk_441_enable, 1);
        set_gpio(mclk_48_enable, 0);
    }else{
        set_gpio(mclk_441_enable, 0);
        set_gpio(mclk_48_enable, 1);
    }

    if((dsdMode == DSD_MODE_NATIVE) || (dsdMode == DSD_MODE_DOP))
    {
#if 0
        if ( (samFreq == 22579200) || (samFreq == 24576000) )
        {
			set_gpio(high_rate_en, 1);
			set_gpio(clk_100M_en, 1);
        }
        else
        {
			if(t2_input_source == 0x01)
            {
				set_gpio(high_rate_en, 0);
				set_gpio(clk_100M_en, 0);
			}
			global_clk_sync_hwconfig = 1;
        }
#else

        if (t2_input_source == 0x01)
        {
            set_gpio(high_rate_en, 0);
            set_gpio(clk_100M_en, 0);
        }
        global_clk_sync_hwconfig = 1;

#endif
        if ( (samFreq == 2822400) || (samFreq == 3072000) )
        {
            transmitter(0x4b);
            transmitter(0x40);
            transmitter(0x11);
            transmitter(0x73);
        }
        else if ( (samFreq == 5644800) || (samFreq == 6144000) )
        {
            transmitter(0x4b);
            transmitter(0x40);
            transmitter(0x12);
            transmitter(0x73);
        }
        else if ( (samFreq == 11289600) || (samFreq == 12288000) )
        {
            transmitter(0x4b);
            transmitter(0x40);
            transmitter(0x13);
            transmitter(0x73);
#if 0
        }
        else if ( (samFreq == 22579200) || (samFreq == 24576000) )
        {
            transmitter(0x4b);
            transmitter(0x40);
            transmitter(0x14);
            transmitter(0x73);
#endif
        }
        p_outputs <: 0b00000001;  //PCM_DSD

        // Disable DSD VOL CTRL, And Set to Max VOL
        SET_SHARED_GLOBAL(global_dsdMode_sync, 0x00);
        for (int i = 1; i < (NUM_USB_CHAN_OUT + 1); i++)
        {
            asm("stw %0, %1[%2]"::"r"(0x20000000), "r"(p_multOut), "r"(i - 1));
        }

		SET_SHARED_GLOBAL(global_clk_sync, global_clk_sync_hwconfig);
    }
    else
    {
#if 1
        if (samFreq > 192000)
        {
#else
        if ( (samFreq == 768000) || (samFreq == 705600) || (samFreq == 384000) || (samFreq == 352800) )
        {
#endif
            set_gpio(high_rate_en, 1);
            set_gpio(clk_100M_en, 1);
        }
        else
        {
            if (t2_input_source == 0x01) {
                set_gpio(high_rate_en, 0);
                set_gpio(clk_100M_en, 0);
            }
            global_clk_sync_hwconfig = 1;
        }

        if ( (samFreq == 44100) || (samFreq == 48000) )
        {
            if (sys_first_time_to_run == 1)
            {
	            transmitter(0x4B);
	            transmitter(0x40);
	            transmitter(0x01);
	            transmitter(0x73);
            }
        }
        else if( (samFreq == 88200) || (samFreq == 96000) )
        {
            transmitter(0x4B);
            transmitter(0x40);
            transmitter(0x02);
            transmitter(0x73);
        }
        else if( (samFreq == 176400) || (samFreq == 192000) )
        {
            transmitter(0x4B);
            transmitter(0x40);
            transmitter(0x03);
            transmitter(0x73);
        }
        else if ( (samFreq == 352800) || (samFreq == 384000) )
        {
            transmitter(0x4B);
            transmitter(0x40);
            transmitter(0x04);
            transmitter(0x73);
#if 0
        }
        else if ( (samFreq == 705600) || (samFreq == 768000) )
        {
            transmitter(0x4B);
            transmitter(0x40);
            transmitter(0x05);
            transmitter(0x73);
#endif
        }

        p_outputs <: 0b00000000;  //PCM_DSD
        SET_SHARED_GLOBAL(global_dsdMode_sync, 0x01);
		SET_SHARED_GLOBAL(global_clk_sync, global_clk_sync_hwconfig);
    }

    if(sys_first_time_to_run == 0)
    {
        sys_first_time_to_run = 1;
    }
    return;
}

//:

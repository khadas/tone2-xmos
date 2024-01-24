#include <xs1.h>
#include <platform.h>
#include "uart_rx.h"
#include "uart_tx.h"
#include <print.h>
#include "stdio.h"
#include "xc_ptr.h"
#include "uart_test.h"
#include <string.h>
#include <stdio.h>
#include "gpio_access.h"
#define MCU_UART_SN12	0x71
#define MCU_UART_SN34	0x72
#define MCU_UART_SN56	0x73
#define MCU_UART_SN78	0x74
#define MCU_UART_UPDATA	0x80
#define MCU_UART_VERC	0x81
#define MCU_UART_NEXTPREV	0x32
#define MCU_UART_PLAYSTOP	0x20
#define MCU_UART_VOL	0x31
#define MCU_UART_INPUT	0x34
#define MCU_UART_PWROFF	0x65
#define MCU_UART_AUTOI	0x66


unsigned serial_num_78, serial_num_56, serial_num_34, serial_num_12;
extern out port TXD;
unsigned num_serial_xmos;
extern unsigned char tone2_input_source;
extern unsigned char global_clk_sync_hwconfig, global_clk_sync;
unsigned char get_global_clk_sync;

unsigned char rx_num;
unsigned serial_num_78, serial_num_56, serial_num_34, serial_num_12;
unsigned update_mcu;
unsigned update_ready;
unsigned check_mcu_ver = 0;
unsigned pages;

void forward(chanend uartRX)
{
    unsigned cmd;
    uart_rx_client_state rxState;
    unsigned char rcvbuffer[4];
    int i;
    unsigned int gotest;
    gotest = 1;
    uart_rx_init(uartRX, rxState);

    while (gotest)
    {
        // receive 4 uart bytes, khadas uart protocol: Tone2-XU208,Tone2-STM8S003F3,MultiTone-STM8S003F,BTMagic-QCC5125
        for (i = 0; i < 4; i++)
        {
            rcvbuffer[i] = uart_rx_get_byte(uartRX, rxState);
        }

        // get uart cmd and respone this cmd
        cmd = rcvbuffer[1];
		switch (cmd)
        {
		case MCU_UART_SN12:
			serial_num_12 = rcvbuffer[2];
			break;

		case MCU_UART_SN34:
			serial_num_34 = rcvbuffer[2];
			break;

		case MCU_UART_SN56:
			serial_num_56 = rcvbuffer[2];
			break;

		case MCU_UART_SN78:
			serial_num_78 = rcvbuffer[2];
			break;

		case MCU_UART_UPDATA:
			if (rcvbuffer[2] == 0x00)
            {
                update_mcu = 1;
                update_ready = 1;
            }
            else
            {
                pages = rcvbuffer[2];
            }
			break;

		case MCU_UART_VERC:
			check_mcu_ver = 1;
			break;

		case MCU_UART_NEXTPREV:
			if (rcvbuffer[2] == 0x04)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x11); // prev
            }
            else if (rcvbuffer[2] == 0x03)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x22); // next
            }
            else
            {
				SET_SHARED_GLOBAL(hid_ctrl_data, 0x00); // next
			}
            SET_SHARED_GLOBAL(hid_status, 1);
			break;

		case MCU_UART_PLAYSTOP:
			if (rcvbuffer[2] == 0x06)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x33);	// Play
            }
            else if(rcvbuffer[2] == 0x05)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x44);  // stop
            }

            SET_SHARED_GLOBAL(hid_status, 1);
			break;

		case MCU_UART_VOL:
			if(rcvbuffer[2]==0xFC)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x55); //vol down
                SET_SHARED_GLOBAL(hid_status, 1);
            }
            else if(rcvbuffer[2]==0xFD)
            {
                SET_SHARED_GLOBAL(hid_ctrl_data, 0x66); //vol up
                SET_SHARED_GLOBAL(hid_status, 1);
            }
			break;

		case MCU_UART_AUTOI:
			if (rcvbuffer[2] == 0x01)
            {
                SET_SHARED_GLOBAL(tone2_input_source, 0x01);

				// Set CLK for XMOS and DAC while input source back to XMOS
                GET_SHARED_GLOBAL(get_global_clk_sync, global_clk_sync);
                if(get_global_clk_sync == 1)
                {
					set_gpio(high_rate_en, 0);
					set_gpio(clk_100M_en, 0);
                }
            }
            else
            {
                SET_SHARED_GLOBAL(tone2_input_source, 0x00); // Not XMOS Input Source
                set_gpio_mute(1, 1);  // MUTE OFF

				set_gpio(high_rate_en, 1);
				set_gpio(clk_100M_en, 1);
            }
			break;

		case MCU_UART_PWROFF:
			if(rcvbuffer[2] == 0x01)
            {
                set_gpio_mute(1, 0);  // MUTE EN
            }
			break;

		default:
			break;
		}

    }
}

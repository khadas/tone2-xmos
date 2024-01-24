
#include <xs1.h>
#include <platform.h>
#include "xc_ptr.h"
#include "devicedefines.h"
#include "uart_hid.h"

#ifdef HID_CONTROLS

in port p_sw = on tile[XUD_TILE] : XS1_PORT_4A;

#define P_GPI_BUTA_SHIFT        0x00
#define P_GPI_BUTA_MASK         (1<<P_GPI_BUTA_SHIFT)
#define P_GPI_BUTB_SHIFT        0x01
#define P_GPI_BUTB_MASK         (1<<P_GPI_BUTB_SHIFT)
#define P_GPI_BUTC_SHIFT        0x02
#define P_GPI_BUTC_MASK         (1<<P_GPI_BUTC_SHIFT)
#define P_GPI_SW1_SHIFT         0x03
#define P_GPI_SW1_MASK          (1<<P_GPI_SW1_SHIFT)

/* Write HID Report Data into hidData array
 *
 * Bits are as follows:
 * 0: Play/Pause
 * 1: Scan Next Track
 * 2: Scan Prev Track
 * 3: Volume Up
 * 4: Volime Down
 * 5: Mute
 */

unsigned multicontrol_count = 0;
unsigned wait_counter =0;

unsigned char get_hid_data,hid_ctrl_data,get_hid_data1,hid_ctrl_data1,hid_volume_val,get_hid_volume;
unsigned char hid_status,get_hid_status;
unsigned f_rx_num, g_rx_num;
unsigned char last_rx_num;
unsigned hid_tmp=0;


#define THRESH 1
#define MULTIPRESS_WAIT 25

#define HID_CONTROL_NEXT        0x02
#define HID_CONTROL_PLAYPAUSE   0x01
#define HID_CONTROL_PREV        0x04
#define HID_CONTROL_VOLUP       0x08
#define HID_CONTROL_VOLDN       0x10
#define HID_CONTROL_MUTE        0x20

typedef enum
{
    STATE_IDLE = 0x00,
    STATE_PLAY = 0x01,
    STATE_NEXTPREV = 0x02,
}t_controlState;

t_controlState state;

unsigned lastA;
void wait_us3(int microseconds)
{
    timer t;
    unsigned time;
    t :> time;
    t when timerafter(time + (microseconds * 100)) :> void;
}
void UserReadHIDButtons(unsigned char hidData[])
{
    GET_SHARED_GLOBAL(get_hid_status,hid_status);
        if(get_hid_status ==1)
        {
            SET_SHARED_GLOBAL(hid_status,0);
            GET_SHARED_GLOBAL(get_hid_data,hid_ctrl_data);
            if(get_hid_data == 0x11)
            {
                hidData[0] = HID_CONTROL_PREV;
            }
            if(get_hid_data == 0x22)
            {
                hidData[0] = HID_CONTROL_NEXT;
            }
            if(get_hid_data == 0x55)
            {
                hidData[0] = HID_CONTROL_VOLDN;
            }
            if(get_hid_data == 0x66)
            {
                hidData[0] = HID_CONTROL_VOLUP;
            }
	    if(get_hid_data == 0x00)
            {
                hidData[0] = 0;
            }
            if(hid_tmp != get_hid_data)
            {
                if(get_hid_data == 0x33)
                {
                    hidData[0] = HID_CONTROL_PLAYPAUSE;
                }
                if(get_hid_data == 0x44)
                {
                    hidData[0] = HID_CONTROL_PLAYPAUSE;
                }

                hid_tmp = get_hid_data;
            }
        }
        else
        {
            hidData[0] = 0;
        }
}

#endif

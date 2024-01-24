
#ifndef IO_SELECT_H_
#define IO_SELECT_H_
typedef struct
{
//    unsigned short usCustom_vendor_id;
//    unsigned short usCustom_Pid;
//    unsigned short usCustom_BCD_Device;
//    char ucCustion_vendor_str[64];
//    char ucCustion_produce_str[64];
    char ucCustion_serial_str[64];

}custom_string_def;

extern custom_string_def custom_string;

#endif /* IO_SELECT_H_ */

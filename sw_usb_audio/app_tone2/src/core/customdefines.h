/**
 * @file       customdefines.h
 * @brief      Defines relating to device configuration and customisation.
 *			   For Tone2 Device
 * @author     Ross Owen, XMOS Limited
 * @Modify     Kenny@khadas.com, Khadas Limited
 */
#ifndef _CUSTOMDEFINES_H_
#define _CUSTOMDEFINES_H_

#include "user_main.h"

/*
 * Device configuration option defines.  Build can be customised but changing and adding defines here
 *
 * Note, we check if they are already defined in Makefile
 */
#define PRODUCT_STR_A1      "Khadas USB Audio 1.0"
#define PRODUCT_STR_A2      "Tone2"

/* Tile defines */
#define AUDIO_IO_TILE       (0)
#define XUD_TILE            (0)
#define SPDIF_TX_TILE       (0)
#define MIDI_TILE           (0)

/* Mixer core enabled by default */
#ifndef MIXER
#define MIXER               (0)
#endif

/* Mixing disabled by default */
#ifndef MAX_MIX_COUNT
#define MAX_MIX_COUNT       (0)
#endif

/* Board is self-powered i.e. not USB bus-powered */
#ifndef SELF_POWERED
#define SELF_POWERED        (1)
#endif

/* Enable/Disable MIDI - Default is MIDI off */
#ifndef MIDI
#define MIDI                (0)
#endif

/* Enable/Disable SPDIF output - Default is S/PDIF on */
#ifndef SPDIF_TX
#define SPDIF_TX            (0)
#endif

/* Audio class version to run in - Default is 2.0 */
#ifndef AUDIO_CLASS
#define AUDIO_CLASS         (2)
#endif

/* Enable Audio class 2.0 when connected to a FS hub */
#ifndef FULL_SPEED_AUDIO_2
#define FULL_SPEED_AUDIO_2  (1)
#endif

/* Enable/disable fall back to Audio Class 1.0 when connected to FS hub. */
#ifndef AUDIO_CLASS_FALLBACK
#define AUDIO_CLASS_FALLBACK (0)
#endif


/* Defines relating to channel count and channel arrangement (Set to 0 for disable) */
//:audio_defs
#ifndef NUM_USB_CHAN_IN
#define NUM_USB_CHAN_IN     (0)         /* Device to Host */
#endif
#ifndef NUM_USB_CHAN_OUT
#define NUM_USB_CHAN_OUT    (2)         /* Host to Device */
#endif

/* Number of IS2 chans to DAC..*/
#ifndef I2S_CHANS_DAC
#define I2S_CHANS_DAC       (2)
#endif

/* Number of I2S chans from ADC */
#ifndef I2S_CHANS_ADC
#define I2S_CHANS_ADC       (0)
#endif

/* Number of DSD chans to DAC..*/
#ifndef DSD_CHANS_DAC
#define DSD_CHANS_DAC       (2)
#endif

/* Channel index of SPDIF Rx channels (duplicated DAC channels 1/2 when index is 0) */
#define SPDIF_TX_INDEX      (0)

/* Channel index of SPDIF Rx channels */
#define SPDIF_RX_INDEX      (0)

/* Channel index of ADAT Tx channels */
#if defined(SPDIF_TX) && (SPDIF_TX==1)
#define ADAT_TX_INDEX       (SPDIF_TX_INDEX + 2)
#else
#define ADAT_TX_INDEX       (I2S_CHANS_DAC)
#endif

/* Channel index of ADAT Rx channels */
#if defined(SPDIF_RX) && (SPDIF_RX==1)
#define ADAT_RX_INDEX       (SPDIF_RX_INDEX + 2)
#else
#define ADAT_RX_INDEX       (I2S_CHANS_ADC)
#endif

/* Master clock defines (in Hz) */
#define MCLK_441            (1024*44100)   /* 44.1, 88.2 etc */
#define MCLK_48             (1024*48000)   /* 48, 96 etc */

/* Maximum frequency device runs at */
#ifndef MAX_FREQ
#define MAX_FREQ            (769000)
#endif


/* Enable DFU interface, Note, requires a driver for Windows */
#define DFU                 (1)


/***** Defines relating to USB descriptors etc *****/
#define SERIAL_STR          ""       /* default to empty serial number - a value can be loaded into the str table from the OTP at runtime */
#define VENDOR_ID           (0x3353) /* Khadas VID */
#define PID_AUDIO_2         (0xa004) /* Khadas PID */
#define PID_AUDIO_1         (0xa004) /* Khadas PID */

#ifndef VENDOR_STR
#define VENDOR_STR          "Khadas"
#endif

#define DFU_SERIAL_STR_INDEX offsetof(StringDescTable_t, serialStr)/sizeof(char *)

/* Enable/Disable example HID code */
#ifndef HID_CONTROLS
#define HID_CONTROLS       1
#endif

#define STREAM_FORMAT_OUTPUT_1_RESOLUTION_BITS      32
#define STREAM_FORMAT_OUTPUT_2_RESOLUTION_BITS      24
#define STREAM_FORMAT_OUTPUT_3_RESOLUTION_BITS      32

/* Define to use custom flash part not in tools by default
 * Device is MX25V8035FZUI */
#define FL_QUADDEVICE_MX25V8035FZUI \
{ \
    99,                     /* application device ID */\
    256,                    /* page size */\
    4096,                  /* num pages */\
    3,                      /* address size */\
    8,                      /* log2 clock divider */\
    0x9F,                   /* SPI_RDID */\
    0,                      /* id dummy bytes */\
    3,                      /* id size in bytes */\
    0xC22314,               /* device id */\
    0x20,                   /* SPI_SE */\
    0,                      /* erase is full sector */\
    0x06,                   /* SPI_WREN */\
    0x04,                   /* SPI_WRDI */\
    PROT_TYPE_SR,           /* no protection */\
    {{0x3C,0x02},{0,0}},    /* SR values for protection */\
    0x02,                   /* SPI_PP */\
    0xEB,                   /* SPI_READ_FAST */\
    6,                      /* 6 read dummy byte*/\
    SECTOR_LAYOUT_REGULAR,  /* sane sectors */\
    {4096,{0,{0}}},         /* regular sector sizes */\
    0x05,                   /* SPI_RDSR */\
    0x01,                   /* SPI_WRSR */\
    0x01,                   /* SPI_WIP_BIT_MASK */\
}
#define DFU_FLASH_DEVICE FL_QUADDEVICE_MX25V8035FZUI


#endif  // _CUSTOMDEFINES_H_

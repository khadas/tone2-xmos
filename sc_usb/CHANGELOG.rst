sc_usb change log
=================

1.0.4
-----
    * ADDED:      Structs for Audio Class 2.0 Mixer and Extension Units

1.0.3
-----
    * CHANGE:     Various descriptor structures added, particularly for Audio Class
    * CHANGE:     Added ComposeSetupBuffer() for creating a buffer from a USB_Setup_Packet_t 
    * CHANGE:     Various function prototypes now using macros from xccompat.h such that then can be 
                  called from standard C

1.0.2
-----
    * ADDED:      USB_BMREQ_D2H_VENDOR_DEV and USB_BMREQ_D2H_VENDOR_DEV defines for vendor device requests

1.0.1
-----
    * CHANGE:     Updates to use XUD version 1.0.1

1.0.0
-----
    * Initial release

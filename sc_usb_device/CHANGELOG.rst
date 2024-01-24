sc_usb_device Change Log
========================

1.3.8
-----


  * Changes to dependencies:

    - sc_util: 1.0.5rc0 -> 1.0.6rc0

      + xCORE-200 compatibility fixes to module_trycatch

    - sc_xud: 2.3.2rc0 -> 2.4.0rc0

      + RESOLVED:   Intermittent initialisation issues with xCORE-200.
      + RESOLVED:   SETUP transaction data CRC not properly checked
      + RESOLVED:   RxError line from phy handled
      + RESOLVED:   Isochronous IN endpoints now send an 0-length packet if not ready rather than
        an (invalid) NAK.
      + RESOLVED:   Receive of short packets sometimes prematurely ended
      + RESOLVED:   Data PID not reset to DATA0 in ClearStallByAddr() (used on ClearFeature(HALT)
        request from host) (#17092)

1.3.7
-----

  * Changes to dependencies:

    - sc_xud: 2.3.0alpha0 -> 2.4.0beta0

      + RESOLVED:   Intermittent initialisation issues with xCORE-200.
      + RESOLVED:   SETUP transaction data CRC not properly checked
      + RESOLVED:   RxError line from phy handled
      + RESOLVED:   Isochronous IN endpoints now send an 0-length packet if not ready rather than
        an (invalid) NAK.
      + CHANGE:     Interrupts disabled during any access to usb_tile. Allows greater reliability
        if user suspend/resume functions enabled interrupts e.g. for role-switch
      + RESOLVED:   (Minor) XUD_ResetEpStateByAddr() could operate on corresponding OUT endpoint
        instead of the desired IN endpoint address as passed into the function (and
        vice versa). Re-introduced into 2.3.0 due to manual merge with lib_usb.

1.3.6
-----

  * Changes to dependencies:

    - sc_u_series_support: 1.0.2rc0 -> 1.0.3alpha1


    - sc_util: 1.0.4rc0 -> 1.0.5alpha0

      + xCORE-200 Compatiblity fixes to module_locks

    - sc_xud: 2.2.4rc3 -> 2.3.0alpha0

      + ADDED:      Support for XCORE-200 (libxud_x200.a)
      + CHANGE:     Compatibilty fixes for XMOS toolset version 14 (dual-issue support etc)

1.3.5
-----

    * RESOLVED:   (Minor) Design Guide documentation build errors

  * Changes to dependencies:

    - sc_xud: 2.2.3rc0 -> 2.2.4rc3

      + RESOLVED:   (Minor) Potential for lock-up when waiting for USB clock on startup. This is is
        avoided by enabling port buffering on the USB clock port. Affects L/G series only.

1.3.4
-----
  * Changes to dependencies:

    - sc_xud: 2.2.2alpha0 -> 2.2.4rc0

      + RESOLVED:   (Minor) XUD_ResetEpStateByAddr() could operate on corresponding OUT endpoint
        instead of the desired IN endpoint address as passed into the function (and
        vice versa)

1.3.3
-----
  * Changes to dependencies:

    - sc_xud: 2.2.1rc0 -> 2.2.2alpha0

      + CHANGE:     Header file comment clarification only

    - sc_usb: 1.0.3rc0 -> 1.0.4alpha0

      + ADDED:      Structs for Audio Class 2.0 Mixer and Extension Units

1.3.2
-----
  * Changes to dependencies:

    - sc_xud: 2.2.0rc0 -> 2.2.1rc0

      + RESOLVED:   Slight optimisations (long jumps replaced with short) to aid inter-packet gaps.

1.3.1
-----
  * Changes to dependencies:

    - sc_xud: 2.1.1rc0 -> 2.2.0rc0

      + CHANGE:     Timer usage optimisation - usage reduced by one.
      + CHANGE:     OTG Flags register explicitly cleared at start up - useful if previously running

1.3.0
-----
    - CHANGE:  Required updates for XUD API change relating to USB test-mode-support

  * Changes to dependencies:

    - sc_xud: 2.0.1rc3 -> 2.1.1rc0

      + ADDED:      Warning emitted when number of cores is greater than 6
      + CHANGE:     XUD no longer takes a additional chanend parameter for enabling USB test-modes.

1.2.2
-----
  * Changes to dependencies:

    - sc_xud: 2.0.0rc0 -> 2.0.1rc3

      + RESOLVED:   (Minor) Error when building module_xud in xTimeComposer due to invalid project

1.2.1
-----
    - RESOLVED:   (Minor) Build issue in Windows host app for bulk demo

1.2.0
-----
    - CHANGE:     USB_StandardRequests() now returns XUD_Result_t instead of int
    - CHANGE:     app_hid_mouse_demo now uses XUD_Result_t
    - CHANGE:     app_custom_bulk_demo now uses XUD_Result_t
    - CHANGE:     USB_StandardRequests() now takes the string table as an array of char pointers rather
                  than a fixed size 2D array. This allows for a more space efficient string table
                  representation. Please note, requires tools 13 or later for XC pointer support.
    - CHANGE:     Demo applications now set LangID string at build-time (rather than run-time)
    - CHANGE:     Test mode support no longer guarded by TEST_MODE_SUPPORT

  * Changes to dependencies:

    - sc_util: 1.0.3rc0 -> 1.0.4rc0

      + module_logging now compiled at -Os
      + debug_printf in module_logging uses a buffer to deliver messages unfragmented
      + Fix thread local storage calculation bug in libtrycatch
      + Fix debug_printf itoa to work for unsigned values > 0x80000000

1.1.0
-----
    - CHANGE:     Functions changed to use new XUD_Result_t type and return value from XUD user functions
    - CHANGE:     XUD_BusSpeed_t now used (previously used unsigned)
    - CHANGE:     Function prototypes now use macros from xccompat.h such that they can be called from
                  standard C
    - CHANGE:     Latest enums/defines from module_usb_shared now used
    - RESOLVED:   (Minor) devDescLength_fs now inspected instead of cfgDescLength when checking for
                  full-speed Device Descriptor

  * Changes to dependencies:

    - sc_xud: 1.0.3beta1 -> 2.0.0beta1

      + CHANGE:     All XUD functions now return XUD_Result_t. Functions that previously returned
      + CHANGE:     Endpoint ready flags are now reset on bus-reset (if XUD_STATUS_ENABLE used). This
      + CHANGE:     Reset notifications are now longer hand-shaken back to XUD_Manager in
      + CHANGE:     XUD_SetReady_In now implemented using XUD_SetReady_InPtr (previously was duplicated
      + CHANGE:     XUD_ResetEndpoint now in XC. Previously was an ASM wrapper.
      + CHANGE:     Modifications to xud.h including the use of macros from xccompat.h such that it
      + CHANGE:     XUD_BusSpeed type renamed to XUD_BusSpeed_t in line with naming conventions
      + CHANGE:     XUD_SetData_Select now takes a reference to XUD_Result_t instead an int
      + CHANGE:     XUD_GetData_Select now takes an additional XUD_Result_t parameter by reference
      + CHANGE:     XUD_GetData_Select now returns XUD_RES_ERR instead of a 0 length on packet error

    - sc_usb: 1.0.2beta1 -> 1.0.3beta1

      + CHANGE:     Various descriptor structures added, particularly for Audio Class
      + CHANGE:     Added ComposeSetupBuffer() for creating a buffer from a USB_Setup_Packet_t
      + CHANGE:     Various function prototypes now using macros from xccompat.h such that then can be

1.0.4
-----
    - CHANGE:     devDesc_hs and cfgDesc_hs params to USB_StandardRequests() now nullable (useful for full-speed only devices)
    - CHANGE:     Nullable descriptor array parameters to USB_StandardRequests() changed from ?array[] to (?&array)[] due to
                  the compiler warning that future compilers will interpret the former as an array of nullable items (rather
                  than a nullable reference to an array). Note: The NULLABLE_ARRAY_OF macro (from xccompat.h) is used retain
                  compatibility with older tools version (i.e. 12).

1.0.3
-----
  * Changes to dependencies:

    - sc_xud: 1.0.1beta3 -> 1.0.3alpha5

      + RESOLVED:   (Minor) ULPI data-lines driven hard low and XMOS pull-up on STP line disabled
      + RESOLVED:   (Minor) Fixes to improve memory usage such as adding missing resource usage
      + RESOLVED:   (Minor) Moved to using supplied tools support for communicating with the USB tile

    - sc_usb: 1.0.1beta1 -> 1.0.2beta0

      + ADDED:   USB_BMREQ_D2H_VENDOR_DEV and USB_BMREQ_D2H_VENDOR_DEV defines for vendor device requests

1.0.2
-----
  * CHANGE:    USB_StandardRequests() function now takes length of string table as an extra parameter such that bounds checking can be performed.
  * RESOLVED:  Removed invalid response to Microsoft OS String request. Request is now STALLed by default.
  * RESOLVED:  USB_StandardRequestsi() now makes calls to XUD_ResetEpStateByAddr() in SET_CONFIGURATION to resolve some PID toggling issues on bulk EP's

  * Changes to dependencies:

    - sc_xud: 1.0.0rc6 -> 1.0.1beta3

      + CHANGE:     Power signalling state machines simplified in order to reduce memory usage.
      + RESOLVED:   (Minor) Reduced delay before transmitting k-chirp for high-speed mode, this improves high-speed handshake reliability on some hosts
      + RESOLVED:   (Major) Resolved a compatibility issue with Intel USB 3.0 xHCI host controllers relating to tight inter-packet timing resulting in packet loss

    - sc_usb: 1.0.0rc0 -> 1.0.1beta1

      + CHANGE:     Updates to use XUD version 1.0.1

1.0.1
-----
    * Moving to sc_xud 1.0.0rc6

1.0.0
-----
    * Initial Version

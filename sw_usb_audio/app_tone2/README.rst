Tone2 USB Audio 2.0 Design (app_tone2)
===========================================================

:maintainer: kenny@khadas.com
:scope: General Use
:description: USB Audio for Tone2 device
:boards: Tone2

Overview
........

The firmware provides a high-speed USB audio device designed to be compliant to version 2.0 of the USB Audio Class Specification.

Key Features
............

The app_tone2 application is designed to run on the Tone2 device
Key features of this application are as follows:

- USB Audio Class 2.0 Compliant

- Fully Asynchronous operation

- for dual firmware:
    Stereo analogue output

- for multichannel firmware:
    8 channel I2S output or 6 channel DSD output

- Supports the following sample frequencies:
    PCM: 44.1, 48, 88.2, 96, 176.4, 192kHz, 352.8kHz, 384kHz, 705.6kHz, 768kHz
    DSD: 64, 128, 256, 512

- Field firmware upgrade compliant to the USB Device Firmware Upgrade (DFU) Class Specification

Known Issues
............
- multichannel firmware: not support AMD PC(intel PC is OK)

.......




# The TARGET variable determines what target system the application is
# compiled for. It either refers to an XN file in the source directories
# or a valid argument for the --target option when compiling
TARGET = Tone2
# BUILD FACTORY/UPGRADE
BUILD_TYPE ?= UPGRADE

MFI ?= 0
# The APP_NAME variable determines the name of the final .xe file. It should
# not include the .xe postfix. If left blank the name will default to
# the project name
APP_NAME = $(TARGET)
COMPILE_TIME = $(shell echo %date:~2,2%%date:~5,2%%date:~8,2%)
FIRMWARE_VERSION=0124
FLASH_IMAGE = bin/xu208/tone2-xmos-dual-v1.24-$(OMPILE_TIME).bin

all: $(FLASH_IMAGE)
# The flags passed to xcc when building the application
BUILD_FLAGS = -DBCD_DEVICE=0x$(FIRMWARE_VERSION) -DFLASH_MAX_UPGRADE_SIZE=64*1024 -fcomment-asm -Xmapper --map -Xmapper MAPFILE -Wall -O3 -report -lquadflash -fsubword-select -save-temps -g -fxscope -DXSCOPE -DSDA_HIGH=1 -DSCL_HIGH=2 -DXUD_SERIES_SUPPORT=4 -march=xs2a -DUSB_TILE=tile[0] -DADAT_TX_USE_SHARED_BUFF=1 -DQUAD_SPI_FLASH=1

# The USED_MODULES variable lists other module used by the application. These
# modules will extend the SOURCE_DIRS, INCLUDE_DIRS and LIB_DIRS variables.
# Modules are expected to be in the directory above the BASE_DIR directory.
USED_MODULES = 	module_usb_shared \
				module_xud \
				module_usb_audio \
				module_dfu \
				module_usb_device \
				module_locks \
				module_uart_rx \
				module_uart_tx

MODULE_LIBRARIES = xud_x200
#=============================================================================
XCC_FLAGS_xu208 = $(BUILD_FLAGS) -DSPDIF_TX=0
INCLUDE_ONLY_IN_xu208 =

#=============================================================================
ifeq ($(BUILD_TYPE),FACTORY)
# Create factory image
$(FLASH_IMAGE): bin/xu208/$(APP_NAME)_xu208.xe
	xflash $(SPEC_FILE_ARG) --factory $< -o $@
else
# Create upgrade image
$(FLASH_IMAGE): bin/xu208/$(APP_NAME)_xu208.xe
	xflash $(SPEC_FILE_ARG) --upgrade 1 $< --factory-version 14.3 -o $@
endif
#=============================================================================
# The following part of the Makefile includes the common build infrastructure
# for compiling XMOS applications. You should not need to edit below here.
#XMOS_MODULE_PATH = ..
#XCOMMON_DISABLE_AUTO_MODULE_SEARCH = 1

XMOS_MAKE_PATH ?= ../..
ifneq ($(wildcard $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common),)
include $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common
else
include ../module_xcommon/build/Makefile.common
endif

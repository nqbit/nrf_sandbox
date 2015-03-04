include build/init.mk

PROJECT := blinky
TARGET := PC10000
PROJECT_SRC := main.c

DEFINES := \
	-DNRF51 \
	-DBSP_DEFINES_ONLY \
	-DBOARD_PCA10000

LINKER_SCRIPT := sdk/components/toolchain/gcc/gcc_nrf51_blank_xxaa.ld

# Nordic Source Files
NORDIC_SRC += sdk/components/drivers_nrf/hal/nrf_delay.c
NORDIC_SRC += sdk/components/toolchain/gcc/gcc_startup_nrf51.s
NORDIC_SRC += sdk/components/toolchain/system_nrf51.c

# Nordic Include Directories
NORDIC_INC += sdk/components/drivers_nrf/hal
NORDIC_INC += sdk/components/toolchain/gcc
NORDIC_INC += sdk/components/toolchain
NORDIC_INC += sdk/examples/bsp

include $(BUILD_BIN)

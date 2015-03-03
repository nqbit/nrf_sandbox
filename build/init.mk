BUILD_DIR := build
PROJECT_DIR := projects
OUTPUT_DIR := out

TOOLCHAIN_PREFIX ?= /home/quasar/dev/gcc-arm-none-eabi-4_8-2014q1/bin/arm-none-eabi-
CC := $(TOOLCHAIN_PREFIX)gcc
LD := $(TOOLCHAIN_PREFIX)ld
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy

NO_LINKER := -c
LINKER_SCRIPT := sdk/components/toolchain/gcc/gcc_nrf51_blank_xxaa.ld

CFLAGS := \
	-mcpu=cortex-m0 \
	-mthumb \
	-mabi=aapcs \
	--std=gnu99 \
	-Wall \
	-Werror \
	-O3 \
	-mfloat-abi=soft \
	-g \
	-ffunction-sections \
	-fdata-sections \
	-fno-strict-aliasing \
	-flto \
	-fno-builtin

DEFINES := \
	-DNRF51 \
	-DBSP_DEFINES_ONLY \
	-DBOARD_PCA10000

ASMFLAGS := \
	-x assembler-with-cpp

LDFLAGS := \
	-Xlinker \
	-mthumb \
	-mabi=aapcs \
	-Lsdk/components/toolchain/gcc \
	-T$(LINKER_SCRIPT) \
	-mcpu=cortex-m0 \
	-Wl,--gc-sections \
	--specs=nano.specs \
	-lc \
	-lnosys

# Nordic Source Files
NORDIC_SRC := sdk/components/toolchain/gcc/gcc_startup_nrf51.s
NORDIC_SRC += sdk/components/toolchain/system_nrf51.c
NORDIC_SRC += sdk/components/drivers_nrf/hal/nrf_delay.c

# Nordic Include Directories
NORDIC_INC := sdk/components/drivers_nrf/hal
NORDIC_INC += sdk/components/toolchain/gcc
NORDIC_INC += sdk/components/toolchain
NORDIC_INC += sdk/examples/bsp

# Build
BUILD_BIN := $(BUILD_DIR)/compile.mk

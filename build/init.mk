BUILD_DIR := build
PROJECT_DIR := projects
OUTPUT_DIR := out


TOOLCHAIN_PREFIX ?= /home/quasar/dev/gcc-arm-none-eabi-4_8-2014q1/bin/arm-none-eabi-
CC ?= $(TOOLCHAIN_PREFIX)gcc

NO_LINKER := -c

GLOBAL_CFLAGS := \
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

GLOBAL_DEFINES := \
	-DNRF51 \
	-DBLE_STACK_SUPPORT_REQD \
	-DS110 -DSOFTDEVICE_PRESENT \
	-DBOARD_PCA10000

# Build
BUILD_BIN := $(BUILD_DIR)/compile.mk

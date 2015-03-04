BUILD_DIR := build
PROJECT_DIR := projects
OUTPUT_DIR := out

TOOLCHAIN_PREFIX ?=
CC := $(TOOLCHAIN_PREFIX)gcc
LD := $(TOOLCHAIN_PREFIX)ld
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy

NO_LINKER := -c

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
NORDIC_SRC ?=

# Nordic Include Directories
NORDIC_INC ?=

# Build
BUILD_BIN := $(BUILD_DIR)/compile.mk

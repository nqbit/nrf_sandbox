include build/init.mk

PROJECT := beacon
TARGET := PC10000
PROJECT_SRC := main.c

# TODO(nqbit):
DEFINES := \
	-DNRF51 \
	-DBLE_STACK_SUPPORT_REQD \
	-DS110 \
	-DSOFTDEVICE_PRESENT \
	-DBOARD_PCA10000

LINKER_SCRIPT := sdk/components/toolchain/gcc/gcc_nrf51_s110_xxaa.ld

# Nordic Source Files
NORDIC_SRC += sdk/components/ble/common/ble_conn_params.c
NORDIC_SRC += sdk/components/ble/common/ble_advdata.c
NORDIC_SRC += sdk/components/ble/common/ble_srv_common.c
NORDIC_SRC += sdk/components/drivers_nrf/hal/nrf_delay.c
NORDIC_SRC += sdk/components/drivers_nrf/uart/app_uart_fifo.c
NORDIC_SRC += sdk/components/libraries/button/app_button.c
NORDIC_SRC += sdk/components/libraries/fifo/app_fifo.c
NORDIC_SRC += sdk/components/libraries/gpiote/app_gpiote.c
NORDIC_SRC += sdk/components/libraries/timer/app_timer.c
NORDIC_SRC += sdk/components/libraries/scheduler/app_scheduler.c
NORDIC_SRC += sdk/components/libraries/util/app_error.c
NORDIC_SRC += sdk/components/libraries/util/nrf_assert.c
NORDIC_SRC += sdk/components/softdevice/common/softdevice_handler/softdevice_handler.c
NORDIC_SRC += sdk/components/toolchain/system_nrf51.c
NORDIC_SRC += sdk/components/toolchain/gcc/gcc_startup_nrf51.s
NORDIC_SRC += sdk/examples/bsp/bsp.c

# Nordic Include Directories
NORDIC_INC += sdk/components/ble/common
NORDIC_INC += sdk/components/drivers_nrf/hal
NORDIC_INC += sdk/components/libraries/button
NORDIC_INC += sdk/components/libraries/fifo
NORDIC_INC += sdk/components/libraries/gpiote
NORDIC_INC += sdk/components/libraries/scheduler
NORDIC_INC += sdk/components/libraries/timer
NORDIC_INC += sdk/components/libraries/util
NORDIC_INC += sdk/components/softdevice/common/softdevice_handler
NORDIC_INC += sdk/components/softdevice/s110/headers
NORDIC_INC += sdk/components/toolchain/gcc
NORDIC_INC += sdk/components/toolchain
NORDIC_INC += sdk/examples/bsp

include $(BUILD_BIN)

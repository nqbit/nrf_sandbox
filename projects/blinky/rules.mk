include build/init.mk

PROJECT := blinky
TARGET := PC10000
CFLAGS += -g
PROJECT_SRC := main.c
include $(BUILD_BIN)

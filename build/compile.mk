PROJECT_BUILD_DIR := $(OUTPUT_DIR)/$(PROJECT)
PROJECT_SRC_DIR := $(PROJECT_DIR)/$(PROJECT)
PROJECT_OUT_BIN := $(PROJECT_BUILD_DIR)/$(PROJECT).bin
PROJECT_OUT_ELF := $(PROJECT_BUILD_DIR)/$(PROJECT).elf
PROJECT_OUT_HEX := $(PROJECT_BUILD_DIR)/$(PROJECT).hex

vpath %.c ./sdk/components/drivers_nrf/hal
vpath %.c ./sdk/components/toolchain
vpath %.s ./sdk/components/toolchain/gcc
vpath %.c $(PROJECT_SRC_DIR)


$(PROJECT): $(PROJECT_BUILD_DIR) $(PROJECT_OUT_BIN)
	@echo Build Complete!

$(PROJECT_BUILD_DIR):
	mkdir -p $(PROJECT_BUILD_DIR)

# Add in the files required by the project
PROJECT_SRC_C := $(addprefix $(PROJECT_SRC_DIR)/, $(filter %.c, $(PROJECT_SRC)))
PROJECT_SRC_S := $(addprefix $(PROJECT_SRC_DIR)/, $(filter %.s, $(PROJECT_SRC)))
PROJECT_OBJ_C := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.c,%.o, $(filter %.c, $(PROJECT_SRC))))
PROJECT_OBJ_S := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.s,%.o, $(filter %.s, $(PROJECT_SRC))))

# Add in the files required by nordic
NORDIC_SRC_S := $(filter %.s, $(NORDIC_SRC))
NORDIC_SRC_C := $(filter %.c, $(NORDIC_SRC))
NORDIC_OBJ_C := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.c,%.o, $(filter %.c, $(notdir $(NORDIC_SRC)))))
NORDIC_OBJ_S := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.s,%.o, $(filter %.s, $(notdir $(NORDIC_SRC)))))

OBJECTS := $(PROJECT_OBJ_C) $(PROJECT_OBJ_S) $(NORDIC_OBJ_C) $(NORDIC_OBJ_S)

# Include files
INCLUDE_DIR := $(addprefix -I,$(NORDIC_INC))
LDFLAGS := \
	-Xlinker \
	-Map=$(PROJECT_BUILD_DIR)/$(PROJECT).map \
	-mthumb \
	-mabi=aapcs \
	-Lsdk/components/toolchain/gcc \
	-T$(LINKER_SCRIPT) \
	-mcpu=cortex-m0 \
	-Wl,--gc-sections \
	--specs=nano.specs \
	-lc \
	-lnosys

$(PROJECT_OBJ_C): $(PROJECT_BUILD_DIR)/%.o: %.c $(PROJECT_SRC_C)
	$(CC) $(DEFINES) $(CFLAGS) $(INCLUDE_DIR) $(NO_LINKER) -o $@ $<

$(NORDIC_OBJ_C): $(PROJECT_BUILD_DIR)/%.o: %.c $(NORDIC_SRC_C)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDE_DIR) $(NO_LINKER) -o $@ $<

$(NORDIC_OBJ_S): $(PROJECT_BUILD_DIR)/%.o: %.s $(NORDIC_SRC_S)
	$(CC) $(ASMFLAGS) $(DEFINES) $(INCLUDE_DIR) $(NO_LINKER) -o $@ $<

$(PROJECT_OBJECTS_S): $(PROJECT_SRC_S)
	$(CC) $(GLOBAL_SFLAGS) $(GLOBAL_DEFINES) $(NO_LINKER) $(INCLUDE_DIR) -o $@ $<

$(PROJECT_OUT_ELF): $(OBJECTS)
	@echo Linking target: $@
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@

$(PROJECT_OUT_BIN): $(PROJECT_OUT_ELF)
	$(OBJCOPY) -O binary $(PROJECT_OUT_ELF) $@

PROJECT_BUILD_DIR := $(OUTPUT_DIR)/$(PROJECT)
PROJECT_SRC_DIR := $(PROJECT_DIR)/$(PROJECT)
PROJECT_OUT_BIN := $(PROJECT_BUILD_DIR)/$(PROJECT).bin

$(PROJECT): $(PROJECT_BUILD_DIR) $(PROJECT_OUT_BIN)
	echo done

$(PROJECT_BUILD_DIR):
	mkdir -p $(PROJECT_BUILD_DIR)

# Add in the files required by the project
PROJECT_SRC_C := $(addprefix $(PROJECT_SRC_DIR)/, $(filter %.c, $(PROJECT_SRC)))
PROJECT_SRC_S := $(addprefix $(PROJECT_SRC_DIR)/, $(filter %.s, $(PROJECT_SRC)))
PROJECT_OBJECTS_C := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.c,%.o, $(filter %.c, $(PROJECT_SRC))))
PROJECT_OBJECTS_S := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.s,%.o, $(filter %.s, $(PROJECT_SRC))))

# Add in the files required by nordic
NORDIC_SRC_S := $(filter %.s, $(NORDIC_SRC))
NORDIC_SRC_C := $(filter %.c, $(NORDIC_SRC))
NORDIC_OBJECTS_C := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.c,%.o, $(filter %.c, $(notdir $(NORDIC_SRC)))))
NORDIC_OBJECTS_S := $(addprefix $(PROJECT_BUILD_DIR)/,$(patsubst %.s,%.o, $(filter %.s, $(notdir $(NORDIC_SRC)))))

OBJECTS := $(PROJECT_OBJECTS_C) $(PROJECT_OBJECTS_S) $(NORDIC_OBJECTS_C) $(NORDIC_OBJECTS_S)

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

$(PROJECT_OBJECTS_C): $(PROJECT_SRC_C)
	$(CC) $(CFLAGS) $(DEFINES) $(NO_LINKER) $(INCLUDE_DIR) -o $@ $<

$(NORDIC_OBJECTS_C): $(NORDIC_SRC_C)
	$(CC) $(CFLAGS) $(DEFINES) $(NO_LINKER) $(INCLUDE_DIR) -o $@ $<

$(NORDIC_OBJECTS_S): $(NORDIC_SRC_S)
	$(CC) $(ASMFLAGS) $(DEFINES) $(NO_LINKER) $(INCLUDE_DIR) -o $@ $<

# $(PROJECT_OBJECTS_S): $(PROJECT_SRC_S)
# 	$(CC) $(GLOBAL_SFLAGS) $(GLOBAL_DEFINES) $(NO_LINKER) $(INCLUDE_DIR) -o $@ $<

OBJECTS: $(PROJECT_OBJECTS_C) $(PROJECT_OBJECTS_S) $(NORDIC_OBJECTS_C) $(NORDIC_OBJECTS_S)

$(PROJECT_OUT_BIN): OBJECTS
	@echo Linking target: $@
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@


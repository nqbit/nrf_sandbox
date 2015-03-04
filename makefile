include build/init.mk

PROJECTS := blinky

.PHONY: all clean $(PROJECTS)

all:
	@for x in $(PROJECTS); do echo $$x; done

$(PROJECTS)-clean:
	rm -rf $(OUTPUT_DIR)/$(patsubst %-clean,%, $@)

clean:
	rm -rf out

$(PROJECTS):
	@echo "Building project: $@"
	$(MAKE) -rR -f $(PROJECT_DIR)/$@/rules.mk

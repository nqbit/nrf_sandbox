include build/init.mk

PROJECTS := beacon blinky

.PHONY: all build-all clean $(PROJECTS)

all:
	@for x in $(PROJECTS); do echo $$x; done

build-all:
	@for x in $(PROJECTS); do make $$x || (echo Build $$x FAILED!!! && exit 1); done

$(PROJECTS)-clean:
	rm -rf $(OUTPUT_DIR)/$(patsubst %-clean,%, $@)

clean::
	rm -rf out

$(PROJECTS):
	@echo "Building project: $@"
	$(MAKE) -rR -f $(PROJECT_DIR)/$@/rules.mk

include build/init.mk

PROJECTS := blinky test

.PHONY: all clean $(PROJECTS)

all:
	@for x in $(PROJECTS); do echo $$x; done

clean:
	rm -rf out

$(PROJECTS):
	@echo "Building project: $@"
	$(MAKE) -rR -f $(PROJECT_DIR)/$@/rules.mk

SUB_CUR_DIR 	:= $(shell pwd)

SUB_FILES 		:= $(wildcard $(SUB_CUR_DIR)/*.S $(SUB_CUR_DIR)/*.s $(SUB_CUR_DIR)/*.c) 

SUB_TARGET		:= $(OBJDIR)/$(notdir $(PROJECT_DIR)).o
SUB_OBJ_FILEs 	:= $(addsuffix .o, $(basename $(SUB_FILES)))
SUB_dFILEs		:= $(addsuffix .d, $(basename $(SUB_OBJ_FILEs)))

all: $(SUB_TARGET)

# $(SUB_TARGET): $(SUB_OBJ_FILEs)
#	$(LD) -r -o $@ $^
#	rm -f *.d $(SUB_OBJ_FILEs)

define PART_OBJ
$(1): $(wildcard $(2)/*.s $(2)/*.S $(2)/*.c)
	$(CC) -c -o $(1) $(wildcard $(2)/*.s $(2)/*.S $(2)/*.c) $(C_INCLUDE_CFG)
endef

$(eval $(call PART_OBJ, $(SUB_TARGET), $(SUB_CUR_DIR)))

.PHONY : print clean

print:
	@echo $(SUB_TARGET)
	@echo $(SUB_OBJ_FILES)
	@echo $(C_INCLUDE_CFG)
		

sinclude $(SUB_dFILEs)

%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@;  \
	rm -f $@.$$$$
	

%.d: %.s
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@; 	\
	rm -f $@.$$$$

%.d: %.S
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@; 	\
	rm -f $@.$$$$
	
%.o: %.c
	$(CC) -c -o $@ $< $(C_INCLUDE_CFG)

clean:
	-rm -rf *.d
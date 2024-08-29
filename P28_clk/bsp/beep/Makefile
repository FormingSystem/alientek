SUB_CUR_DIR := $(shell pwd)

SUB_SFILE 	:= $(wildcard *.S)
SUB_sFILE 	:= $(wildcard *.s)
SUB_CFILE 	:= $(wildcard *.c)

SUB_FILES 	:= $(SUB_SFILE) $(SUB_sFILE) $(SUB_CFILE)

SUB_TARGET 	:= $(notdir $(SUB_CUR_DIR)).o

SUB_OBJ_FILES :=  $(patsubst %, %.o, $(basename $(SUB_FILES)))


all: $(SUB_TARGET)

$(SUB_TARGET): $(SUB_OBJ_FILES)
	$(LD) -r -o $@ $^
#	$(LD) -r -o $(OBJDIR)/$@ $^
	rm -f *.d $(SUB_OBJ_FILES)


print:
	@echo $(SUB_TARGET)
	@echo $(SUB_OBJ_FILES)
	@echo $(C_INCLUDE_CFG)
		

sinclude $(SUB_FILES:%.c=%.d)



%.d: %.c
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$
	

%.d: %.s
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

%.d: %.S
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$
	
%.o: %.c
	$(CC) -c -o $@ $< $(C_INCLUDE_CFG)

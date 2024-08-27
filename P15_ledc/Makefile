ALL_TARGET := ledc

COMPILE_PD:= arm-none-linux-gnueabihf-

CURDIR 				:= .
OBJDIR 				:= $(CURDIR)/obj
SRCDIR				:= $(CURDIR)/source
INCLUDEDIR			:= $(CURDIR)/include
OUTPUT_BUILDDIR		:= $(CURDIR)/temp

C_SRCFILE 	:= $(wildcard $(SRCDIR)/*.c)
s_SRCFILE 	:= $(wildcard $(CURDIR)/*.s)
S_SRCFILE	:= $(wildcard $(CURDIR)/*.S)

C_OBJ	:= $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(C_SRCFILE))
s_OBJ	:= $(patsubst $(CURDIR)/%.s, $(OBJDIR)/%.o, $(s_SRCFILE))
S_OBJ	:= $(patsubst $(CURDIR)/%.S, $(OBJDIR)/%.o, $(S_SRCFILE))

OBJ	:= $(C_OBJ)
OBJ	+= $(S_OBJ)
OBJ	+= $(s_OBJ)

$(OUTPUT_BUILDDIR)/$(ALL_TARGET).bin:$(OBJ)
	@mkdir temp
	$(COMPILE_PD)ld -Timx6ul.lds -o $(OUTPUT_BUILDDIR)/$(ALL_TARGET).elf $^
	$(COMPILE_PD)objcopy -O binary -S $(OUTPUT_BUILDDIR)/$(ALL_TARGET).elf $@
	$(COMPILE_PD)objdump -D -m arm $(OUTPUT_BUILDDIR)/$(ALL_TARGET).elf > $(OUTPUT_BUILDDIR)/$(ALL_TARGET).dis
	
$(s_OBJ):$(s_SRCFILE)
	$(COMPILE_PD)gcc -Wall -nostdlib -c -O2 -o $@ $< -I$(INCLUDEDIR)
	
$(S_OBJ):$(S_SRCFILE)
	$(COMPILE_PD)gcc -Wall -nostdlib -c -O2 -o $@ $< -I$(INCLUDEDIR)
	
$(C_OBJ):$(C_SRCFILE)
	$(COMPILE_PD)gcc -Wall -nostdlib -c -O2 -o $@ $< -I$(INCLUDEDIR)
	

.PHONY : download clean

download: $(OUTPUT_BUILDDIR)/$(ALL_TARGET).bin
	./imxdownload $(OUTPUT_BUILDDIR)/$(ALL_TARGET).bin /dev/sdd

clean:
	rm -rf $(OBJDIR)/*.o $(OUTPUT_BUILDDIR)/*
	
	

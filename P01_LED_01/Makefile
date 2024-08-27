OBJ := led

CROSS_COMPILE 	:= arm-none-linux-gnueabihf-
CC 				:= $(CROSS_COMPILE)gcc
LD				:= $(CROSS_COMPILE)ld
OBJDUMP			:= $(CROSS_COMPILE)objdump
OBJCOPY			:= $(CROSS_COMPILE)objcopy


all: $(OBJ).bin

$(OBJ).bin: $(OBJ).s 
	$(CC) -g -c $(OBJ).s -o $(OBJ).o
	$(LD) -Ttext 0X87800000 $(OBJ).o -o $(OBJ).elf
	$(OBJCOPY) -O binary -S -g $(OBJ).elf $(OBJ).bin
	$(OBJDUMP) -D $(OBJ).elf > $(OBJ).dis

.PHONY: clean install

install: 
	./imxdownload $(OBJ).bin /dev/sdb

clean:
	rm -rf $(OBJ).elf $(OBJ).bin $(OBJ).dis $(OBJ).o
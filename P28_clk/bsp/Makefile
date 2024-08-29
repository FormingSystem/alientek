SUB_CUR_DIR := $(shell pwd)
SUB_DIRs 	:= $(filter-out $(SUB_CUR_DIR)/Makefile, $(wildcard $(SUB_CUR_DIR)/*))

# 子目录集合
SUB_DIRs 		:= $(filter-out $(SUB_CUR_DIR)/Makefile, $(wildcard $(SUB_CUR_DIR)/*))

# 目录.o
SUB_OBJ_DIRs 	:= $(patsubst %, %.o, $(basename $(SUB_DIRs)))

# obj目录下的总集合
SUB_TARGETs 	:= $(patsubst %, $(OBJDIR)/%,$(notdir $(SUB_OBJ_DIRs)))
SUB_dFILE 		:= $(addsuffix .d, $(basename $(foreach dir, $(SUB_DIRs), $(wildcard $(dir)/*.s $(dir)/*.S $(dir)/*.c))))

SOURCE_SUFFIX 	:= .S .s .c

all:  $(SUB_TARGETs)

.PHONY: print
print:
	@echo "------------------"
	

$(SUB_TARGETs): $(SUB_OBJ_DIRs)
	for obj in $^; do mv $$obj $(OBJDIR); done
#	for obj in $(SUB_dFILE); do rm -rf $$obj;done

$(SUB_OBJ_DIRs): $(foreach temp, $(basename $(foreach dir, $(SUB_DIRs), $(wildcard $(dir)/*.c $(dir)/*.s $(dir)/*.S))), $(temp).d)

# 如何生成 目录.o的文件？ 创建对应目录的依赖"
define BUILD_OBJ
$(1).o:  $(foreach suff, $(SOURCE_SUFFIX), $(wildcard $(1)/*$(suff)))
	@echo "~~~~~~~~~~~~~~~~"
	$(CC) -c -o $(1).o $(foreach suff, $(SOURCE_SUFFIX), $(wildcard $(1)/*$(suff))) $(C_INCLUDE_CFG)
endef

$(foreach dir, $(SUB_DIRs), $(eval $(call BUILD_OBJ, $(dir))))

%.d: %.c
#	@echo "------------BUILD_SUB_OBJ ---------- "
#	@echo "------------$^ ---------- "
#	@echo "------------$@ ---------- "
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@; 	\
	rm -f $@.$$$$

%.d: %.s
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@;  \
	rm -f $@.$$$$
	
%.d: %.S
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$ $(C_INCLUDE_CFG); \
	sed 's,$(notdir $*)\.o[ :]*,$*.o $@ : ,g' < $@.$$$$ > $@;  \
	rm -f $@.$$$$



include $(SUB_dFILE)

	
%.o: %.c
	$(CC) -c -o $@ $< $(C_INCLUDE_CFG)

clean:
	rm -rf $(SUB_dFILE)
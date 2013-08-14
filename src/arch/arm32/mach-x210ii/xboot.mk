#
# machine makefile.
#

DEFINES		+= -D__ARM_ARCH__=7 -D__CORTEX_A8__

ASFLAGS		:= -g -ggdb -Wall -O2
CFLAGS		:= -g -ggdb -Wall -O2
CXXFLAGS	:= -g -ggdb -Wall -O2
LDFLAGS		:= -T arch/$(ARCH)/$(MACH)/xboot.ld -nostdlib
ARFLAGS		:= -rcs
OCFLAGS		:= -v -O binary
ODFLAGS		:= -d
MCFLAGS		:= -mcpu=cortex-a8 -mtune=cortex-a8 -march=armv7-a -mfpu=neon -ftree-vectorize -ffast-math -mfloat-abi=softfp

LIBDIRS		:=
LIBS 		:=

INCDIRS		:=
SRCDIRS		:=

#
# add fixup rule
#
ifeq ($(strip $(HOSTOS)), linux)
MKV210		:= arch/$(ARCH)/$(MACH)/tools/linux/mkv210
endif
ifeq ($(strip $(HOSTOS)), windows)
MKV210		:= arch/$(ARCH)/$(MACH)/tools/windows/mkv210
endif

fixup:
	@echo make header information for irom booting
	$(MKV210) $(X_NAME).bin

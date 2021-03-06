# Kernel makefile

ifndef GAS
	GAS = i686-elf-as
endif

ifndef CFLAGS
	CFLAGS = -ffreestanding -Wall -Wextra -g
	CFLAGS += --sysroot="$(SYSROOT)"
	CFLAGS += -isystem="/usr/include"
endif

ifndef CXXFLAGS
	CXXFLAGS = -ffreestanding -Wall -Wextra -fno-exceptions -fno-rtti -D__is_kernel -g
	CXXFLAGS += -Iinclude
	CXXFLAGS += --sysroot="$(SYSROOT)"
	CXXFLAGS += -isystem="/usr/include"
endif

ifndef LDFLAGS
	LDFLAGS = -T linker.ld -ffreestanding -D__is_kernel -g
	LDFLAGS += --sysroot="$(SYSROOT)"
	LDFLAGS += -isystem="/usr/include"
endif

ifndef SYSROOT
	$(error No sysroot specified)
endif


LIBS = -nostdlib -lk -lgcc

#Find all the source files
C_SOURCES = $(shell find $(PWD)/kernel -type f -name '*.c')
CPP_SOURCES = $(shell find $(PWD)/kernel -type f -name '*.cpp')
HEADERS = $(shell find $(PWD) -type f -name '*.h')
ASMFILES = $(shell find $(PWD) -type f -name '*.asm')
GASFILES = $(wildcard *.s)
CRTBEGIN = $(shell $(CXX) $(CXXFLAGS) -print-file-name=crtbegin.o)
CRTEND = $(shell $(CXX) $(CXXFLAGS) -print-file-name=crtend.o)

OBJECTS = $(C_SOURCES:.c=.o)
OBJECTS += ${CPP_SOURCES:.cpp=.o}
OBJECTS += ${ASMFILES:.asm=.o}

LINKLST = crti.o
LINKLST += $(CRTBEGIN)
LINKLST += $(OBJECTS)
LINKLST += $(LIBS)
LINKLST += $(CRTEND)
LINKLST += crtn.o

.PHONY: all crt clean

all: crti.o crtn.o kernel.bin

kernel.bin: ${OBJECTS}
	$(info [INFO] Linking kernel)
	$(CXX) ${LDFLAGS} -o ${PREFIX}/kernel.bin $(LINKLST)

%.o: %.cpp ${HEADERS}
	$(info [INFO] Compiling $<)
	$(CXX) ${CXXFLAGS} -c $< -o $@

%.o: %.c $(HEADERS)
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.asm
	$(info [INFO] Assembling assembly)
	$(NASM) $< -f elf -o $@ -g

crti.o: 
	$(GAS) arch/$(ARCH)/crti.s -o $@

crtn.o: 
	$(GAS) arch/$(ARCH)/crtn.s -o $@

install-headers:
	cp -r --preserve=timestamps include $(SYSROOT)/usr

clean:
	$(info [INFO] Cleaning)
	rm ${OBJECTS} crti.o crtn.o

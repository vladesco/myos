CPP = g++
CPPPARAMS = -m32

ASM = nasm
ASMFLAGS = -f elf

LD = ld
LDPARAMS = -T linker.ld

kernel.o: kernel.cpp
	$(CPP) $(CPPPARAMS) -o $@ -c $<


loader.o: loader.asm
	$(ASM) $(ASMFLAGS) $< -o $@

run : kernel.o loader.o
	$(LD) $(LDPARAMS) -o kernel.bin $^

clear: 
	rm -f *.o kernel.bin
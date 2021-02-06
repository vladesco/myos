CPP = g++
CPPPARAMS = -m32

ASM = nasm
ASMFLAGS = -f elf

LD = ld
LDPARAMS = -melf_i386 -T linker.ld

GRUB_CONFIG ='\
settimeout=0\n\
setdefault=0\n\
\n\
menuentry "My Operating System" {\n\
	multiboot /boot/kernel.bin\n\
	boot\n\
}\n\
'

kernel.o: code/kernel.cpp
	$(CPP) $(CPPPARAMS) -o $@ -c $^


loader.o: loader.asm
	$(ASM) $(ASMFLAGS) $^ -o $@

install : kernel.o loader.o
	$(LD) $(LDPARAMS) -o kernel.bin $^

run: install
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot
	echo $(GRUB_CONFIG) > iso/boot/grub/grub.cfg
	grub-mkrescue --output=kernel.iso iso
	(pkill VirtualBox && sleep 1) || true
	VirtualBox --startvm "MyOS" &

clear: 
	rm -f *.o kernel.bin kernel.iso
	rm -rf iso
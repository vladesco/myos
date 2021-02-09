CPP = g++
CPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore 
objects =  code/kernel.o code/gdt/gdt.o

ASM = nasm
ASMFLAGS = -f elf

LD = ld
LDPARAMS = -melf_i386 -T linker.ld

GRUB_CONFIG ='\
set timeout=0\n\
set default=0\n\
\n\
menuentry "My Operating System" {\n\
	multiboot /boot/kernel.bin\n\
	boot\n\
}\n\
'

%.o: %.cpp
	$(CPP) $(CPPPARAMS) -o $@ -c $^

loader.o: loader.asm
	$(ASM) $(ASMFLAGS) $^ -o $@

install : loader.o $(objects)
	$(LD) $(LDPARAMS) -o kernel.bin $^

run: install
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot
	echo $(GRUB_CONFIG) > iso/boot/grub/grub.cfg
	grub-mkrescue --output=kernel.iso iso
	(pkill VirtualBox && sleep 1) || true
	VirtualBox --startvm "MyOS" &

clear: 
	find . -name "*.o" -type f -delete
	rm -rf iso
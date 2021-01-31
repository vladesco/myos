ENTRY (_loader)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386:i386)

LMA = 0x0100000;

SECTIONS
{
    . = LMA;
    
     .multiboot : {
        *(.multiboot)
     }

    .text : {
        *(.text)
    }

    .data : {
        *(.data)
        *(.rodata)
    }

    .bss : {
        *(.bss)
    }   

    /DISCARD/ : { 
        *(.comment) 
    }
}
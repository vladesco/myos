ENTRY (_loader)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386:i386)

LMA = 0x0100000;

SECTIONS
{
    . = 1M;
    
     .multiboot ALIGN(0x1000): {
        *(.multiboot)
     }

    .text : {
        *(.text*)
        *(.rodata)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }   

    /DISCARD/ : { 
        *(.fni_array*)
        *(.comment) 
    }
}
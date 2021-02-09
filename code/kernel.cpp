#include "types.h"
#include "./gdt/gdt.h"

static unsigned short *videoMemory = (uint16_t *)0xb8000;

void print(const int8_t *message)
{
    for (int i = 0; message[i]; i++)
    {
        videoMemory[i] = (videoMemory[i] & 0xFF00) | message[i];
    }
}

extern "C" void kernelMain(void *multiboot_structure, uint32_t magic_number)
{
    print("Hello World");
    GlobalDescriptorTable globalDescriptorTable;
}
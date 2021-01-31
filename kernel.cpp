static unsigned short *videoMemory = (unsigned short *)0xb8000;

void print(const char *message)
{
    for (int i = 0; message[i]; i++)
    {
        videoMemory[i] = (videoMemory[i] & 0xFF00) | message[i];
    }
}

extern "C" void kernelMain(void *multiboot_structure, unsigned int magic_number)
{
    print("Hello World");
}
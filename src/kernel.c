#include "include/vga.h"
#include "include/gdt.h"

void kernel(void);

void kernel(void) {
    initGDT();
    printf("GDT is running...");
    printf("VGA is running..");
    Reset();

    printf("labOS v2024.01 lts\n\n");
    printf("guest@labOS:~$ \n\n");
}

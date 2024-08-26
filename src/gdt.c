#include "include/gdt.h"

extern void gdt_flush(uint32_t);

const int gdt_entres_array = 6;

struct gdt_entry_struct gdt_entries[gdt_entres_array];
struct gdt_ptr_struct gdt_ptr;
struct tss_entry_struct tss_entry;

void initGDT() {
    gdt_ptr.limit = (sizeof(struct gdt_entry_struct) * gdt_entres_array) - 1;
    gdt_ptr.base = (uint32_t)&gdt_entries;

    setGDTGate(0, 0, 0, 0, 0);                  // NULL segment - this is always required
    setGDTGate(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);   // Kernel code segment
    setGDTGate(2, 0, 0xFFFFFFFF, 0x92, 0xCF);   // Kernel data segment
    setGDTGate(3, 0, 0xFFFFFFFF, 0xFA, 0xCF);   // User code segment
    setGDTGate(4, 0, 0xFFFFFFFF, 0xF2, 0xCF);   // User data segment

    writeTSS(5, 0x10, 0x0);

    gdt_flush(&gdt_ptr);
}

void writeTSS(uint32_t num, uint16_t ss0, uint16_t esp0) {
    uint32_t base = (uint32_t)&tss_entry;
    uint32_t limit = base + sizeof(tss_entry);

    setGDTGate(num, base, limit, 0xE9, 0x00);
}

void setGDTGate(uint32_t num, uint32_t base, uint32_t limit, uint32_t access, uint32_t gran) {
    gdt_entries[num].base_low = (base & 0xFFFF);
    gdt_entries[num].base_middle = (base >> 16) & 0xFF;
    gdt_entries[num].base_high = (base >> 24) & 0xFF;

    gdt_entries[num].limit = (limit & 0xFFFF);
    gdt_entries[num].flags = (limit >> 16) & 0x0F;
    gdt_entries[num].flags = (gran & 0xF0);

    gdt_entries[num].access = access;
}

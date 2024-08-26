OUTPUT_FORMAT(elf32-i386)
ENTRY(start)
SECTIONS
 {
    . = 100000;
    .text : {*(.text)}
    . = ALIGN (CONSTANT (COMMONPAGESIZE));
    .data : {*(.data)}
    .bss : {*(.bss)}
 }
nasm -f elf32 src/boot.asm -o build/boot.o
gcc -m32 -fno-stack-protector -fno-builtin -c src/kernel.c -o build/kernel.o
gcc -m32 -fno-stack-protector -fno-builtin -c src/vga.c -o build/vga.o
ld -m elf_i386 -T src/linker.ld -o build/kernel build/kernel.o build/boot.o
mv build/kernel LAB/boot/kernel
grub-mkrescue -o labOS-2024.01.iso Lab/
qemu-system-i386 kernel.iso
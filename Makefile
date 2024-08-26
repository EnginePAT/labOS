all: clean kernel boot image run

clean:
	rm -rf build/*.o

kernel:
	gcc -g -m32 -fno-stack-protector -fno-builtin -c src/vga.c -o build/vga.o
	gcc -g -m32 -fno-stack-protector -fno-builtin -c src/kernel.c -o build/kernel.o
#	gcc -g -m32 -fno-stack-protector -fno-builtin -c src/gdt.c -o build/gdt.o

boot:
	nasm -f elf32 src/boot.asm -o build/boot.o
	nasm -f elf32 src/gdt.asm -o build/gdts.o

image:
	ld -m elf_i386 -T src/linker.ld -o build/kernel build/kernel.o build/boot.o build/gdt.o build/gdt.o
	mv build/kernel Lab/boot/kernel
	grub-mkrescue -o labOS-2024.01-x86_64.iso Lab/




# link with linker.ld
# ld -m elf_i386 -T src/linker.ld -o build/kernel build/kernel.o build/boot.o
# compile kernel.c
# gcc -m32 -fno-stack-protector -fno-builtin -c src/kernel.c -o build/kernel.o
# compile boot.asm
# nasm -f elf32 src/boot.asm -o build/boot.o
# constuct iso file
# grub-mkrescue -o labOS-2024.01.iso LAB/

run:
	qemu-system-i386 labOS-2024.01.iso

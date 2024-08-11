ASM=nasm
CC=i386-elf-gcc
LD=i386-elf-ld

SRC_DIR=src
BUILD_DIR=build

$(BUILD_DIR)/labOS-2024.01-x86_64.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/labOS-2024.01-x86_64.img
	truncate -s 1440k $(BUILD_DIR)/labOS-2024.01-x86_64.img
	#bash file-system/setup.sh
	make run
	
$(BUILD_DIR)/main.bin: $(SRC_DIR)/boot.asm
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/obj
	$(ASM) $(SRC_DIR)/boot.asm -f bin -o $(BUILD_DIR)/main.bin
	$(CC) -ffreestanding -m32 -g -c $(SRC_DIR)/kernel.cpp -o $(BUILD_DIR)/obj/kernel.o
	$(ASM) $(SRC_DIR)/kernel_entry.asm -f elf -o build/obj/kernel_entry.o
	$(LD) -o build/full_kernel.bin -Ttext 0x1000 build/obj/kernel_entry.o build/obj/kernel.o --oformat binary
	cat build/boot.bin build/full_kernel.bin > build/os.bin

clean:
	-rm build/*

run:
	make
	qemu-system-i386 -fda build/labOS-2024.01-x86_64.img

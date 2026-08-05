FILES = ./build/kernel.asm.o

all: ./bin/boot.bin ./bin/kernel.bin
	rm -f ./bin/os.bin

	# Create a 100-sector empty disk image
	dd if=/dev/zero of=./bin/os.bin bs=512 count=100

	# Write bootloader to sector 0
	dd if=./bin/boot.bin of=./bin/os.bin conv=notrunc

	# Write kernel starting at sector 1
	dd if=./bin/kernel.bin of=./bin/os.bin seek=1 conv=notrunc

./bin/kernel.bin: $(FILES)
	i686-elf-ld -g -relocatable $(FILES) -o ./build/kernelfull.o
	i686-elf-gcc -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernelfull.o

./bin/boot.bin: ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin

./build/kernel.asm.o: ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o

clean:
	rm -rf ./bin/boot.bin ./bin/kernel.bin ./build/*.o ./bin/os.bin
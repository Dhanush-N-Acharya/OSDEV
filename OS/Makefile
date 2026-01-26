all:
	nasm -f bin ./boot.asm -o ./boot.bin
	dd if=./message1.txt bs=512 conv=sync >> ./boot.bin
	dd if=./message2.txt bs=512 conv=sync >> ./boot.bin
	dd if=./message3.txt bs=512 conv=sync >> ./boot.bin
	#dd if=/dev/zero bs=512 count=1 >> ./boot.bin

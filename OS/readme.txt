Info: boot.bin is like virtual hard disk.
bless command can be used to check the sectors.
Read sectors into memory:
    ah = 02h //specifies BIOS interrupt funtion 13h. It tells the BIOS to read from the disk.
    al = number of sectors to Read 
    CH = low eight bits of cylinder number
    CL = sector number 1-63 //specifies the sector number.
    DH = head number
    DL = driver number
    ES:BX = data buffer

INT 0x13 is the BIOS disk services interrupt used in real mode (bootloaders, early OS stages) 
to access disk drives.

Protected mode:
> Can provide memory and hardware protection.
> Different memory schemes.
> 4GB of memory addressable.

Memory and Hardware Protection:
> Protected mode allows you to protect memory from being accessed.
> Protected mode can prevent user programs talking with hardware.

Different memory schemes:
1.Selectors {CS,DS,ES} etc..
2.Paging (Remapping Memory Addresses)

Entering protected mode:

> Disable interrupts, including NMI.
> Enable A20 lines.
> Load global descriptor table with segment descriptors suitable for code.

What is global descriptor table?
> What kind of memory a segment is
> Who can access it
> Whether it is code, data, or system
> In protected mode, whether 16-bit or 32-bit

The Global Descriptor Table (GDT) is an array of entries that describe memory segments.

Each entry = one segment description
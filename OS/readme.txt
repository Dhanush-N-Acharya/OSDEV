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
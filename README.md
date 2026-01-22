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

ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTOINS
{
    . = 1M;
    .text :
    {
        *(.text)
    }
    .rodata :
    {
        *(.rodata)
    }
    .data :
    {
        *(.data)
    }
    .bss :
    {
        *(COMMON)
        *(.bss)
    }
}
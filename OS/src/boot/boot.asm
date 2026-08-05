ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:
    jmp short start
    nop

times 33 db 0

start: 
    jmp 0:step2

step2:
    cli ; clears the interrupts
    mov ax,0x00
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,0x7c00
    sti ; enables the interrupts

.load_protected:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    ;jmp CODE_SEG:load32

;GDT
gdt_start:
gdt_null:
    dd 0x0
    dd 0x0

;offset 0x8
gdt_code: ;cs should point to this
    dw 0xffff ;segment limit first 0-15 bits
    dw 0 ;base first 0-15 bits
    db 0 ;base 16-23 bits
    db 0x9a ;access byte
    db 11001111b ; high 4bit flags and low 4 bit flags
    db 0 ; base 24-31 bits
;offset 0x10
gdt_data: ;DS , SS, ES, FS, GS
    dw 0xffff ;segment limit first 0-15 bits
    dw 0 ;base first 0-15 bits
    db 0 ;base 16-23 bits
    db 0x92 ;access byte
    db 11001111b ; high 4bit flags and low 4 bit flags
    db 0 ; base 24-31 bits
gdt_end:

gdt_descriptor:
    dw gdt_end-gdt_start-1
    dd gdt_start

[BITS 32]
load32:
    mov eax, 1
    mov ecx, 100
    mov edi, 0x0100000
    call ata_lba_read
    
ata_lba_read:
    mov ebx, eax ;Backup the LBA
    ;send the highest 8bits of the LBA to the hard disk controller
    shr eax, 24
    mov dx, 0x1F6 ;Drive/Head register
    out dx, al
    ; finished sending the highest 8bits of the LBA

    ; send the total sectors to read
    mov eax, ecx
    mov dx, 0x1F2 ;Sector Count Register
    out dx, al
    ; finished sending the total Sectors to read
    
    ;send more bits of LBA
    mov eax, ebx ; restore the backup LBA
    mov dx, 0x1F3
    out dx, al
    ;finished sending more bits of LBA

    ;send more bits of lba
    mov dx, 0x1F4
    mov eax, ebx ; restore the backup lba
    shr eax, 8
    out dx, al
    ;finished sending more bits of lba

    ;send upper 16 bits of lba
    mov dx, 0x1F5
    mov eax, ebx ; restore the backup lba
    shr eax, 16
    out dx, al
    ;finished sending upper 16 bits of lba

    mov dx, 0x1f7
    mov al, 0x20
    out dx, al

    ;read all the sectors into the Memory

    .next_sector:

times 510-($ - $$) db 0
dw 0xAA55  

================================================================================
                          OS BOOTLOADER DOCUMENTATION
================================================================================

OVERVIEW
--------
This document provides technical specifications and implementation details for
the bootloader and operating system kernel initialization process.

DISK OPERATIONS
---------------

Boot Image:
The boot.bin file serves as a virtual hard disk image used for boot operations.

Sector Inspection:
The 'bless' command can be utilized to inspect and verify disk sectors.

BIOS Interrupt 0x13 - Disk Services
------------------------------------

INT 0x13 is the BIOS disk services interrupt used in real mode (bootloaders
and early OS kernel stages) to access disk drives.

Reading Sectors into Memory:
The following register values must be set prior to INT 0x13 invocation:

    AH = 02h        - Specifies read function for BIOS interrupt 13h
    AL              - Number of sectors to read
    CH              - Low eight bits of cylinder number
    CL              - Sector number (range: 1-63)
    DH              - Head number
    DL              - Drive number
    ES:BX           - Pointer to data buffer destination

PROTECTED MODE
--------------

Protected mode is a CPU operating mode that provides enhanced security and
memory management capabilities compared to real mode.

Key Advantages:
  • Memory and hardware protection mechanisms
  • Flexible memory addressing schemes
  • Support for up to 4GB of addressable memory

Memory and Hardware Protection:
  • Restricts unauthorized memory access
  • Prevents user programs from direct hardware communication
  • Enforces privilege levels for code execution

Memory Addressing Schemes:
  1. Selectors - Segment registers (CS, DS, ES, etc.)
  2. Paging - Virtual to physical memory address remapping

Transition to Protected Mode:
  1. Disable interrupts, including NMI (Non-Maskable Interrupt)
  2. Enable the A20 address line
  3. Load Global Descriptor Table (GDT) with appropriate segment descriptors

GLOBAL DESCRIPTOR TABLE (GDT)
-----------------------------

The Global Descriptor Table is an array of entries that describe memory
segments in protected mode.

GDT Entry Information:
Each entry specifies the following segment properties:
  • Memory segment type (code, data, or system)
  • Access permissions and privilege levels
  • Segment size and base address
  • 16-bit or 32-bit addressing capability

Structure:
Each GDT entry provides a complete segment description for protected mode
memory management.

In protected mode the rules for memory access is stored in GDT.
The GDT is simply array of entries.
Each entry is called a descriptor.

Each descriptor describes one segment, such as:
> kernel code.
> kernel data.
> user code.
> user data.
> system structures.

How the CPU uses the GDT:
1.A segment register (CS, DS, SS, etc.) is loaded with a segment selector
2.The selector points to an entry in the GDT
3.The CPU reads that entry
4.The CPU checks:
  Is this segment present?
  Is the access allowed?
  Is this code or data?
5.If valid → access allowed
  If not → CPU raises a fault

What kind of information does a GDT entry define?
Each GDT entry defines:
  Type: code, data, or system
  Privilege level: kernel (0) or user (3)
  Access permissions: read, write, execute
  Mode behavior: 16-bit, 32-bit, or 64-bit

How the CPU finds the GDT:
The CPU uses a special register:
  GDTR (Global Descriptor Table Register)
This register holds:
  the memory address of the GDT
  the size of the GDT
  command to load the GDT: lgdt [gdt_descriptor]

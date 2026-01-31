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
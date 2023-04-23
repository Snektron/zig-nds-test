ENTRY(_start_arm9)

SECTIONS {
    .text.arm9 : {
        KEEP(*(.text))
    }

    .rodata.arm9 : {
        KEEP(*(.rodata))
    }

    .data.arm9 : {
        KEEP(*(.data))
    }

    .bss.arm9 : {
        *(COMMON)
        KEEP(*(.bss))
    }
}

ENTRY(_start_arm7)

SECTIONS {
    .text.arm7 : {
        KEEP(*(.text))
    }

    .rodata.arm7 : {
        KEEP(*(.rodata))
    }

    .data.arm7 : {
        KEEP(*(.data))
    }

    .bss.arm7 : {
        *(COMMON)
        KEEP(*(.bss))
    }
}

ENTRY(_start_arm9)

SECTIONS {
    .text.arm9 : {
        KEEP(*(.text))
    }

    # TODO: data, rodata, bss, etc
}

ENTRY(_start_arm7)

SECTIONS {
    .text.arm7 : {
        KEEP(*(.text))
    }

    # TODO: data, rodata, bss, etc
}

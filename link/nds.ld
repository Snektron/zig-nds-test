ENTRY(_start_arm7)
ENTRY(_start_arm9)

MEMORY {
    RAM (rwx) : org = 0x02000000, len = 4M
}

SECTIONS {
    # Hack: LLD does not support OUTPUT_FORMAT(binary), so instead
    # just create a single section with everything in it. This is
    # extracted in build.zig to form the final .nds image.
    .nds : {
        mem_base = .;
        KEEP(*(.header))
        # TODO: Can we set an absolute value here rather than 4K?
        # TODO: Does this need to be 8K?
        . = ALIGN(4K);

        _arm7_start = .;
        _arm7_offset = . - mem_base;
        KEEP(*(.text.arm7))
        KEEP(*(.rodata.arm7))
        KEEP(*(.data.arm7))
        KEEP(*(.bss.arm7))
        _arm7_end = .;

        _arm9_start = .;
        _arm9_offset = . - mem_base;
        KEEP(*(.text.arm9))
        KEEP(*(.rodata.arm9))
        KEEP(*(.data.arm9))
        KEEP(*(.bss.arm9))
        _arm9_end = .;
    } > RAM =0

    # Zig cannot compute the size of these at comptime, so instead
    # provide the size as an address to Zig.
    _arm7_size = _arm7_end - _arm7_start;
    _arm9_size = _arm9_end - _arm9_start;
}

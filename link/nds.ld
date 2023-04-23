ENTRY(_start_arm7)
ENTRY(_start_arm9)

MEMORY {
    RAM (rwx) : org = 0x02000000, len = 4M
}

SECTIONS {
    .text : {
        KEEP(*(.header))
        . = ALIGN(4K);
        _arm7_start = .;
        KEEP(*(.text.arm7))
        _arm7_end = .;
        _arm9_start = .;
        KEEP(*(.text.arm9))
        _arm9_end = .;
    } > RAM =0

    # Zig cannot compute the size of these at comptime, so instead
    # provide the size as an address to Zig.
    _arm7_size = _arm7_end - _arm7_start;
    _arm9_size = _arm9_end - _arm9_start;
}

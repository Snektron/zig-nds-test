const nds = @import("nds.zig");

extern const _arm7_start: u8;
extern const _arm7_end: u8;
extern const _arm7_size: u8;
extern fn _start_arm7() callconv(.C) noreturn;

extern const _arm9_start: u8;
extern const _arm9_end: u8;
extern const _arm9_size: u8;
extern fn _start_arm9() callconv(.C) noreturn;

export const header linksection(".header") = nds.RomHeader{
    .title = "AAAAAAAAAAAA".*,
    .game_code = "0000".*,
    .maker_code = "00".*,

    .arm7_rom_offset = &_arm7_start, // TODO: This should be the ROM offset, fix in linker script!
    .arm7_entry_address = _start_arm7,
    .arm7_load_address = &_arm7_start,
    .arm7_size = &_arm9_size, //@ptrToInt(&_arm7_end) - @ptrToInt(&_arm7_end),

    .arm9_rom_offset = &_arm9_start, // TODO: This should be the ROM offset, fix in linker script!
    .arm9_entry_address = &_start_arm9,
    .arm9_load_address = &_arm9_start,
    .arm9_size = &_arm9_size, //@ptrToInt(&_arm9_end) - @ptrToInt(&_arm9_end),
};

const nds = @import("nds.zig");

extern const _arm7_offset: u8;
extern const _arm7_start: u8;
extern const _arm7_size: u8;
extern fn _start_arm7() callconv(.C) noreturn;

extern const _arm9_offset: u8;
extern const _arm9_start: u8;
extern const _arm9_size: u8;
extern fn _start_arm9() callconv(.C) noreturn;

export const header linksection(".header") = nds.RomHeader{
    // TODO: These options should all be configurable via the build system,
    // or something. Maybe we can just re-export part of the header?
    .title = "AAAAAAAAAAAA".*,
    .game_code = "0000".*,
    .maker_code = "00".*,

    .arm7_rom_offset = &_arm7_offset,
    .arm7_entry_address = _start_arm7,
    .arm7_load_address = &_arm7_start,
    .arm7_size = &_arm9_size,

    .arm9_rom_offset = &_arm9_offset,
    .arm9_entry_address = &_start_arm9,
    .arm9_load_address = &_arm9_start,
    .arm9_size = &_arm9_size,
};

const std = @import("std");

pub const RomHeader = extern struct {
    title: [12]u8,
    game_code: [4]u8,
    maker_code: [2]u8,
    unit_code: u8 = 0,
    encryption_seed_select: u8 = 0,
    device_capability: u8 = 0,
    _reserved1: [7]u8 = .{0} ** 7,
    game_revision: u16 = 0,
    rom_revision: u8 = 0,
    internal_flags: u8 = 0,

    arm9_rom_offset: *const anyopaque,
    arm9_entry_address: ?*const fn() callconv(.C) noreturn, // TODO: Non nullable
    arm9_load_address: *const anyopaque,
    // Zig cannot compute this address at comptime. Instead, we compute it in the
    // linker script as _arm9_size, and it's address is the size of the arm9 section.
    arm9_size: *const anyopaque,

    arm7_rom_offset: *const anyopaque,
    arm7_entry_address: ?*const fn() callconv(.C) noreturn, // TODO: Non nullable
    arm7_load_address: *const anyopaque,
    // Zig cannot compute this address at comptime. Instead, we compute it in the
    // linker script as _arm7_size, and it's address is the size of the arm7 section.
    arm7_size: *const anyopaque,

    fnt_offset: usize = 0,
    fnt_size: usize = 0,

    fat_offset: usize = 0,
    fat_size: usize = 0,

    arm9_overlay_offset: usize = 0,
    arm9_overlay_size: usize = 0,

    arm7_overlay_offset: usize = 0,
    arm7_overlay_size: usize = 0,

    card_control_normal: u32 = 0x00586000,
    card_control_secure: u32 = 0x001808F8,

    icon_banner_offset: usize = 0,
    secure_area_crc: u16 = 0,
    secure_transfer_timeout: u16 = 0,

    arm9_autoload: u32 = 0,
    arm7_autoload: u32 = 0,

    secure_disable: [8]u8 = .{0} ** 8,

    rom_size: u32 = 0,
    header_size: u32 = 0x4000,
    _reserved2: [56]u8 = .{0} ** 56,

    nintendo_logo: [156]u8 = .{0} ** 156,
    nintendo_logo_crc: u16 = 0,

    header_checksum: u16 = 0,

    _reserved: [32]u8 = .{0} ** 32,

    // TODO: DSi header
};

comptime {
    std.debug.assert(@sizeOf(RomHeader) == 384);
}

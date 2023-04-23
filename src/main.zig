const std = @import("std");
const builtin = @import("builtin");

fn start_arm7() callconv(.C) noreturn {
    while (true) {
        @intToPtr(*volatile u8, 1).* = 0;
    }
}

fn start_arm9() callconv(.C) noreturn {
    while (true) {
    }
}

comptime {
    if (std.mem.eql(u8, builtin.cpu.model.name, "arm946e_s")) {
        @export(start_arm9, .{.name = "_start_arm9"});
    } else if (std.mem.eql(u8, builtin.cpu.model.name, "arm7tdmi")) {
        @export(start_arm7, .{.name = "_start_arm7"});
    } else {
        @compileError("Invalid arch");
    }
}

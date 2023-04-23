const std = @import("std");
const builtin = @import("builtin");

const mem_base = 0x02000000;
const mem_limit = mem_base + 4 * 1024 * 1024;

const vram = @intToPtr([*]volatile u16, 0x06800000);

const io = struct {
    const dispcnt = @intToPtr(*volatile u32, 0x4000000);
    const powcnt1 = @intToPtr(*volatile u32, 0x4000304);
    const vramcnt_a = @intToPtr(*volatile u32, 0x4000240);
};

pub fn panic(msg: []const u8, stack_trace: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    _ = msg;
    _ = stack_trace;
    while (true) {}
}

fn start_arm7() callconv(.C) noreturn {
    while (true) {
    }
}

fn start_arm9() callconv(.C) noreturn {
    asm volatile(
        ""
        :
        : [stack] "{sp}" (mem_limit)
    );
    main();
}

fn main() noreturn {
    // Poke some random ports
    // See NDS_Hello.asm
    io.powcnt1.* = 0x8003;
    io.dispcnt.* = 0x00020000;
    io.vramcnt_a.* = 0x80;

    var j: usize = 0;
    while (true) {
        for (0..256 * 192) |i| {
            vram[i] = @truncate(u16, i + j);
        }
        j +%= 1;
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

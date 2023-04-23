const std = @import("std");
const builtin = @import("builtin");

const mem_base = 0x02000000;
const mem_limit = mem_base + 4 * 1024 * 1024;

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
    while (true) {}
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

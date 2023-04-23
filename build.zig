const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const arm7 = std.zig.CrossTarget.parse(.{
        .arch_os_abi = "arm-freestanding-none",
        .cpu_features = "arm7tdmi",
    }) catch unreachable;

    const arm9 = std.zig.CrossTarget.parse(.{
        .arch_os_abi = "arm-freestanding-none",
        .cpu_features = "arm946e_s",
    }) catch unreachable;

    const nds7 = b.addObject(.{
        .name = "zig-nds-test-nds7",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = arm7,
        .optimize = optimize,
        .use_lld = true,
    });
    nds7.linker_script = .{ .path = "link/arm7.ld" };

    const nds9 = b.addObject(.{
        .name = "zig-nds-test-nds9",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = arm9,
        .optimize = optimize,
        .use_lld = true,
    });
    nds9.linker_script = .{ .path = "link/arm9.ld" };

    const nds = b.addExecutable(.{
        .name = "zig-nds-test",
        .root_source_file = .{ .path = "src/link.zig" },
        .optimize = optimize,
         // Note: this source file is not expected to produce any code,
         // but Zig needs one anyway. This is essentially a dummy value.
        .target = arm9,
        .use_lld = true,
    });
    nds.linker_script = .{ .path = "link/nds.ld" };
    nds.addObject(nds7);
    nds.addObject(nds9);
    b.installArtifact(nds);
}

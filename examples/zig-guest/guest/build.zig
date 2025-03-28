const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 },
        .os_tag = .freestanding,
        .abi = .ilp32,
        .cpu_features_add = std.Target.riscv.featureSet(&.{
            .i,
            .m,
        }),
    });

    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = false,
        .link_libcpp = false,
        .single_threaded = true,
    });

    exe_mod.addIncludePath(b.path("out/platform/"));
    exe_mod.addObjectFile(b.path("out/platform/riscv32im-risc0-zkvm-elf/release/libzkvm_platform.a"));

    const exe = b.addExecutable(.{
        .name = "guest",
        .root_module = exe_mod,
    });

    exe.setLinkerScript(b.path("riscv32im-risc0-zkvm-elf.ld"));

    exe.addIncludePath(b.path("../riscv32im-linux-x86_64/riscv32-unknown-elf/include/"));
    exe.addObjectFile(b.path("../riscv32im-linux-x86_64/riscv32-unknown-elf/lib/libc.a"));
    exe.addObjectFile(b.path("../riscv32im-linux-x86_64/riscv32-unknown-elf/lib/libstdc++.a"));

    b.installArtifact(exe);
}

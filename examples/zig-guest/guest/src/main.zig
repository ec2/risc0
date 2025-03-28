//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const platform = @cImport({
    @cDefine("DEFINE_ZKVM", {});
    @cInclude("platform.h");
});

const std = @import("std");

const U32Cast = extern union {
    num: u32,
    bytes: [4]u8,
};

export fn main() void {
    var a = U32Cast{ .num = 0 };
    var b = U32Cast{ .num = 0 };

    std.debug.assert(platform.env_read(&a.bytes, 4) == 4);
    std.debug.assert(platform.env_read(&b.bytes, 4) == 4);

    a.num *= b.num;
    platform.env_commit(&a.bytes, @sizeOf(u32));
}

//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // Don't forget to flush!
}

const std = @import("std");

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("guest_lib");

// #include "platform.h"
// #include <assert.h>
// #include <stdint.h>

// union u32_cast {
//   uint32_t value;
//   uint8_t buffer[4];
// };

// int main() {
//   init_allocator();
//   // TODO introduce entropy into memory image (for zk)
//   sha256_state* hasher = init_sha256();

//   // Read two u32 values from the host, assuming LE byte order.
//   union u32_cast a;
//   union u32_cast b;
//   assert(env_read(a.buffer, 4) == 4);
//   assert(env_read(b.buffer, 4) == 4);

//   a.value *= b.value;

//   env_commit(hasher, a.buffer, sizeof(a.buffer));
//   env_exit(hasher, 0);

//   return 0;
// }

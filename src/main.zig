const std = @import("std");

const Cpu = @import("cpu.zig").Cpu;

pub fn main() !void {
    var cpu = Cpu{};
    cpu.reset();

    try cpu.print_state();
}

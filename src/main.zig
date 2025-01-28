const std = @import("std");

const ProcessorStatus = packed struct {
    carry: bool = false,
    zero: bool = false,
    interrupt: bool = false,
    decimal: bool = false,
    brk: bool = false,
    overflow: bool = false,
    negative: bool = false,
};

const Cpu = struct {
    pc: u16, // program counter
    sp: u16, // stack pointer
    a: u8, // accumulator
    x: u8, // index register x
    y: u8, // index register y
    status: ProcessorStatus,

    pub fn reset(self: Cpu) void {
        std.debug.print("CPU reset!, {}\n", .{self.pc});
    }
};

pub fn main() !void {
    var cpu = Cpu{
        .pc = 0,
        .sp = 0,
        .a = 0,
        .x = 0,
        .y = 0,
        .status = ProcessorStatus{},
    };
    cpu.reset();
    std.debug.print("Hello, world!\n", .{});
}

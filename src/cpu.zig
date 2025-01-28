const std = @import("std");
const expect = std.testing.expect;

const ProcessorStatus = packed struct {
    carry: bool = false,
    zero: bool = false,
    interrupt: bool = false,
    decimal: bool = false,
    brk: bool = false,
    overflow: bool = false,
    negative: bool = false,
};

const DEFAULT_PROGRAM_COUNTER: u16 = 0xfffc;
const STACK_BASE: u16 = 0x0100;

pub const Cpu = struct {
    pc: u16 = DEFAULT_PROGRAM_COUNTER, // program counter
    sp: u16 = STACK_BASE, // stack pointer
    a: u8 = 0, // accumulator
    x: u8 = 0, // index register x
    y: u8 = 0, // index register y
    status: ProcessorStatus = ProcessorStatus{},

    pub fn reset(self: *Cpu) void {
        std.debug.print("CPU reset! {}\n", .{self.pc});
        self.pc = DEFAULT_PROGRAM_COUNTER;
        self.sp = STACK_BASE;
        self.a = 0;
        self.x = 0;
        self.y = 0;
        self.status = ProcessorStatus{};
    }

    pub fn print_state(self: Cpu) !void {
        const stdout = std.io.getStdOut().writer();
        const out_str = "PC: ${X}\nSP: ${X}\nA:  ${X}\nX:  ${X}\nY:  ${X}\nC:  {}\nZ:  {}\nI:  {}\nD:  {}\nB:  {}\nO:  {}\nN:  {}\n";
        try stdout.print(out_str, .{ self.pc, self.sp, self.a, self.x, self.y, self.status.carry, self.status.zero, self.status.interrupt, self.status.decimal, self.status.brk, self.status.overflow, self.status.negative });
    }
};

test "reset cpu" {
    var cpu = Cpu{
        .pc = 0xffff,
        .sp = 0xffff,
        .a = 0xff,
        .x = 0xff,
        .y = 0xff,
        .status = ProcessorStatus{
            .carry = true,
            .zero = true,
            .interrupt = true,
            .decimal = true,
            .brk = true,
            .overflow = true,
            .negative = true,
        },
    };

    cpu.reset();
    try expect(cpu.pc == DEFAULT_PROGRAM_COUNTER);
    try expect(cpu.sp == STACK_BASE);
    try expect(cpu.a == 0);
    try expect(cpu.x == 0);
    try expect(cpu.y == 0);
    try expect(!cpu.status.carry);
    try expect(!cpu.status.zero);
    try expect(!cpu.status.interrupt);
    try expect(!cpu.status.decimal);
    try expect(!cpu.status.brk);
    try expect(!cpu.status.overflow);
    try expect(!cpu.status.negative);
}

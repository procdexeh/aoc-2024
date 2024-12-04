const std = @import("std");
const day2 = @import("day-2.zig");
const day3 = @import("day-3.zig");
const day4 = @import("day-4.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const xd = try day4.solve(allocator);
    std.debug.print("DAY_4 ANSWER: {any}\n", .{xd});
}

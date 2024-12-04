const std = @import("std");
const input_file: []const u8 = @embedFile("./inputs/day-4.input");

const WORD = "XMAS";
const SOLUTION_DIMENSION = 140;

fn bounds_check(nums: []const i64) bool {
    return for (nums) |num| {
        if (num > SOLUTION_DIMENSION - 1 or num < 0) {
            break false;
        }
    } else return true;
}

fn find_xmas(g: *[SOLUTION_DIMENSION][SOLUTION_DIMENSION]u8, pos_c: usize, pos_r: usize) i64 {
    const grid = g.*;
    const positions: [9][2]i64 = .{ .{ -1, -1 }, .{ -1, 0 }, .{ -1, 1 }, .{ 0, -1 }, .{ 0, 0 }, .{ 0, 1 }, .{ 1, -1 }, .{ 1, 0 }, .{ 1, 1 } };
    var count: i64 = 0;
    for (positions) |pos| {
        var x = pos[1] + @as(i64, @intCast(pos_r));
        var y = pos[0] + @as(i64, @intCast(pos_c));
        if (!bounds_check(&[2]i64{ x, y })) continue;
        const positional_char = grid[@as(usize, @intCast(y))][@as(usize, @intCast(x))];
        if (positional_char == WORD[1]) {
            for (WORD[2..]) |char| {
                x = pos[1] + x;
                y = pos[0] + y;

                if (!bounds_check(&[2]i64{ x, y })) break;
                const found_char = grid[@as(usize, @intCast(y))][@as(usize, @intCast(x))];
                if (found_char != char) break;
            } else {
                count += 1;
            }
        }
    }
    return count;
}

fn find_mas(g: *[SOLUTION_DIMENSION][SOLUTION_DIMENSION]u8, pos_c: usize, pos_r: usize) bool {
    const positions: [4][2]i64 = .{ .{ -1, -1 }, .{ -1, 1 }, .{ 1, -1 }, .{ 1, 1 } };
    var mini_grid: [3][3]u8 = .{ .{ ',', ',', ',' }, .{ ',', ',', ',' }, .{ ',', ',', ',' } };
    for (positions) |pos| {
        const x = pos[1] + @as(i64, @intCast(pos_r));
        const y = pos[0] + @as(i64, @intCast(pos_c));
        if (!bounds_check(&[2]i64{ x, y })) break;
        const found_char = g.*[@as(usize, @intCast(y))][@as(usize, @intCast(x))];
        if (found_char != 'M' and found_char != 'S') break;
        mini_grid[@as(usize, @intCast(1 + pos[0]))][@as(usize, @intCast(1 + pos[1]))] = found_char;
    }
    if (std.mem.count(u8, &mini_grid[0], ",") == 1 and std.mem.count(u8, &mini_grid[2], ",") == 1) {
        if (mini_grid[0][0] == mini_grid[2][2] or mini_grid[0][2] == mini_grid[2][0]) return false;
        return true;
    }
    return false;
}

pub fn solve(_: std.mem.Allocator) ![2]i64 {
    var lines = std.mem.tokenizeAny(u8, input_file, "\n");
    var grid: [SOLUTION_DIMENSION][SOLUTION_DIMENSION]u8 = undefined;
    var total_xmas: i64 = 0;
    var total_mas: i64 = 0;

    var index: usize = 0;
    while (lines.next()) |line| {
        @memcpy(&grid[index], line);
        index += 1;
    }
    for (grid, 0..) |col, col_idx| {
        for (col, 0..) |row, row_idx| {
            if (row == 'X') {
                const found = find_xmas(&grid, col_idx, row_idx);
                if (found > 0) {
                    total_xmas += found;
                }
            }
            if (row == 'A') {
                const found = find_mas(&grid, col_idx, row_idx);
                if (found) {
                    total_mas += 1;
                }
            }
        }
    }
    return .{ total_xmas, total_mas };
}

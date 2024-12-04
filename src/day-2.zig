const std = @import("std");

pub fn parseTokens(allocator: std.mem.Allocator, input: []const u8) !std.ArrayList(i64) {
    var numbers = std.ArrayList(i64).init(allocator);
    var tokens = std.mem.tokenizeAny(u8, input, " ");
    while (tokens.next()) |token| {
        const number = try std.fmt.parseInt(i64, token, 10);
        try numbers.append(number);
    }
    return numbers;
}

pub fn check_level_safety(level_list: std.ArrayList(i64)) bool {
    var prev_diff: i64 = 0;
    var safe = true;
    for (0.., level_list.items) |i, level| {
        if ((i + 1) == level_list.items.len) {
            break;
        }
        const next_level = level_list.items[i + 1];
        const diff: i64 = level - next_level;
        if (diff == 0 or @abs(diff) > 3) {
            safe = false;
            break;
        }
        if (diff * prev_diff < 0) {
            safe = false;
            break;
        }
        prev_diff = diff;
    }
    return safe;
}
pub fn check_report(allocator: std.mem.Allocator, input: []const u8) !bool {
    if (input.len == 0) return false;
    var levels = try parseTokens(allocator, input);
    defer levels.deinit();
    var safe_report = check_level_safety(levels);
    if (!safe_report) {
        for (0..levels.items.len) |i| {
            const removed = levels.orderedRemove(i);
            const safe_copy = check_level_safety(levels);
            _ = try levels.insert(i, removed);
            if (safe_copy) {
                safe_report = true;
                break;
            }
        }
    }
    return safe_report;
}

pub fn solve(allocator: std.mem.Allocator) !i64 {
    const file = @embedFile("./inputs/day-2.input");
    var lines = std.mem.splitAny(u8, file, "\n");
    var answer: i64 = 0;
    while (lines.next()) |line| {
        const checked_report = check_report(allocator, line) catch unreachable;
        if (checked_report) {
            answer += 1;
        }
    }
    return answer;
}

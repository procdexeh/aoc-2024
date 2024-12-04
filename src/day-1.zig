const std = @import("std");

pub fn solve(allocator: std.mem.Allocator) !void {
    // var arr = try std.BoundedArray(ListItem, 2000).init(0);
    //
    // const read_file = try std.fs.cwd().openFile("./src/day-1.input", .{});
    // defer read_file.close();
    //
    // var buf_reader = std.io.bufferedReader(read_file.reader());
    // var in_stream = buf_reader.reader();
    //
    // var buf: [1024]u8 = undefined;
    // while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    //     const ints = blk: {
    //         var tokens = std.mem.tokenizeScalar(u8, line, ' ');
    //         var b: [2]i64 = undefined;
    //
    //         var iter_i: usize = 0;
    //         while (tokens.next()) |t| {
    //             const cast = try std.fmt.parseInt(i64, t, 10);
    //             b[iter_i] = cast;
    //
    //             iter_i += 1;
    //         }
    //
    //         break :blk b;
    //     };
    //
    //     try arr.append(ListItem{ .side = ListType.left, .value = ints[0] });
    //     try arr.append(ListItem{ .side = ListType.right, .value = ints[1] });
    // }
    // std.debug.print("{any}", .{arr});
    // const right_slice = try right.toOwnedSlice();
    // defer allocator.free(right_slice);
    // const left_slice = try left.toOwnedSlice();
    // defer allocator.free(left_slice);
    //
    // std.mem.sort(u32, right_slice, {}, std.sort.asc(u32));
    // std.mem.sort(u32, left_slice, {}, std.sort.asc(u32));
    //
    // var totals = std.ArrayList(u32).init(allocator);
    // defer totals.deinit();
    // var t: u64 = 0;
    // for (left_slice, right_slice) |ll, rl| {
    //     const difference = try std.math.sub(i64, ll, rl);
    //     const abs_difference: u64 = @as(u64, @intCast(@abs(difference)));
    //     t += abs_difference;
    // }
    //
    // std.debug.print("totals: {any}\n", .{t});
    // var sim_score: u64 = 0;
    // for (left_slice) |l| {
    //     var occurence: u64 = 0;
    //     for (right_slice) |r| {
    //         if (r == l) {
    //             occurence += 1;
    //         }
    //     }
    //     sim_score += occurence * l;
    // }
    //
    // std.debug.print("occurence totals: {any}\n", .{sim_score});
}

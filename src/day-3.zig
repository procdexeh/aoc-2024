const std = @import("std");
const file: []const u8 = @embedFile("./inputs/day-3.input");

fn parse_mul(bytes: []const u8) !i64 {
    var total: i64 = 0;
    var mul_enabled = true;
    for (0..bytes.len) |i| {
        const mul_token = bytes[i..@min(i + 4, bytes.len)];
        const do_token = bytes[i..@min(i + 4, bytes.len)];
        const dont_token = bytes[i..@min(i + 7, bytes.len)];
        if (std.mem.eql(u8, do_token, "do()")) {
            mul_enabled = true;
        }
        if (std.mem.eql(u8, dont_token, "don't()")) {
            mul_enabled = false;
        }
        if (std.mem.eql(u8, mul_token, "mul(") and mul_enabled) {
            const mul_body = bytes[i + mul_token.len ..];
            for (0..mul_body.len) |mi| {
                const mul_body_char = mul_body[mi];
                switch (mul_body_char) {
                    ')' => {
                        const expr_body = mul_body[0..mi];
                        for (0..expr_body.len) |ci| {
                            const char = expr_body[ci];
                            if (char == ',') {
                                const left = try std.fmt.parseInt(i64, expr_body[0..ci], 10);
                                const right = try std.fmt.parseInt(i64, expr_body[ci + 1 .. expr_body.len], 10);
                                total += left * right;
                            }
                        }
                        break;
                    },
                    else => {
                        if (std.ascii.isDigit(mul_body_char) or mul_body_char == ',') continue;
                        break;
                    },
                }
            }
        }
    }
    return total;
}

pub fn solve(_: std.mem.Allocator) !i64 {
    const answer = try parse_mul(file);
    return answer;
}

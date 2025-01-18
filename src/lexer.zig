const Token = @import("token.zig").Token;
const TokenType = @import("token.zig").TokenType;
const std = @import("std");
pub const Lexer = struct {
    input: []const u8 = undefined,
    position: usize = 0,
    read_position: usize = 0,
    char: u8 = '\x00',

    const Self = @This();

    pub fn new(input: []const u8) Self {
        return Self{
            .input = input,
            .position = 0,
            .read_position = 0,
            .char = '\x00',
        };
    }

    pub fn read_char(self: *Self) void {
        if (self.read_position >= self.input.len) {
            self.char = 0;
        } else {
            self.char = self.input[self.read_position];
        }

        self.position = self.read_position;
        self.read_position += 1;
    }
};

test "Lexer Testing" {
    const input = "=";
    const expected = '=';

    var lexer = Lexer.new(input);

    lexer.read_char();

    try std.testing.expectEqual(lexer.char, expected);
}

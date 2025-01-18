const std = @import("std");
const Lexer = @import("lexer.zig").Lexer;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();
    _ = args.skip();

    const filePath = args.next().?;

    const file = try std.fs.cwd().openFile(filePath, .{});
    defer file.close();

    const file_buffer = try file.readToEndAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(file_buffer);

    const file_contents = file_buffer[0..];

    var lexer = Lexer.new(file_contents);
    lexer.read_char();

    while (lexer.char != '\x00') : (lexer.read_char()) {
        std.debug.print("{c}", .{lexer.char});
    }
}

test {
    _ = @import("lexer.zig");
}

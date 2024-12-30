module top_level (
    input clk,          // System clock
    input reset,        // Reset signal
    input [1:0] btn,    // Buttons for player control
    output [3:0] vga_r, // VGA red signal
    output [3:0] vga_g, // VGA green signal
    output [3:0] vga_b, // VGA blue signal
    output vga_hs,      // VGA horizontal sync
    output vga_vs       // VGA vertical sync
);

    wire clk_25mhz;        // Clock for VGA
    wire [9:0] h_addr, v_addr; // Pixel coordinates
    wire [11:0] pixel_data;    // Pixel color data

    // Clock divider for VGA
    clock_divider clk_div (
        .clk_in(clk),
        .reset(reset),
        .clk_out(clk_25mhz)
    );

    // VGA Controller
    vga_controller vga (
        .clk(clk_25mhz),
        .reset(reset),
        .h_addr(h_addr),
        .v_addr(v_addr),
        .pixel_data(pixel_data),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs)
    );

    // Game Logic
    game_logic game (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .h_addr(h_addr),
        .v_addr(v_addr),
        .pixel_data(pixel_data)
    );

endmodule

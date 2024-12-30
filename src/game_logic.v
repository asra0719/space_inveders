module game_logic (
    input clk,             // System clock
    input reset,           // Reset signal
    input [1:0] btn,       // Player buttons
    input [9:0] h_addr,    // Current horizontal pixel address
    input [9:0] v_addr,    // Current vertical pixel address
    output reg [11:0] pixel_data // Pixel color data (RGB)
);

    // Player position
    reg [9:0] player_x = 320; // Initial X position
    localparam PLAYER_Y = 450;

    // Alien grid parameters
    reg [9:0] alien_x = 100;
    reg [9:0] alien_y = 50;

    // Logic for player movement
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            player_x <= 320;
        end else if (btn[0]) begin
            if (player_x > 0)
                player_x <= player_x - 1;
        end else if (btn[1]) begin
            if (player_x < 640)
                player_x <= player_x + 1;
        end
    end

    // Render game objects
    always @(*) begin
        if ((h_addr >= player_x) && (h_addr < player_x + 20) &&
            (v_addr >= PLAYER_Y) && (v_addr < PLAYER_Y + 10))
            pixel_data = 12'hF00; // Player (red)
        else if ((h_addr >= alien_x) && (h_addr < alien_x + 20) &&
                 (v_addr >= alien_y) && (v_addr < alien_y + 10))
            pixel_data = 12'h0F0; // Alien (green)
        else
            pixel_data = 12'h000; // Background (black)
    end

endmodule

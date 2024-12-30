module bullet_logic (
    input clk,
    input reset,
    input fire_player,
    input fire_alien,
    input [9:0] player_x,
    input [9:0] alien_x,
    input [8:0] alien_y,
    output reg [9:0] bullet_x,
    output reg [8:0] bullet_y,
    output reg active
);
    reg direction; // 1 for upwards (player), 0 for downwards (alien)
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bullet_x <= 0;
            bullet_y <= 0;
            active <= 0;
        end else begin
            if (fire_player && !active) begin
                // Fire player bullet
                bullet_x <= player_x;
                bullet_y <= 9'd450;
                direction <= 1;
                active <= 1;
            end else if (fire_alien && !active) begin
                // Fire alien bullet
                bullet_x <= alien_x;
                bullet_y <= alien_y;
                direction <= 0;
                active <= 1;
            end
            
            // Move bullet
            if (active) begin
                if (direction)
                    bullet_y <= bullet_y - 1; // Move up
                else
                    bullet_y <= bullet_y + 1; // Move down
                
                // Deactivate bullet if off-screen
                if (bullet_y < 10 || bullet_y > 470) active <= 0;
            end
        end
    end
endmodule

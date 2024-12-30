module alien_logic (
    input clk,
    input reset,
    output reg [9:0] alien_x [0:4], // Alien X positions
    output reg [8:0] alien_y [0:4], // Alien Y positions
    output reg alien_shoot
);
    reg direction; // 0: left, 1: right
    integer i;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            direction <= 1;
            for (i = 0; i < 5; i = i + 1) begin
                alien_x[i] <= 10'd100 + (i * 40);
                alien_y[i] <= 9'd50;
            end
        end else begin
            // Move aliens horizontally
            if (direction)
                for (i = 0; i < 5; i = i + 1) alien_x[i] <= alien_x[i] + 1;
            else
                for (i = 0; i < 5; i = i + 1) alien_x[i] <= alien_x[i] - 1;

            // Change direction if an alien hits screen edges
            if (alien_x[0] < 10 || alien_x[4] > 630) direction <= ~direction;

            // Randomly trigger alien shooting
            if ($random % 50 == 0) alien_shoot <= 1;
            else alien_shoot <= 0;
        end
    end
endmodule

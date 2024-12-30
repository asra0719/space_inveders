module collision_detector (
    input [9:0] bullet_x,
    input [8:0] bullet_y,
    input [9:0] target_x,
    input [8:0] target_y,
    input target_active,
    output reg collision
);
    always @(*) begin
        if (target_active && 
            bullet_x >= target_x && bullet_x <= target_x + 20 &&
            bullet_y >= target_y && bullet_y <= target_y + 20)
            collision = 1;
        else
            collision = 0;
    end
endmodule

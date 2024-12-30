module score_tracker (
    input clk,
    input reset,
    input collision_detected,
    output reg [3:0] score
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            score <= 0;
        else if (collision_detected)
            score <= score + 1;
    end
endmodule

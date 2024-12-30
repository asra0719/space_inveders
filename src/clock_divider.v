module clock_divider (
    input clk_in,       // Input clock
    input reset,        // Reset signal
    output reg clk_out  // Divided clock output
);

    reg [1:0] counter = 0;

    always @(posedge clk_in or posedge reset) begin
        if (reset)
            counter <= 0;
        else
            counter <= counter + 1;

        clk_out <= (counter == 2'b11); // 25 MHz clock
    end

endmodule

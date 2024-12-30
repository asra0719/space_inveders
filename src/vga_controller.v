module vga_controller (
    input clk,          // VGA clock
    input reset,        // Reset signal
    output reg [9:0] h_addr, // Horizontal pixel address
    output reg [9:0] v_addr, // Vertical pixel address
    input [11:0] pixel_data, // Pixel color data
    output reg [3:0] vga_r,  // VGA red signal
    output reg [3:0] vga_g,  // VGA green signal
    output reg [3:0] vga_b,  // VGA blue signal
    output reg vga_hs,       // Horizontal sync
    output reg vga_vs        // Vertical sync
);

    // VGA timing parameters (640x480 @ 60 Hz)
    localparam H_SYNC = 96, H_BACK = 48, H_DISP = 640, H_FRONT = 16, H_TOTAL = 800;
    localparam V_SYNC = 2,  V_BACK = 33, V_DISP = 480, V_FRONT = 10, V_TOTAL = 525;

    reg [9:0] h_count = 0;
    reg [9:0] v_count = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            h_count <= 0;
            v_count <= 0;
        end else begin
            // Horizontal counter
            if (h_count == H_TOTAL - 1) begin
                h_count <= 0;
                // Vertical counter
                if (v_count == V_TOTAL - 1)
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
            end else begin
                h_count <= h_count + 1;
            end

            // Horizontal and vertical sync signals
            vga_hs <= (h_count < H_SYNC) ? 0 : 1;
            vga_vs <= (v_count < V_SYNC) ? 0 : 1;

            // Pixel address calculation
            if ((h_count >= H_SYNC + H_BACK) && (h_count < H_SYNC + H_BACK + H_DISP))
                h_addr <= h_count - H_SYNC - H_BACK;
            else
                h_addr <= 0;

            if ((v_count >= V_SYNC + V_BACK) && (v_count < V_SYNC + V_BACK + V_DISP))
                v_addr <= v_count - V_SYNC - V_BACK;
            else
                v_addr <= 0;

            // Assign pixel data to VGA signals
            if ((h_count >= H_SYNC + H_BACK) && (h_count < H_SYNC + H_BACK + H_DISP) &&
                (v_count >= V_SYNC + V_BACK) && (v_count < V_SYNC + V_BACK + V_DISP)) begin
                vga_r <= pixel_data[11:8];
                vga_g <= pixel_data[7:4];
                vga_b <= pixel_data[3:0];
            end else begin
                vga_r <= 0;
                vga_g <= 0;
                vga_b <= 0;
            end
        end
    end

endmodule

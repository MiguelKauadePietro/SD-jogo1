module vga_display(
    input clk,
    input [9:0] h_counter,
    input [9:0] v_counter,
    input [17:0] board,
    output reg vga_r,
    output reg vga_g,
    output reg vga_b
);

    // Define parameters for player states
    parameter noplayer = 2'b00;
    parameter RED = 2'b01;
    parameter BLUE = 2'b10;

    // Square dimensions for the 3x3 grid
    parameter square_width = 213;  // 640 / 3
    parameter square_height = 160; // 480 / 3
	 
	 integer square;

    always @(*) begin
        // Default colors (no player in the square)
        vga_r = 0;
        vga_g = 0;
        vga_b = 0;

        // Determine which square (0-8) the pixel belongs to
        if (h_counter < square_width) begin
            if (v_counter < square_height) begin
                square = 0; // top-left square
            end else if (v_counter < 2 * square_height) begin
                square = 3; // middle-left square
            end else begin
                square = 6; // bottom-left square
            end
        end else if (h_counter < 2 * square_width) begin
            if (v_counter < square_height) begin
                square = 1; // top-center square
            end else if (v_counter < 2 * square_height) begin
                square = 4; // middle-center square
            end else begin
                square = 7; // bottom-center square
            end
        end else begin
            if (v_counter < square_height) begin
                square = 2; // top-right square
            end else if (v_counter < 2 * square_height) begin
                square = 5; // middle-right square
            end else begin
                square = 8; // bottom-right square
            end
        end

        // Check the player (RED/BLUE) in the corresponding square
        case (board[2 * square +: 2]) // Select the 2 bits for the current square
            RED: begin
                vga_r = 1;
                vga_g = 0;
                vga_b = 0;
            end
            BLUE: begin
                vga_r = 0;
                vga_g = 0;
                vga_b = 1;
            end
            default: begin
                vga_r = 0;
                vga_g = 0;
                vga_b = 0;
            end
        endcase
    end

endmodule

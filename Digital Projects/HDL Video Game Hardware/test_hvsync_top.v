/* 
CRT Test Pattern Generator
Generates test pattern for RGBHV input CRT
*/

`include "hvsync_generator.v"

module test_hvsync_top
        (clk, reset, hsync, vsync, rgb);

    input clk;
    input reset;
    output hsync;
    output vsync;
    output [2:0] rgb;
    wire display_on;
    wire [8:0] hpos;
    wire [8:0] vpos;

    hvsync_generator hvsync_gen
    (
        .clk(clk),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .display_on(display_on),
        .hpos(hpos),
        .vpos(vpos)
    );

    // Red on every 8 pixels
    wire r = display_on && (((hpos & 7) == 0) || ((vpos & 7) == 0));
    // Green alternate every 16 vertical pixels
    wire g = display_on && vpos[4];
    // Blue alternate every 16 horizontal pixels
    wire b = display_on && hpos[4];

    assign rgb = {b,g,r};

endmodule
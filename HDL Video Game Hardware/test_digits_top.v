/* 
Bitmap Digit Tester
Tests scanline rendering of bitmap digits.
*/

`include "hvsync_generator.v"
`include "digits.v"

module test_digits_top
        (clk, reset, hsync, vsync, rgb);

    input clk;
    input reset;


    output hsync;
    output vsync;
    output [2:0] rgb;
    wire display_on;
    wire [8:0] hpos;
    wire [8:0] vpos;

    wire[3:0] digit = hpos[7:4]; // (hpos / 16) selects digit
    wire[2:0] xoffs = hpos[3:1]; // h offset / 2 (2x size)
    wire[2:0] yoffs = vpos[3:1]; // y offset / 2 (2x size)
    wire[4:0] pixs;

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

    digits nums(
        .digit(digit),
        .yoffset(yoffs),
        .pixels(pixs)
    );

    wire g = display_on && (xoffs >= 3'b011) && pixs[xoffs ^ 3'b111];

    assign rgb = {1'b0, g, 1'b0};

endmodule
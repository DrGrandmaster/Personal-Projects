/* 
Video Sync Generator
Generates Sync Signals for driving a RGBHV input CRT
!NOTE! As written, 0,0 is the top left corner of the display area, NOT the beginning of the raster.
*/

`ifndef HVSYNC_GENERATOR_H
`define HVSYNC_GENERATOR_H

module hvsync_generator
        (clk, reset, hsync, vsync, display_on, hpos, vpos);

    localparam H_DISP       =   256;
    localparam B_PORCH      =   23;
    localparam F_PORCH      =   7;
    localparam H_SYNC_W     =   23;

    localparam V_DISP       =   240;
    localparam V_BLANK_T    =   5;
    localparam V_BLANK_B    =   14;
    localparam V_SYNC_D     =   3;

    localparam H_SYNC_STR   =   H_DISP + F_PORCH;
    localparam H_SYNC_END   =   H_SYNC_STR + H_SYNC_W - 1;
    localparam H_MAX        =   H_DISP + B_PORCH + F_PORCH + H_SYNC_W - 1;

    localparam V_SYNC_STR   =   V_DISP + V_BLANK_B;
    localparam V_SYNC_END   =   V_SYNC_STR + V_SYNC_D - 1;
    localparam V_MAX        =   V_DISP + V_BLANK_T + V_BLANK_B + V_SYNC_D - 1;

    //localparam H_BITS = $clog2(H_MAX);
    //localparam V_BITS = $clog2(V_MAX);
    localparam H_BITS = 9;
    localparam V_BITS = 9;

    input clk;
    input reset;

    output hsync, vsync; //generated synchronization signals
    output display_on; // indicated when displayable area active

    // Position Counters
    output [H_BITS-1:0] hpos;
    output [V_BITS-1:0] vpos;

    // Signal position returns
    wire hret = (hpos == H_MAX) || reset;
    wire vret = (vpos == V_MAX) || reset;

    // Horizontal
    always @(posedge clk) begin
        
        // Activate horizontal sync pulse when hpos in hsync interval
        hsync <= (hpos >= H_SYNC_STR && hpos <= H_SYNC_END);

        // Update hpos
        if((hpos == H_MAX) || reset)

            hpos <= 0;

        else

            hpos <= hpos + 1;
        
    end

    // Vertical
    always @(posedge clk) begin

        //Activate vertical sync pulse when vpos in vsync interval
        vsync <= (vpos >= V_SYNC_STR && vpos <= V_SYNC_END);

        // Update vpos
        if(hret)

            if(vret)

                vpos <= 0;

            else

                vpos <= vpos + 1;

    end

    // Usable Area
    assign display_on = (hpos < H_DISP) && (vpos < V_DISP);

endmodule

`endif
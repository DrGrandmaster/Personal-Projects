/* 
Ball Animation
Shows a DVD player screensaver like animated ball.
*/

`include "hvsync_generator.v"

module ball_top
        (clk, reset, hsync, vsync, rgb);
    
    localparam SIZE = 4;
    localparam H_POS_INIT = 64;
    localparam V_POS_INIT = 64;
    localparam H_VEL_INIT = 3;
    localparam V_VEL_INIT = 4;

    localparam MIN_X = 0;
    localparam MIN_Y = 0;
    localparam MAX_X = 256;
    localparam MAX_Y = 240;

    input clk;
    input reset;

    output hsync;
    output vsync;
    output [2:0] rgb;
    wire display_on;
    wire [8:0] hpos;
    wire [8:0] vpos;

    reg [8:0] ball_hpos;
    reg [8:0] ball_vpos;
    reg [8:0] ball_h_vel;
    reg [8:0] ball_v_vel;

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

    initial begin
        ball_hpos = H_POS_INIT;
        ball_vpos = V_POS_INIT;
        ball_h_vel = H_VEL_INIT;
        ball_v_vel = V_VEL_INIT;
    end

    wire ball_h_coll = ball_hpos >= MAX_X - SIZE;
    wire ball_v_coll = ball_vpos >= MAX_Y - SIZE;

    always @(posedge vsync) begin

        if(reset) begin
            ball_hpos <= H_POS_INIT;
            ball_vpos <= V_POS_INIT;
        end else begin
            ball_hpos <= ball_hpos + ball_h_vel;
            ball_vpos <= ball_vpos + ball_v_vel;
        end
        
    end

    always @(posedge ball_h_coll)
        ball_h_vel <= reset ? H_VEL_INIT : -ball_h_vel; // to initial if reset true, invert if reset false

    always @(posedge ball_v_coll)
        ball_v_vel <= reset ? V_VEL_INIT : -ball_v_vel;

    wire ball_draw = ((hpos - ball_hpos < SIZE) && (vpos - ball_vpos < SIZE)) && display_on;

    wire border_draw = ((hpos == MIN_X) || (hpos == MAX_X - 1) || (vpos == MIN_Y || vpos == MAX_Y - 1)) && display_on;

    assign rgb = {ball_draw || border_draw, ball_draw || border_draw, ball_draw || border_draw};

endmodule
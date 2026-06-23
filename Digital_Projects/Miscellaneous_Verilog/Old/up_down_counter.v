/*
Up-Down Counter of N bits with sync reset
!Note! Timings from derived clock unsuitable for high speed applications.
*/

module up_down_counter
    #(parameter BITS = 8)
    (clk, reset, up, counter);

  input clk;
  input reset;

  input up;

  output reg [BITS-1:0] counter;
  
  always @(posedge clk)
  begin

    if (reset)

      counter <= 0;

    else if(up)

      counter <= counter + 1;

    else

      counter <= counter - 1;

  end
    
endmodule
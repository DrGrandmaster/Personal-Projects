/*
Basic Count Up Counter of 4 bits with async reset
!Note! Timings from derived clock unsuitable for high speed applications.
*/

module simple_counter(
  input clk,
  input reset,
  output reg  [3:0] counter
);
  
  always @(posedge clk or posedge reset)
  begin

    if (reset)

      counter <= 0;

    else

      counter <= counter + 1;

  end
    
endmodule
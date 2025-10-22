/*
Basic PWM Generator.
Provides PWM waveform at a fixed frequency; the input clock frequency.
*/

`include "up_down_counter.v"

module fixed_freq_pwm
    #(parameter BITS = 8)
(clk, reset, enable, duty, pwm);

input clk;
input reset;
input enable;

input [BITS-1:0] duty;

reg [BITS-1:0] count;

output reg pwm;


  up_down_counter
  #(
    .BITS(BITS)
  )
  accumulator
  (
      .clk(clk),
      .reset(reset),
      .up(1),
      .counter(count)
  );

  // by using < we stay true to the formula duty cylce = duty / 2^BITS. We cannot output VDD with this scheme, but we can output 0. Which is probably more helpful.
  assign pwm = (count < duty) && (enable && !reset);
    
endmodule
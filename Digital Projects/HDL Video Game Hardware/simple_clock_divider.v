/*
Clock Divider constructed of cascading flip-flops (III)
Provides /2, /4, /8, /16 clocks
!Note! Timings from derived clock unsuitable for high speed applications.
*/

module simple_clock_divider(
  input clk,
  output reg clk_div2,
  output reg clk_div4,
  output reg clk_div8,
  output reg clk_div16
);
  
  always@(posedge clk)
    clk_div2 <= ~clk_div2;
  
  always@(posedge clk_div2)
    clk_div4 <= ~clk_div4;
  
  always@(posedge clk_div4)
    clk_div8 <= ~clk_div8;
  
  always@(posedge clk_div8)
    clk_div16 <= ~clk_div16;
    
endmodule
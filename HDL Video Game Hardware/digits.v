`ifndef DIGITS_H
`define DIGITS_H

/*
Bitmap Digit Renderer
Contains 5x5 bitmaps for digits 0-9.
Losely inspired by Tom7's FixederSys x1.
*/

module digits(
  input [3:0] digit,
  input [2:0] yoffset,
  output reg  [4:0] pixels
);
  
 reg [4:0] bitmaps[0:15][0:4];

 assign pixels = bitmaps[digit][yoffset];

 initial begin
  // 0
  bitmaps[0][0] = 5'b01110;
  bitmaps[0][1] = 5'b10011;
  bitmaps[0][2] = 5'b10101;
  bitmaps[0][3] = 5'b11001;
  bitmaps[0][4] = 5'b01110;
  // 1
  bitmaps[1][0] = 5'b00011;
  bitmaps[1][1] = 5'b01111;
  bitmaps[1][2] = 5'b00011;
  bitmaps[1][3] = 5'b00011;
  bitmaps[1][4] = 5'b00011;
  // 2
  bitmaps[2][0] = 5'b01110;
  bitmaps[2][1] = 5'b10001;
  bitmaps[2][2] = 5'b00010;
  bitmaps[2][3] = 5'b00100;
  bitmaps[2][4] = 5'b11111;
  // 3
  bitmaps[3][0] = 5'b01110;
  bitmaps[3][1] = 5'b10001;
  bitmaps[3][2] = 5'b00110;
  bitmaps[3][3] = 5'b10001;
  bitmaps[3][4] = 5'b01110;
  // 4
  bitmaps[4][0] = 5'b10001;
  bitmaps[4][1] = 5'b10001;
  bitmaps[4][2] = 5'b01111;
  bitmaps[4][3] = 5'b00001;
  bitmaps[4][4] = 5'b00001;
  // 5
  bitmaps[5][0] = 5'b11111;
  bitmaps[5][1] = 5'b10000;
  bitmaps[5][2] = 5'b11110;
  bitmaps[5][3] = 5'b00001;
  bitmaps[5][4] = 5'b11110;
  // 6
  bitmaps[6][0] = 5'b01110;
  bitmaps[6][1] = 5'b10000;
  bitmaps[6][2] = 5'b11110;
  bitmaps[6][3] = 5'b10001;
  bitmaps[6][4] = 5'b01110;
  // 7
  bitmaps[7][0] = 5'b11111;
  bitmaps[7][1] = 5'b00010;
  bitmaps[7][2] = 5'b00100;
  bitmaps[7][3] = 5'b01000;
  bitmaps[7][4] = 5'b01000;
  // 8
  bitmaps[8][0] = 5'b01110;
  bitmaps[8][1] = 5'b11001;
  bitmaps[8][2] = 5'b01110;
  bitmaps[8][3] = 5'b10011;
  bitmaps[8][4] = 5'b01110;
  // 9
  bitmaps[9][0] = 5'b01110;
  bitmaps[9][1] = 5'b10001;
  bitmaps[9][2] = 5'b01110;
  bitmaps[9][3] = 5'b00010;
  bitmaps[9][4] = 5'b01100;
  // Rest of ROM filled w/ 0s
  for(int i = 10; i < 16; i++)
    for(int j = 0; j < 5; j++)
      bitmaps[i][j] = 0;
 end
    
endmodule

`endif
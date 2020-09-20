`timescale 1ns / 1ns
module Golombtester ();
  reg [7:0] m;
  reg [7:0] n;
  wire [15:0] o;
  Gompegolomb MUT (m,n,o);
  initial begin
    //m = $random();
   // n = $random();
   m = 4;
   n = 9;
    #100;
//    $stop();
  end
endmodule

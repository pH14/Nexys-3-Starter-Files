`timescale 1ns / 1ps
///////////////////////////////////////////
// MIT 6.111 debounce circuit 
// http://web.mit.edu/6.111/www/f2012/handouts/labs/debounce.v
///////////////////////////////////////////
module debounce (input reset, clock, noisy,
                 output reg clean);

   reg [19:0] count;
   reg new;

   always @(posedge clock)
     if (reset) begin new <= noisy; clean <= noisy; count <= 0; end
     else if (noisy != new) begin new <= noisy; count <= 0; end
     else if (count == 650000) clean <= new;
     else count <= count+1;

endmodule

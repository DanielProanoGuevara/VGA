/* source file for a clock divider
 in file clock_divider.v
 designed by: Daniel Proaño
              Pedro Faria
 */

`timescale 1ns / 1ps

// Counter based
module clock_divider(
       input wire clk, // 100 MHz
       output reg clk_div = 0 // 25 MHz
		     );

   localparam div_value = 1;
   // division_value = 100MHZ/(2*desired Frequency) -1

   integer    counter_value = 0;

   // counter
   always@ (posedge clk) begin
      if (counter_value == div_value)
	counter_value <= 0;
      else
	counter_value <= counter_value + 1;
      
   end

   // divide clock
   always@ (posedge clk) begin
      if (counter_value == div_value)
	clk_div <= ~clk_div;
      else
	clk_div <= clk_div;
      
   end
   
   


endmodule // clock_divider

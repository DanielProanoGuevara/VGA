/* test bench for clock_divider.v
 saved in clock_divider_tb.v */
`include "clock_divider.v"

`timescale 1ns / 1ps

module clock_divider_tb;
   reg clk = 0;
   wire clk_div;

   // wrapper
   clock_divider UUT(
         .clk(clk),
	 .clk_div(clk_div)
		     );

   initial begin
      clk=1;
      forever #5 clk = ~clk; 
   end

   initial
     begin
	$dumpfile("clock_divider.vcd");
	$dumpvars(0, clock_divider_tb);

	#50 $finish;
	
     end
   
   
endmodule // clock_divider_tb

/* source file for vertical counter module
 saved in vertical_counter.v */

`timescale 1ns / 1ps

module vertical_counter(
       input 		 clk_25MHz,
       input 		 enable_V_counter,
       output reg [15:0] V_Count_Value = 0,
			  );

   always@(posedge clk_25MHz) begin
      if (V_Count_Value < 525 && enable_V_counter == 1'b1) //VGA standard
	V_Count_Value <= V_Count_Value + 1;
      else 
	V_Counter_Value <= 0; // Reset H counter
   end
endmodule // vertical_counter

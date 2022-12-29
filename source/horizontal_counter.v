/* source file for horizontal counter module
 saved in horizontal_counter.v */

`timescale 1ns / 1ps

module horizontal_counter(
       input 		 clk_25MHz,
       output reg 	 enable_V_counter = 0,
       output reg [15:0] H_Count_Value = 0
			  );

   always@(posedge clk_25MHz) begin
      if (H_Count_Value < 799) begin //VGA standard
	H_Count_Value <= H_Count_Value + 1;
        enable_V_counter <= 0;
      end
      else begin
	 H_Count_Value <= 0; // Reset H counter
	 enable_V_counter <= 1; // Trigger V counter
      end
   end
endmodule // horizontal_counter

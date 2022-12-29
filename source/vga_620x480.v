/* source file for a vga module
 resolution of 620 x 480
 saved in vga_620x480.v */

`timescale 1ns / 1ps

`include "clock_divider.v"
`include "vertical_counter.v"
`include "horizontal_counter.v"

module vga(
	   input clk,
	   input  [15:0] pixel,
	   output v_sync,
	   output h_sync,
	   output [3:0] Red,
	   output [3:0] Green,
	   output [3:0] Blue,
	   output reg[31:0] pixel_ADDR
	   );

   wire 		clk_25M;
   wire 		enable_V_counter;
   wire [15:0] 		H_count_value;
   wire [15:0] 		V_count_value;
   reg [31:0] 		ADDR_count = 32'h00000000;
   
   
   // Module Instantiation
   clock_divider VGA_clk_gen (clk, clk_25M);
   horizontal_counter VGA_H_count (clk_25M, enable_V_counter, H_count_value);
   vertical_counter VGA_V_count (clk_25M ,enable_V_counter, V_count_value);

   // Outputs
   assign h_sync = (H_count_value < 96 || (H_count_value < 784 && H_count_value > 143)) ? 1'b1:1'b0;
   assign v_sync = (V_count_value < 2 || (V_count_value < 515 && V_count_value > 34)) ? 1'b1:1'b0;
   // Colors
   assign Red = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? pixel[11:8]:4'h0;
   assign Green = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? pixel[7:4]:4'h0;
   assign Blue = (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) ? pixel[3:0]:4'h0;
   // Address generator
   always@(posedge clk_25M) begin
      if (H_count_value < 784 && H_count_value > 143 && V_count_value < 515 && V_count_value > 34) begin
	 ADDR_count <= ADDR_count + 1;
      end
      if (ADDR_count == 297599) begin
	 ADDR_count <= 32'h00000000;
      end
      pixel_ADDR <= ADDR_count << 4;
   end
   
endmodule // vga

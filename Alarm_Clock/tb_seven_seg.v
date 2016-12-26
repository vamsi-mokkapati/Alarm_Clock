`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:08:42 11/02/2016
// Design Name:   seven_segment
// Module Name:   C:/Users/152/Desktop/stopwatch/tb_seven_seg.v
// Project Name:  blah
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_segment
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_seven_seg;

	// Inputs
	reg [3:0] digit;

	// Outputs
	wire [7:0] seg;

	// Instantiate the Unit Under Test (UUT)
	seven_segment uut (
		.digit(digit), 
		.seg(seg)
	);

	initial begin
		// Initialize Inputs
		digit = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:51:29 10/26/2016
// Design Name:   clock
// Module Name:   C:/Users/152/Desktop/blah/tb_clock.v
// Project Name:  blah
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clock;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire clk_1hz, clk_fast, clk_blink;

	// Instantiate the Unit Under Test (UUT)
	clock uut (
		.clk(clk), 
		.rst(rst), 
		.clk_1hz(clk_1hz),
      .clk_fast(clk_fast),
		.clk_blink(clk_blink)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        forever begin
            #10;
            
            clk = ~clk;
        end

        
		// Add stimulus here

	end
      
endmodule


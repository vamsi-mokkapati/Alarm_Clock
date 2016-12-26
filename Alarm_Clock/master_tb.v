`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:11 11/05/2016
// Design Name:   master_control
// Module Name:   /home/michael/Documents/random-projects/stopwatch/master_tb.v
// Project Name:  blah
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: master_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module master_tb;

	// Inputs
	reg clk;
	//wire [7:0] sw;
    reg   rst, adj, sel, pause;
    reg [10:0] cycle;
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	master_control uut (
		.clk(clk), 
		//.sw(sw), 
		.rst(rst),
        .adj(adj),
        .sel(sel),
        .pause(pause),
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		//sw = 0;
		//seg = 8'b0;
		//an = 4'b0;
		rst = 0;
        adj = 0;
        sel = 0;
        pause = 0;
        cycle = 0;

		// Wait 100 ns for global reset to finish
		#100;
		forever begin
            #10;
            adj = 1;
            sel = 0;
            //rst = 1;
            /*if (cycle == 1000)
                adj = 1;
            if (cycle == 2000)
                sel = 1;
            if (cycle == 3000)
                adj = 0;
            if (cycle == 4000)
                pause = 1;
            if (cycle == 5000)
                pause = 0;
            if (cycle == 6000)
                rst = 1;*/
            //cycle = cycle + 1;
            //if (cycle > 100) begin
            
            //end
            
            clk = ~clk;
		end
		
        
		// Add stimulus here

	end
      
endmodule


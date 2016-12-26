`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:46:09 11/28/2016 
// Design Name: 
// Module Name:    counter_milli 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter_milli(
	input clk_used,
    input rst,
    input adj,
    input sel,
    input is_running,
    input is_fwd_or_bkwd,
    output reg[3:0] digit1,
    output reg[3:0] digit2,
    output reg[3:0] digit3,
    output reg[3:0] digit4
    );
	
	always @ (posedge clk_used) begin
        if (rst) begin
				digit1 <= 0;
				digit2 <= 0;
				digit3 <= 0;
				digit4 <= 0;
			end
            else if (is_fwd_or_bkwd && digit1 == 'd9 && digit2 == 'd9 && digit3 == 'd9 && digit4 == 'd9) begin
                //blah
            end
            
			else if (is_running && is_fwd_or_bkwd) begin
        // if running and counting forward
				
				if (digit4 == 'd9) begin
					digit4 <= 0;
					if (digit3 == 'd9) begin
						 digit3 <= 0;
						 if (digit2 == 'd9) begin
							 digit2 <= 0;
							 if (digit1 == 'd9) begin
								 digit1 <= 0;
							 end
							 else begin
								digit1 <= digit1 + 1;
							 end
						 end
						 else begin
							digit2 <= digit2 + 1;
						 end
					 end
					else begin
						digit3 <= digit3 + 1;
					end
				end
				else begin
					digit4 <= digit4 + 1;
				end
				/*if (digit3 == 'd9 && digit4 == 'd9)
					digit3 <= 0;
					if (digit2 == 'd9) begin
						digit2 <= 0;*/
			end
            
            else if (digit1 == 'd0 && digit2 == 'd0 && digit3 == 'd0 && digit4 == 'd0) begin
                //blah
            end
            
            else if (is_running && !is_fwd_or_bkwd) begin
                if (digit4 == 'd0) begin
					digit4 <= 'd9;
					if (digit3 == 'd0) begin
						 digit3 <= 'd9;
						 if (digit2 == 'd0) begin
							 digit2 <= 'd9;
							 if (digit1 == 'd0) begin
								 digit1 <= 'd9;
							 end
							 else begin
								digit1 <= digit1 - 1;
							 end
						 end
						 else begin
							digit2 <= digit2 - 1;
						 end
					 end
					else begin
						digit3 <= digit3 - 1;
					end
				end
				else begin
					digit4 <= digit4 - 1;
				end
				/*if (digit3 == 'd9 && digit4 == 'd9)
					digit3 <= 0;
					if (digit2 == 'd9) begin
						digit2 <= 0;*/
			end
		end
endmodule

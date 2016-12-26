`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:16 11/02/2016 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input clk,
    input clk_1hz, input clk_2hz, 
    input clk_fast, input clk_blink,
    input sel, input adj,
    input pause, input rst
    //output an, 
	 //output is_blinking, //output clk_blink_out,
    //output is_min_increasing, output is_sec_increasing
    //output clk_control_counter
    );
    
    wire clk_1hz, clk_2hz, 
    clk_fast, clk_blink;
    
    
    
    always @(*) begin
        clk_control_counter = clk_1hz;
        is_min_increasing = 1;
        is_sec_increasing = 1;
        if (pause == 1) begin
            is_min_increasing = 0;
            is_sec_increasing = 0;
        end
        else if (adj == 1) begin
            if (sel == 0) begin
                //is_min_increasing = 1;
                //is_sec_increasing = 0;
            end
            else begin
                //is_min_increasing = 0;
                //is_sec_increasing = 1;
            end
            //clk_control_counter = clk_2hz;
        end
        
        //an = 1;
    end
    
endmodule

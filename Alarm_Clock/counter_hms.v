`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:01 11/23/2016 
// Design Name: 
// Module Name:    counter_hms 
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
module counter_hms(
    input clk_used,
    input rst,
    input adj,
    input sel,
    input is_running,
    input is_fwd_or_bkwd,
    output reg[3:0] minutes_top_digit,
    output reg[3:0] minutes_bot_digit,
    output reg[3:0] seconds_top_digit,
    output reg[3:0] seconds_bot_digit
    );
    
    
     
     /*always @() begin
        
     end*/
    
    always @ (posedge clk_used) begin
        if (rst) begin
            minutes_top_digit <= 0;
            minutes_bot_digit <= 0;
            seconds_top_digit <= 0;
            seconds_bot_digit <= 0;
        end
        
        else if (is_running && is_fwd_or_bkwd) begin
        // if running and counting forward
            if (adj == 0) begin
            // seconds control
                seconds_bot_digit <= seconds_bot_digit + 1;
                // if we reach 9 seconds
                if (seconds_bot_digit == 'd9) begin
                    seconds_bot_digit <= 0;
                    seconds_top_digit <= seconds_top_digit + 1;
                end
                // if we reach 59 seconds
                if (seconds_top_digit == 'd5 && seconds_bot_digit == 'd9) begin
                    seconds_top_digit <= 0;
                    if (minutes_bot_digit == 'd9) begin
                        minutes_bot_digit <= 0;
                        minutes_top_digit <= minutes_top_digit + 1;
                    end
                    else begin
                        minutes_bot_digit <= minutes_bot_digit + 1;
                    end
                end
            end
            // adjust seconds
            else if (adj == 1 && sel == 1) begin
            
                seconds_bot_digit <= seconds_bot_digit + 1;
                // if we reach 9 seconds
                if (seconds_bot_digit == 'd9) begin
                    seconds_bot_digit <= 0;
                    seconds_top_digit <= seconds_top_digit + 1;
                end
                if (seconds_top_digit == 'd5 && seconds_bot_digit == 'd9) begin
                    seconds_top_digit <= 0;
                   
                end
            end
            
            // if adjust = 1, always increase minutes
            if (adj == 1 && sel == 0) begin
                if (minutes_bot_digit == 'd9) begin
                    minutes_bot_digit <= 0;
                    minutes_top_digit <= minutes_top_digit + 1;
                end
                else begin
                    minutes_bot_digit <= minutes_bot_digit + 1;
                end
                //minutes_bot_digit <= minutes_bot_digit + 1;
            end
            if (adj == 0) begin
                if (minutes_top_digit == 'd9 && minutes_bot_digit == 'd9) begin
                    minutes_top_digit <= 0;
                end
            end
            if (adj == 1 && sel == 0) begin
            // if at 9 minutes
                /*if (minutes_bot_digit == 'd9) begin
                    minutes_bot_digit <= 0;
                    minutes_top_digit <= minutes_top_digit + 1;
                end*/
                if (minutes_top_digit == 'd9 && minutes_bot_digit == 'd9) begin
                    minutes_top_digit <= 0;
                end
            end
        end
        else if (!minutes_top_digit && !minutes_bot_digit && !seconds_top_digit && !seconds_bot_digit) begin
            //
        end
        else if (is_running && !is_fwd_or_bkwd) begin
        // if running and counting backward
            if (adj == 0) begin
                seconds_bot_digit <= seconds_bot_digit - 1;
                if (seconds_bot_digit == 'd0) begin
                    seconds_bot_digit <= 9;
                    seconds_top_digit <= seconds_top_digit - 1;
                end
                if (seconds_top_digit == 'd0 && seconds_bot_digit == 'd0) begin
                    seconds_top_digit <= 5;
                    seconds_bot_digit <= 9;
                    if (minutes_bot_digit) begin
                        minutes_bot_digit <= minutes_bot_digit - 1;
                    end
                    else if (minutes_top_digit != 0) begin
                        minutes_top_digit <= minutes_top_digit - 1;
                        minutes_bot_digit <= 9;
                    end
                end
            end
            // adjust seconds
            if (adj == 1 && sel == 1) begin
                seconds_bot_digit <= seconds_bot_digit - 1;
                if (seconds_bot_digit == 'd0) begin
                    seconds_bot_digit <= 9;
                    seconds_top_digit <= seconds_top_digit - 1;
                end
                if (seconds_top_digit == 'd0 && seconds_bot_digit == 'd0) begin
                    seconds_top_digit <= 5;
                    seconds_bot_digit <= 9;
                end
            end
            
            /*if (adj == 1 && sel == 0) begin
                minutes_bot_digit <= minutes_bot_digit - 1;
            end*/
            // adjust minutes
            if (adj == 1 && sel == 0) begin
                if (minutes_bot_digit == 'd0 && minutes_top_digit == 'd0) begin
                    
                end
                else if (minutes_bot_digit == 'd0 && minutes_top_digit != 'd0) begin
                    minutes_bot_digit <= 9;
                    minutes_top_digit <= minutes_top_digit - 1;
                end
                else begin
                    minutes_bot_digit <= minutes_bot_digit - 1;
                end
                /*if (minutes_top_digit == 'd0 && minutes_bot_digit == 'd0) begin
                    minutes_top_digit <= 9;
                    minutes_bot_digit <= 9;
                end*/
            end
        end
        
        
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:35 10/26/2016 
// Design Name: 
// Module Name:    counter 
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
module counter(
    input clk,
    input clk_1hz,
	 input clk_2hz,
	 input clk_fast,
     input clk_1min,
	  input clk_1ms,
      input clk_sound,
    input rst,
	 input pause,
	 input adj,
	 input sel,
     input [9:0] jstkPosX,
     input [9:0] jstkPosY,
     output reg sound_out,
    output reg[3:0] minutes_top_digit,
    output reg[3:0] minutes_bot_digit,
    output reg[3:0] seconds_top_digit,
    output reg[3:0] seconds_bot_digit
    );
    
	 initial minutes_top_digit <= 0;
	 initial minutes_bot_digit <= 0;
	 initial seconds_top_digit <= 0;
	 initial seconds_bot_digit <= 0;
     reg is_running = 0;
     reg is_fwd_or_bkwd = 1; // 1 = forward, 0 = backward
     reg [1:0] cnt_units = 1; // 0 = milliseconds, 1 = sec/min, 2 = min/hours
     reg [26:0] cnt_jstk = 'd25_000_000;
     
     
     
     
     //reg clk_rst = 0;
     
	  reg ms_clk_used;
     reg is_mins_secs = 1;
     wire[3:0] ms_min_top;
     wire[3:0] ms_min_bot;
     wire[3:0] ms_sec_top;
     wire[3:0] ms_sec_bot;
     
     counter_hms counter_mins_secs(.clk_used(ms_clk_used), .rst(rst), .sel(sel), .adj(adj),
        .is_running(is_mins_secs), .is_fwd_or_bkwd(is_fwd_or_bkwd),
        .minutes_top_digit(ms_min_top), .minutes_bot_digit(ms_min_bot),
        .seconds_top_digit(ms_sec_top), .seconds_bot_digit(ms_sec_bot));
        
     reg hm_clk_used;
	  reg is_hours_mins = 0;
     wire[3:0] hm_min_top;
     wire[3:0] hm_min_bot;
     wire[3:0] hm_sec_top;
     wire[3:0] hm_sec_bot;
     counter_hms counter_hours_mins(.clk_used(hm_clk_used), .rst(rst), .sel(sel), .adj(adj),
        .is_running(is_hours_mins), .is_fwd_or_bkwd(is_fwd_or_bkwd),
        .minutes_top_digit(hm_min_top), .minutes_bot_digit(hm_min_bot),
        .seconds_top_digit(hm_sec_top), .seconds_bot_digit(hm_sec_bot));
     
	  reg milli_clk_used;
	  reg is_milli = 0;
     wire[3:0] milli_digit4;
     wire[3:0] milli_digit3;
     wire[3:0] milli_digit2;
     wire[3:0] milli_digit1;
     counter_milli counter_milliseconds(.clk_used(milli_clk_used), .rst(rst), .sel(sel), .adj(adj),
        .is_running(is_milli), .is_fwd_or_bkwd(is_fwd_or_bkwd),
        .digit4(milli_digit4), .digit3(milli_digit3),
		  .digit2(milli_digit2), .digit1(milli_digit1));
		  
     always @(posedge clk) begin
        
        if (adj == 1) begin
            ms_clk_used <= clk_2hz;
            hm_clk_used <= clk_2hz;
				milli_clk_used <= clk_2hz;
        end
        else begin
            ms_clk_used <= clk_1hz;
            hm_clk_used <= clk_1min;
				milli_clk_used <= clk_1ms;
        end
        if (pause) begin
            /*if (!is_running) begin
                // about to pause, so pause all clocks
                is_mins_secs <= 0;
                is_hours_mins <= 0;
                is_milli <= 0;
            end*/
            is_running <= ~is_running;
        end
        else if (jstkPosX >= 'd800) begin
            //adj = 1;
            //clk_used = clk_2hz;
            //minutes_top_digit <= 'd9;
            is_running <= 1;
            is_fwd_or_bkwd <= 0;
        end
        else if (jstkPosX <= 'd200) begin
            is_running <= 1;
            is_fwd_or_bkwd <= 1;
        end
        // new stuffs below
        if (jstkPosY >= 'd800 && cnt_units != 0) begin
            if (cnt_jstk != 0)
                cnt_jstk <= cnt_jstk - 1;
            
        end
        else if (jstkPosY <= 'd200 && cnt_units != 'd2) begin
            if (cnt_jstk != 'd50_000_000)
                cnt_jstk <= cnt_jstk + 1;
            /*if (!adj && cnt_units == 1) begin
                clk_used <= clk_1min;
            end*/
            //cnt_units <= cnt_units + 1;
            //clk_rst <= 1;
        end
        
        if (cnt_jstk < 'd12_500_000) begin
            cnt_units <= 0;
        end
        else if (cnt_jstk > 'd37_500_000) begin
            cnt_units <= 2;
        end
        else begin
            cnt_units <= 1;
        end
        // milliseconds
        if (cnt_units == 0) begin
            is_mins_secs <= 0;
            is_hours_mins <= 0;
            is_milli <= is_running;
            minutes_top_digit <= milli_digit1;
            minutes_bot_digit <= milli_digit2;
            seconds_top_digit <= milli_digit3;
            seconds_bot_digit <= milli_digit4;
        end
        // mins/secs
        if (cnt_units == 1) begin
            is_mins_secs <= is_running;
            is_hours_mins <= 0;
            is_milli <= 0;
            minutes_top_digit <= ms_min_top;
            minutes_bot_digit <= ms_min_bot;
            seconds_top_digit <= ms_sec_top;
            seconds_bot_digit <= ms_sec_bot;
        end
        // hours/mins
        if (cnt_units == 2) begin
            is_mins_secs <= 0;
            is_hours_mins <= is_running;
            is_milli <= 0;
            minutes_top_digit <= hm_min_top;
            minutes_bot_digit <= hm_min_bot;
            seconds_top_digit <= hm_sec_top;
            seconds_bot_digit <= hm_sec_bot;
        end
        if (!is_fwd_or_bkwd && minutes_top_digit == 0 && minutes_bot_digit == 0
            && seconds_top_digit == 0 && seconds_bot_digit == 0)
        begin
            if (clk_sound)
                sound_out <= 8'b1111_1111;
            else
                sound_out <= 0;
            //minutes_top_digit <= clk_sound;
        end
        else
        begin
            sound_out <= 0;
        end
      end

endmodule

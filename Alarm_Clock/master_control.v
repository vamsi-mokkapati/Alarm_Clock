`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:43 11/02/2016 
// Design Name: 
// Module Name:    master_control 
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
module master_control(
    input clk, input adj,
    input sel,
    input rst,
    input pause,
    input MISO,
	input [2:0] SW,
    output wire [7:0] sound_out,
    output wire SS,
    output wire MOSI,
    output wire SCLK,
	 output wire [7:0] seg,
	 output wire [3:0] an
    );
     
    // input MISO;					// Master In Slave Out, Pin 3, Port JA
    //input [2:0] SW;			// Switches 2, 1, and 0
    //output SS;					// Slave Select, Pin 1, Port JA
    //output MOSI;				// Master Out Slave In, Pin 2, Port JA
    //output SCLK;				// Serial Clock, Pin 4, Port JA
    //output [2:0] LED;			// LEDs 2, 1, and 0

	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================
    //wire SS;						// Active low
    //wire MOSI;					// Data transfer from master to slave
    //wire SCLK;					// Serial clock that controls communication
    //reg [2:0] LED;				// Status of PmodJSTK buttons displayed on LEDs
    
    // Holds data to be sent to PmodJSTK
    wire [7:0] sndData;

    // Signal to send/receive data to/from PmodJSTK
    wire sndRec;

    // Data read from PmodJSTK
    wire [39:0] jstkData;
    
    // never reset joystick
    wire jstkRst = 0;
    //-----------------------------------------------
    //  	  			PmodJSTK Interface
    //-----------------------------------------------
    PmodJSTK PmodJSTK_Int(
            .CLK(clk),
            .RST(jtskRst),
            .sndRec(sndRec),
            .DIN(sndData),
            .MISO(MISO),
            .SS(SS),
            .SCLK(SCLK),
            .MOSI(MOSI),
            .DOUT(jstkData)
    );
    
    //-----------------------------------------------
    //  			 Send Receive Generator
    //-----------------------------------------------
    ClkDiv_5Hz genSndRec(
            .CLK(clk),
            .RST(jstkRst),
            .CLKOUT(sndRec)
    );
    
    wire [9:0] jstkPosX;
     wire [9:0] jstkPosY;
     
      wire [3:0] minutes_top;
	 wire [3:0] minutes_bot;
	 wire [3:0] seconds_top;
	 wire [3:0] seconds_bot;
     
     assign sndData = 10'b10_0000_0000;
     assign jstkPosX = {jstkData[25:24], jstkData[39:32]};
     assign jstkPosY = {jstkData[9:8], jstkData[23:16]};
     
     
    
	 
     wire pause_state, rst_state;
	 wire clk_1hz, clk_2hz, clk_fast, clk_blink, clk_1min, clk_1ms;
     
	 
	 clock clock1(.clk(clk),
        .clk_1hz(clk_1hz), .clk_2hz(clk_2hz), .clk_fast(clk_fast),
        .clk_blink(clk_blink), .clk_1min(clk_1min), .clk_1ms(clk_1ms), .clk_sound(clk_sound));
        
    debouncer rst_deb(.btn(rst), .clk(clk), .btn_state(rst_state));
    debouncer pause_deb(.btn(pause), .clk(clk), .btn_state(pause_state));
		  
	
	 counter counter1(.clk(clk), .clk_1hz(clk_1hz), .clk_2hz(clk_2hz),
		.clk_fast(clk_fast),
        .clk_1min(clk_1min),
        .clk_1ms(clk_1ms),
        .clk_sound(clk_sound),
		.rst(rst_state),
		  .sel(sel), .adj(adj), .pause(pause_state),
          .jstkPosX(jstkPosX),
          .jstkPosY(jstkPosY),
          .sound_out(sound_out),
		  .minutes_top_digit(minutes_top),
		  .minutes_bot_digit(minutes_bot),
		  .seconds_top_digit(seconds_top),
		  .seconds_bot_digit(seconds_bot));

	 wire [7:0] seg_min_top;
	 wire [7:0] seg_min_bot;
	 wire [7:0] seg_sec_top;
	 wire [7:0] seg_sec_bot;

	 seven_segment seg_min1(minutes_top, seg_min_top);
	 seven_segment seg_min0(minutes_bot, seg_min_bot);
	 seven_segment seg_sec1(seconds_top, seg_sec_top);
	 seven_segment seg_sec0(seconds_bot, seg_sec_bot);
	 display display1(.clk_fast(clk_fast), .clk_blink(clk_blink),
		.adj(adj), .sel(sel), .seg_min_top(seg_min_top), .seg_min_bot(seg_min_bot),
		.seg_sec_top(seg_sec_top), .seg_sec_bot(seg_sec_bot),
		.seg_out(seg), .an(an));

endmodule

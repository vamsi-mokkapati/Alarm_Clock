`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:05 11/07/2016 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input btn,
    input clk,
    output reg btn_state
    );
    
    reg [15:0] counter = 0;
    reg got_btn;
    initial got_btn = 0;
    initial btn_state = 0;
    
    always @(posedge clk) begin
        if (counter == 'hffff) begin
            btn_state <= 1;
            got_btn <= 0;
            counter <= 0;
        end
        else if (got_btn) begin
            counter <= counter + 1;
        end
        else if (btn == 1) begin
            got_btn <= 1;
        end
        else if (btn == 0) begin
            got_btn <= 0;
            counter <= 0;
            btn_state <= 0;
        end 
    end


endmodule

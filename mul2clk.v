`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:57 03/21/2016 
// Design Name: 
// Module Name:    mul2clk 
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
module mul2clk(
	input clk,
	input rst,
	output clock1,
	output clock2,
	output clock3);

reg[2:0] cnt;
parameter i=1;
parameter j=2;
parameter k=3;
always @(posedge clk)
	if(!rst) cnt<=3'b111;
	else cnt <=cnt+3'd1;
assign clock1=cnt[i-1];
assign clock2=cnt[j-1];
assign clock3=cnt[k-1];
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:11 03/08/2016 
// Design Name: 
// Module Name:    mux8to1_32 
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
module mux8to1_32(input  [2:0]sel,input  [31:0] x0, input  [31:0]x1,input  [31:0]x2 ,input  [31:0]x3, 
input  [31:0]x4 ,input  [31:0]x5,input  [31:0]x6,input  [31:0]x7,output reg [31:0]o);
	initial o<=32'h00000000;
    always @(*) begin
       case (sel[2:0])
		    3'b000 : begin o <= x0; end
			 3'b001 : begin o <= x1; end
			 3'b010 : begin o <= x2; end
			 3'b011 : begin o <= x3; end
			 3'b100 : begin o <= x4; end
			 3'b101 : begin o <= x5; end
			 3'b110 : begin o <= x6; end
			 3'b111 : begin o <= x7; end
       endcase
    end

endmodule
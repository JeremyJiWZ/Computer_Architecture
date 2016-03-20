`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:26 03/08/2016 
// Design Name: 
// Module Name:    mux2to1_32 
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
module mux2to1_32(input  sel,input  [31:0]a, input  [31:0]b, output reg [31:0]o);
initial o<=32'h00000000;
    always @(*) begin
       case (sel)
		    1'b0 : begin o <= a; end
			 1'b1 : begin o <= b; end
       endcase
    end

endmodule


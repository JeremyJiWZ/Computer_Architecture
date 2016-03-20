`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:16:04 03/13/2016
// Design Name:   ALU
// Module Name:   C:/CA_LAB/singal_cpu/testALU.v
// Project Name:  singal_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testALU;

	// Inputs
	reg [2:0] ALU_operation;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] res;
	wire zero;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALU_operation(ALU_operation), 
		.A(A), 
		.B(B), 
		.res(res), 
		.zero(zero), 
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		ALU_operation = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
      ALU_operation=3'b001;
		A=1;
		B=1;
		#50;
		
		A=1;B=0;
		#50;
		
		// Add stimulus here

	end
      
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:14:45 03/21/2016
// Design Name:   mul2clk
// Module Name:   C:/CA_LAB/singal_cpu/TestClk.v
// Project Name:  singal_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mul2clk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestClk;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire clock1;
	wire clock2;
	wire clock3;

	// Instantiate the Unit Under Test (UUT)
	mul2clk uut (
		.clk(clk), 
		.rst(rst), 
		.clock1(clock1), 
		.clock2(clock2), 
		.clock3(clock3)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   always begin
	clk=~clk;
	#50;
	end
endmodule


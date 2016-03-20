`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:37:32 03/13/2016
// Design Name:   control
// Module Name:   C:/CA_LAB/singal_cpu/controlTest.v
// Project Name:  singal_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controlTest;

	// Inputs
	reg clk;
	reg reset;
	reg [5:0] opcode;
	reg [5:0] func;

	// Outputs
	wire ALUSrc1;
	wire RegWrite;
	wire ALUSrc2;
	wire MemWrite;
	wire [2:0] ALUControl;
	wire Mem2Reg;
	wire MemRead;
	wire BranchEq;
	wire BranchNeq;
	wire [1:0] PCSrc;
	wire RegDst;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.clk(clk), 
		.reset(reset), 
		.opcode(opcode), 
		.func(func), 
		.ALUSrc1(ALUSrc1), 
		.RegWrite(RegWrite), 
		.ALUSrc2(ALUSrc2), 
		.MemWrite(MemWrite), 
		.ALUControl(ALUControl), 
		.Mem2Reg(Mem2Reg), 
		.MemRead(MemRead), 
		.BranchEq(BranchEq), 
		.BranchNeq(BranchNeq), 
		.PCSrc(PCSrc), 
		.RegDst(RegDst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		opcode = 0;
		func = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		opcode = 6'h00;
		func = 6'h08;
		
		end
	
	always begin
		#25;
		clk=~clk;
	end
      
endmodule


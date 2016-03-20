`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:57:46 03/13/2016
// Design Name:   singal_cpu
// Module Name:   C:/CA_LAB/singal_cpu/TEST.v
// Project Name:  singal_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: singal_cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TEST;

	// Inputs
	reg clk_cpu;
	reg reset;
	reg [4:0] reg_num;

	// Outputs
	wire [31:0] pc_out;
	wire [31:0] inst_out;
	wire [31:0] register;

	// Instantiate the Unit Under Test (UUT)
	singal_cpu uut (
		.clk_cpu(clk_cpu), 
		.reset(reset), 
		.reg_num(reg_num), 
		.pc_out(pc_out), 
		.inst_out(inst_out), 
		.register(register)
	);

	initial begin
		// Initialize Inputs
		clk_cpu = 0;
		reset = 0;
		reg_num = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
   
	always begin
			#20;
			clk_cpu=~clk_cpu;
	end
endmodule


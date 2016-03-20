`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:38:37 03/07/2016 
// Design Name: 
// Module Name:    control 
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
module control(input wire clk,
					input wire reset,
					input wire [5:0]opcode,
					input wire [5:0]func,
					output reg regJal,
					output reg ALUSrc1,
					output reg RegWrite,
					output reg ALUSrc2,
					output reg MemWrite,
					output reg [2:0]ALUControl,
					output reg Mem2Reg,
					output reg MemRead,
					output reg BranchEq,
					output reg BranchNeq,
					output reg [1:0]PCSrc, //0 and 1 for pc+4, 2 for jump, 3 for jr
					output reg RegDst
    );
 `define CPU_ctrl_signals {regJal,ALUSrc1,ALUControl,RegWrite,ALUSrc2,MemWrite,Mem2Reg,MemRead,BranchEq,BranchNeq,PCSrc,RegDst}
initial begin `CPU_ctrl_signals <= 15'h0000; end
always @ * begin
	if(reset==1) begin `CPU_ctrl_signals <= 15'h0000; end
	else begin
	case (opcode[5:0])
		6'h00:begin
			//R-type
			case(func[5:0])
				6'b100000: `CPU_ctrl_signals <= 15'b000001000000001;//add
				6'b100010: `CPU_ctrl_signals <= 15'b000011000000001;//sub
				6'b100100: `CPU_ctrl_signals <= 15'b000101000000001;//and
				6'b100101: `CPU_ctrl_signals <= 15'b000111000000001;//or
				6'b101010: `CPU_ctrl_signals <= 15'b001111000000001;//slt
				6'b000010: `CPU_ctrl_signals <= 15'b011011000000001;//srl
				6'b001000: `CPU_ctrl_signals <= 15'b000000000000110;//jr
			endcase
			end
		//I-type
		6'h08: `CPU_ctrl_signals <= 15'b000001100000000; //adddi
		6'h0c: `CPU_ctrl_signals <= 15'b000101100000000; //andi
		6'h0d: `CPU_ctrl_signals <= 15'b000111100000000; //ori
		6'h23: `CPU_ctrl_signals <= 15'b000001101100000; //lw
		6'h0f: `CPU_ctrl_signals <= 15'b001101100000000; //lui
		6'h2b: `CPU_ctrl_signals <= 15'b000000110000000; //sw
		6'h2a: `CPU_ctrl_signals <= 15'b001111100000000; //slti
		6'h04: `CPU_ctrl_signals <= 15'b000010000010000; //beq
		6'h05: `CPU_ctrl_signals <= 15'b000010000001000; //bne
		//J-type
		6'h02: `CPU_ctrl_signals <= 15'b000000000000100; //Jump
		6'h03: `CPU_ctrl_signals <= 15'b100001000000100; //Jal
	endcase
	end
end

endmodule

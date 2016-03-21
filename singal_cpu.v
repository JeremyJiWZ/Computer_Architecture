`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:36 03/07/2016 
// Design Name: 
// Module Name:    singal_cpu 
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
module singal_cpu(input wire clk_cpu,
						input wire reset,
						input wire [4:0] reg_num,		//TEST
						//input wire [31:0] Data_in,
						//input INT,
						output [31:0] pc_out,			//TEST
						output [31:0] inst_out,			//TEST
						output [31:0] register			//TEST
						//output mem_w,
						//output [31:0] Addr_out,
						//output [31:0] Data_out
    );

	 //control signal:
wire signOrZero,regJal,ALUSrc1,RegWrite,ALUSrc2,MemWrite,Mem2Reg,MemRead,BranchEq,BranchNeq,RegDst;
wire [1:0] PCSrc;
wire [2:0] ALUControl;

//memory block
wire [31:0]mem_data_out;
wire [31:0]mem_data_in;
wire [31:0]mem_addr; 

control U1(.clk(clk_cpu),
			  .reset(reset),
			  .opcode(inst_out[31:26]),
			  .func(inst_out[5:0]),
			  .signOrZero(signOrZero),
			  .regJal(regJal),
			  .ALUSrc1(ALUSrc1),
			  .RegWrite(RegWrite),
			  .ALUSrc2(ALUSrc2),
			  .MemWrite(MemWrite),
			  .ALUControl(ALUControl[2:0]),
			  .Mem2Reg(Mem2Reg),
			  .MemRead(MemRead),
			  .BranchEq(BranchEq),
			  .BranchNeq(BranchNeq),
			  .PCSrc(PCSrc[1:0]),
			  .RegDst(RegDst));

Datapath Datapath(.cpu_clk(clk_cpu),
			.reset(reset),
			.signOrZero(signOrZero),
			.regJal(regJal),
			.ALUSrc1(ALUSrc1),
			.RegWrite(RegWrite),
			.ALUSrc2(ALUSrc2),
			.MemWrite(MemWrite),
			.ALUControl(ALUControl[2:0]),
			.Mem2Reg(Mem2Reg),
			.MemRead(MemRead),
			.BranchEq(BranchEq),
			.BranchNeq(BranchNeq),
			.PCSrc(PCSrc[1:0]),
			.RegDst(RegDst),
			
			.reg_num(reg_num[4:0]),//test
			.reg_data(register[31:0]),//test
			
			.mem_data_out(mem_data_out[31:0]),
			.mem_addr(mem_addr[31:0]),
			.mem_data_in(mem_data_in[31:0]),
			.PC_Current(pc_out[31:0]),
			.overflow(overflow),
			.zero(zero),
			.inst(inst_out[31:0])
			);
Memory DM(.clka(~clk_cpu),
			 .wea(MemWrite),
			 .addra(mem_addr[13:2]),
			 .dina(mem_data_in[31:0]),
			 .douta(mem_data_out[31:0]));
endmodule

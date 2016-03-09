`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:19 03/08/2016 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(input wire cpu_clk,
					 input wire reset,
					 input wire ALUSrc1,
					 input wire RegWrite,
					 input wire ALUSrc2,
					 input wire MemWrite,
					 input wire [2:0]ALUControl,
					 input wire Mem2Reg,
					 input wire MemRead,
					 input wire BranchEq,
					 input wire BranchNeq,
					 input wire [1:0]PCSrc,
					 input wire RegDst,
					 input wire [31:0]mem_data_out,
					 
					 input wire [4:0]reg_num, //for test
					 output [31:0]reg_data,   //for test
					 
					 output [31:0]mem_addr,
					 output [31:0]mem_data_in,
					 output [31:0]PC_Current,
					  
					 output overflow,
					 output zero,
					 output [31:0]inst
    );
//immdiate_sign_ext
wire [31:0]immediate_sign_ext;	 
	 
//pc next
wire [31:0]pc_next;
wire [31:0]pc_plus4;
wire [31:0]pc_jump;
wire [31:0]pc_jr;
wire [31:0]pc_no_branch;
wire [31:0]pc_branch;
wire [27:0]pc_jump_tmp;
wire Branch;
assign pc_jump_tmp = {inst[25:0]<<2,2'b00};
assign pc_plus4 = PC_Current[31:0]+4;
assign pc_jump = {pc_plus[31:28],pc_jump_tmp};
assign pc_jr = A[31:0]; 
assign pc_branch = immediate_sign_ext<<2+pc_plus4;
assign Branch = (BranchEq&zero)|(BranchNeq&~zero);

//regs
wire [4:0]rs;
wire [4:0]rt;
wire [4:0]rd;
wire [31:0]reg_data1;
wire [31:0]reg_data2;
wire [31:0]Wt_data;
assign rs = inst[25:21];
assign rt = inst[20:16];

//ALU
wire [31:0]A;
wire [31:0]B;
wire [31:0]res;

//instruction




REG32 PC(.clk(cpu_clk),
			.rst(reset),
			.CE(1),
			.D(pc_next),
			.Q(PC_Current));
			
Regs U1(.clk(~cpu_clk),
		  .rst(reset),
		  .L_S(RegWrite),
		  .R_Addr_A(rs[4:0]),
		  .R_Addr_B(rt[4:0]),
		  .Wt_addr(rd[4:0]),
		  .Wt_data(Wt_data[31:0]),
		  .test_addr(reg_num[4:0]),
		  .test_data(reg_data[31:0]),
		  .rdata_A(reg_data1[31:0]),
		  .rdata_B(reg_data2[31:0]));
		  
ALU U2(.ALUOperation(ALUControl[2:0]),
		 .A(A[31:0]),
		 .B(B[31:0]),
		 .res(res[31:0]),
		 .zero(zero),
		 .overflow(overflow));

mux4to1_32 U3(.sel(PCSrc[1:0]),
				  .a(pc_plus4[31:0]),
				  .b(pc_plus4[31:0]),
				  .c(pc_jump[31:0]),
				  .d(pc_jr[31:0]),
				  .o(pc_no_branch[31:0])
					);
mux2to1_32 U4(.sel(Branch),
				  .a(pc_no_branch[31:0]),
				  .b(pc_branch[31:0]),
				  .o(pc_next[31:0]));

Ext_32 U5(.imm_16(inst[15:0]),
			 .Imm_32(immediate_sign_ext[31:0]));

mux2to1_32 RD_IN(.sel(RegDst),
					  .a(inst[20:16]),
					  .b(inst[15:11]),
					  .o(rd[4:0]));

mux2to1_32 ALUS1(.sel(ALUSrc1),
					  .a(reg_data1[31:0]),
					  .b({27'h0000000,inst[10:6]}),
					  .o(A[31:0]));
					  
mux2to1_32 ALUS2(.sel(ALUSrc1),
					  .a(reg_data2[31:0]),
					  .b(immediate_sign_ext[31:0]),
					  .o(B[31:0]));
					  
mux2to1_32 Reg_Write(.sel(Mem2Reg),
							.a(res[31:0]),
							.b(mem_data_out[31:0]),
							.o(Wt_data[31:0]));

Inst_Mem InstMem(.a(PC_Current[11:2]),
					  .spo(inst[31:0]));
endmodule

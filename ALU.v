`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:59 03/08/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [2:0]ALU_operation, 
	input [31:0]A, 
	input [31:0]B,
	output [31:0]res,
	output zero,
	output overflow
    );
wire [31:0]X[7:0];
wire [32:0]S;
wire [31:0]So;
wire [31:0]B0;
assign X[0]=S[31:0];
assign X[1]=S[31:0];
assign X[6]={B[15:0],16'h0000};
assign X[7]={31'h00000000,S[31]};
and32 U1(.A(A[31:0]),
         .B(B[31:0]),
			.res(X[2]));
or32 U2(.A(A[31:0]),
        .B(B[31:0]),
		  .res(X[3]));
ADC32 U3(.C0(ALU_operation[0]),
         .A(A[31:0]),
         .B(B0[31:0]),
		   .S(S[32:0]));
srl32 U6(.A(A[31:0]),
         .B(B[31:0]),
		   .res(X[5]));
xor32 U7(.A(So[31:0]),
         .B(B[31:0]),
		   .res(B0[31:0]));
SignalExt_32 U8(.S(ALU_operation[2]),
             .So(So[31:0]));
				 
mux8to1_32 U9(.sel(ALU_operation[2:0]),
           .x0(X[0]),
           .x1(X[1]),
           .x2(X[2]),
           .x3(X[3]),
           .x4(X[4]),
           .x5(X[5]),
           .x6(X[6]),
           .x7(X[7]),
			  .o(res[31:0]));
or_bit_32 U10(.A(res[31:0]),
              .o(zero));
endmodule

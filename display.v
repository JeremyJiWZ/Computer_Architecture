`include "define.vh"


/**
 * Display using character LCD.
 * Author: Zhao, Hongyu  <power_zhy@foxmail.com>
 */
module display (
	input wire clk,
	input wire rst,
	input wire [31:0] data,
	input wire [11:0] pc,
	input wire [7:0] reg_num,
	input wire [31:0] inst,
	
	// character LCD interfaces
	output wire lcd_e,
	output wire lcd_rs,
	output wire lcd_rw,
	output wire [3:0] lcd_dat
	);
	
	reg [255:0] strdata ;
	
	function [7:0] num2str;
		input [3:0] number;
		begin
			if (number < 10)
				num2str = "0" + number;
			else
				num2str = "A" - 10 + number;
		end
	endfunction
	
	genvar i;
	generate for (i=0; i<8; i=i+1) begin: NUM2STR
		always @(posedge clk) begin
			strdata[8*i+7-:8] <= num2str(data[4*i+3-:4]); //register
			strdata[8*i+143-:8] <= num2str(inst[4*i+3-:4]); //inst
		end
	end
	endgenerate
	
	always @(posedge clk) begin
		//display pc
		strdata[215:208] <= num2str(pc[3:0]);
		strdata[223:216] <= num2str(pc[7:4]);
		strdata[231:224] <= num2str(pc[11:8]);
		
		//display reg num
		strdata[79:72] <= num2str(reg_num[3:0]);
		strdata[87:80] <= num2str(reg_num[7:4]);
	end
	

	reg refresh = 0;
	reg [31:0] data_buf;
	reg [31:0] pc_buf;
	reg [31:0] inst_buf;
	reg [7:0] reg_buf;
	
	always @(posedge clk) begin
		data_buf <= data;
		pc_buf <= pc;
		inst_buf <= inst;
		reg_buf <= reg_num;
		refresh <= (pc_buf != pc) || (data_buf != data) || (inst_buf != inst) || (reg_buf != reg_num);
	end
	
	displcd DISPLCD (
		.CCLK(clk),
		.reset(rst | refresh),
		.strdata(strdata),
		.rslcd(lcd_rs),
		.rwlcd(lcd_rw),
		.elcd(lcd_e),
		.lcdd(lcd_dat)
		);
	
endmodule

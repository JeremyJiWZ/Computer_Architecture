`include "define.vh"


/**
 * Top module for MIPS 5-stage pipeline CPU.
 * Author: Zhao, Hongyu  <power_zhy@foxmail.com>
 */
module mips_top (
	input wire CCLK,
	input wire [3:0] SW,
	input wire BTNN, BTNE, BTNS, BTNW,
	input wire ROTA, ROTB, ROTCTR,
	output wire [7:0] LED,
	output wire LCDE, LCDRS, LCDRW,
	output wire [3:0] LCDDAT
	);
	
	// clock generator
	wire clk_cpu, clk_disp;
	wire locked;
	wire btn_clk;
	wire [31:0]disp;
	
	//signal for cpu
	wire [4:0]reg_num;
	wire [31:0]pc_out;
	wire [31:0]inst_out;
	wire [31:0]register;
	wire [7:0]reg_num_disp;
	
	clk_gen CLK_GEN (
		.clk_pad(CCLK),
		.clk_100m(),
		.clk_50m(clk_disp),
		.clk_25m(),
		.clk_10m(clk_cpu),
		.locked(locked)
		);
	
	// anti-jitter
	wire [3:0] switch;
	wire btn_reset, btn_step;
	wire btn_interrupt;
	wire disp_prev, disp_next;
	wire btn_reg;
	
	`ifndef SIMULATING
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_SW0 (.clk(clk_disp), .rst(1'b0), .sig_i(SW[0]), .sig_o(switch[0]));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_SW1 (.clk(clk_disp), .rst(1'b0), .sig_i(SW[1]), .sig_o(switch[1]));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_SW2 (.clk(clk_disp), .rst(1'b0), .sig_i(SW[2]), .sig_o(switch[2]));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_SW3 (.clk(clk_disp), .rst(1'b0), .sig_i(SW[3]), .sig_o(switch[3]));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(2000), .INIT_VALUE(0))
		AJ_ROTA (.clk(clk_disp), .rst(1'b0), .sig_i(ROTA), .sig_o(disp_prev));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(2000), .INIT_VALUE(0))
		AJ_ROTB (.clk(clk_disp), .rst(1'b0), .sig_i(ROTB), .sig_o(disp_next));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_ROTCTR (.clk(clk_disp), .rst(1'b0), .sig_i(ROTCTR), .sig_o());
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_BTNE (.clk(clk_disp), .rst(1'b0), .sig_i(BTNE), .sig_o(btn_interrupt));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_BTNS (.clk(clk_disp), .rst(1'b0), .sig_i(BTNS), .sig_o(btn_step));
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(10000), .INIT_VALUE(0))
		AJ_BTNW (.clk(clk_disp), .rst(1'b0), .sig_i(BTNW), .sig_o());
	anti_jitter #(.CLK_FREQ(50), .JITTER_MAX(20000), .INIT_VALUE(1))
		AJ_BTNN (.clk(clk_disp), .rst(1'b0), .sig_i(BTNN), .sig_o(btn_reset));
	assign btn_reg = btn_interrupt;	
	`else
	assign
		switch = SW,
		disp_prev = ROTA,
		disp_next = ROTB,
		btn_interrupt = BTNE,
		btn_step = BTNS,
		btn_reset = BTNN,
		btn_reg = BTNE,

	`endif
	
	// reset
	reg rst_all;
	reg [15:0] rst_count = 16'hFFFF;
	
	always @(posedge clk_cpu) begin
		rst_all <= (rst_count != 0);
		rst_count <= {rst_count[14:0], (btn_reset | (~locked))};
	end
	
	// display	
	
	display DISPLAY (
		.clk(clk_disp),
		.rst(rst_all),
		.data(register[31:0]),
		.pc(pc_out[11:0]),
		.reg_num(reg_num_disp[7:0]),
		.inst(inst_out[31:0]),
		.lcd_e(LCDE),
		.lcd_rs(LCDRS),
		.lcd_rw(LCDRW),
		.lcd_dat(LCDDAT)
		);
	
	
	reg reg_high; //display high or not
	initial reg_high = 0;
	always @(posedge btn_reg) begin
		reg_high = reg_high+1;
	end
	
	assign reg_num = {reg_high,switch[3:0]};
	assign reg_num_disp = {3'b0,reg_num};
	assign LED = {reg_high,3'b0, switch};
	
	singal_cpu CPU(
		.clk_cpu(btn_step),
		.reset(rst_all),
		.reg_num(reg_num[4:0]),
		.pc_out(pc_out[31:0]),
		.inst_out(inst_out[31:0]),
		.register(register[31:0])
		);
	
endmodule

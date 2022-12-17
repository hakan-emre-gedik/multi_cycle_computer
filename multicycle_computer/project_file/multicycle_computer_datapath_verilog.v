// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Sun Jun 05 18:45:58 2022"

module multicycle_computer_datapath_verilog(
	reset,
	clock,
	WD3Src,
	A3Src,
	IRWrite,
	PCWrite,
	AdrSrc,
	MemWrite,
	FlagUpdate,
	RegWrite,
	ALUop,
	ALUSrcA,
	ALUSrcB,
	RegSrc,
	ResultSrc,
	ShiftType,
	FLAGS,
	INSTRUCTION_OUT,
	R0_out,
	R1_out
);


input wire	reset;
input wire	clock;
input wire	WD3Src;
input wire	A3Src;
input wire	IRWrite;
input wire	PCWrite;
input wire	AdrSrc;
input wire	MemWrite;
input wire	FlagUpdate;
input wire	RegWrite;
input wire	[2:0] ALUop;
input wire	[1:0] ALUSrcA;
input wire	[1:0] ALUSrcB;
input wire	[1:0] RegSrc;
input wire	[1:0] ResultSrc;
input wire	[2:0] ShiftType;
output wire	[3:0] FLAGS;
output wire	[31:0] INSTRUCTION_OUT;
output wire	[7:0] R0_out;
output wire	[7:0] R1_out;

wire	clk;
wire	[31:0] DATA_OUT;
wire	[31:0] INSTRUCTION;
wire	[7:0] PC_VALUE;
wire	[1:0] Reg_Src;
wire	rst;
wire	[3:0] xPSR_IN;
wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[2:0] SYNTHESIZED_WIRE_8;
wire	[2:0] SYNTHESIZED_WIRE_9;
wire	[2:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_35;
wire	[7:0] SYNTHESIZED_WIRE_12;
wire	[7:0] SYNTHESIZED_WIRE_13;
wire	[7:0] SYNTHESIZED_WIRE_36;
wire	[2:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_18;
wire	[7:0] SYNTHESIZED_WIRE_19;
wire	[7:0] SYNTHESIZED_WIRE_37;
wire	[7:0] SYNTHESIZED_WIRE_21;
wire	[7:0] SYNTHESIZED_WIRE_22;
wire	[7:0] SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_24;
wire	[2:0] SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_32;

assign	SYNTHESIZED_WIRE_0 = 1;
assign	SYNTHESIZED_WIRE_4 = 1;
assign	SYNTHESIZED_WIRE_6 = 1;
assign	SYNTHESIZED_WIRE_32 = 1;




registers_two	b2v_ALU_RESULT(
	.clk(clk),
	.rst(rst),
	.wen(SYNTHESIZED_WIRE_0),
	.data(SYNTHESIZED_WIRE_33),
	.A(SYNTHESIZED_WIRE_24));
	defparam	b2v_ALU_RESULT.W = 8;


data_memory	b2v_DATA_INSTRUCTION_MEMORY(
	.we(MemWrite),
	.clk(clk),
	.address_in(SYNTHESIZED_WIRE_2),
	.data_in(SYNTHESIZED_WIRE_34),
	.data_out(DATA_OUT));


registers_two	b2v_HOLD_RD1(
	.clk(clk),
	.rst(rst),
	.wen(SYNTHESIZED_WIRE_4),
	.data(SYNTHESIZED_WIRE_5),
	.A(SYNTHESIZED_WIRE_13));
	defparam	b2v_HOLD_RD1.W = 8;


registers_two	b2v_HOLD_RD2(
	.clk(clk),
	.rst(rst),
	.wen(SYNTHESIZED_WIRE_6),
	.data(SYNTHESIZED_WIRE_7),
	.A(SYNTHESIZED_WIRE_34));
	defparam	b2v_HOLD_RD2.W = 8;



register_file	b2v_inst1(
	.wen(RegWrite),
	.clk(clk),
	.reset(rst),
	.A_1(SYNTHESIZED_WIRE_8),
	.A_2(SYNTHESIZED_WIRE_9),
	.A_3(SYNTHESIZED_WIRE_10),
	.R7(SYNTHESIZED_WIRE_35),
	.WD3(SYNTHESIZED_WIRE_12),
	.R0_value(R0_out),
	.R1_value(R1_out),
	.RD1(SYNTHESIZED_WIRE_5),
	.RD2(SYNTHESIZED_WIRE_7));


w_bit_four_to_one_mux	b2v_inst10(
	.in_0(PC_VALUE),
	.in_1(SYNTHESIZED_WIRE_13),
	.in_2(SYNTHESIZED_WIRE_36),
	.in_3(SYNTHESIZED_WIRE_36),
	.s(ALUSrcA),
	.outs(SYNTHESIZED_WIRE_22));
	defparam	b2v_inst10.W = 8;


w_bit_two_to_one_mux	b2v_inst103(
	.s(AdrSrc),
	.in_0(PC_VALUE),
	.in_1(SYNTHESIZED_WIRE_35),
	.outs(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst103.W = 8;


w_bit_two_to_one_mux	b2v_inst104(
	.s(Reg_Src[0]),
	.in_0(INSTRUCTION[18:16]),
	.in_1(SYNTHESIZED_WIRE_17),
	.outs(SYNTHESIZED_WIRE_8));
	defparam	b2v_inst104.W = 3;


constant_value_gen	b2v_inst109(
	.outs(SYNTHESIZED_WIRE_28));
	defparam	b2v_inst109.constant_val = 6;
	defparam	b2v_inst109.W = 3;


w_bit_four_to_one_mux	b2v_inst11(
	.in_0(SYNTHESIZED_WIRE_18),
	.in_1(SYNTHESIZED_WIRE_19),
	.in_2(SYNTHESIZED_WIRE_37),
	.in_3(SYNTHESIZED_WIRE_21),
	.s(ALUSrcB),
	.outs(SYNTHESIZED_WIRE_23));
	defparam	b2v_inst11.W = 8;


alu_unit	b2v_inst12(
	.in_0(SYNTHESIZED_WIRE_22),
	.in_1(SYNTHESIZED_WIRE_23),
	.s(ALUop),
	.CO(xPSR_IN[1]),
	.OVF(xPSR_IN[0]),
	.Z(xPSR_IN[2]),
	.N(xPSR_IN[3]),
	.outs(SYNTHESIZED_WIRE_33));
	defparam	b2v_inst12.W = 8;


w_bit_four_to_one_mux	b2v_inst14(
	.in_0(SYNTHESIZED_WIRE_24),
	.in_1(SYNTHESIZED_WIRE_37),
	.in_2(SYNTHESIZED_WIRE_33),
	.in_3(SYNTHESIZED_WIRE_33),
	.s(ResultSrc),
	.outs(SYNTHESIZED_WIRE_35));
	defparam	b2v_inst14.W = 8;


immediate_extender	b2v_inst19(
	.immediate_input(INSTRUCTION[23:0]),
	.immediate_output(SYNTHESIZED_WIRE_19));





w_bit_two_to_one_mux	b2v_inst3(
	.s(Reg_Src[1]),
	.in_0(INSTRUCTION[2:0]),
	.in_1(INSTRUCTION[14:12]),
	.outs(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst3.W = 3;


w_bit_two_to_one_mux	b2v_inst4(
	.s(A3Src),
	.in_0(INSTRUCTION[14:12]),
	.in_1(SYNTHESIZED_WIRE_28),
	.outs(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst4.W = 3;


w_bit_two_to_one_mux	b2v_inst5(
	.s(WD3Src),
	.in_0(SYNTHESIZED_WIRE_35),
	.in_1(PC_VALUE),
	.outs(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst5.W = 8;


barrel_shifter	b2v_inst9(
	.data_in(SYNTHESIZED_WIRE_34),
	.shamt(INSTRUCTION[11:7]),
	.shift_type(ShiftType),
	.data_out(SYNTHESIZED_WIRE_18));


registers_two	b2v_INSTRUCTION_REGISTER(
	.clk(clk),
	.rst(rst),
	.wen(IRWrite),
	.data(DATA_OUT),
	.A(INSTRUCTION));
	defparam	b2v_INSTRUCTION_REGISTER.W = 32;


registers_two	b2v_PC(
	.clk(clk),
	.rst(rst),
	.wen(PCWrite),
	.data(SYNTHESIZED_WIRE_35),
	.A(PC_VALUE));
	defparam	b2v_PC.W = 8;


constant_value_gen	b2v_provide_0(
	.outs(SYNTHESIZED_WIRE_36));
	defparam	b2v_provide_0.constant_val = 0;
	defparam	b2v_provide_0.W = 8;


constant_value_gen	b2v_provide_1(
	.outs(SYNTHESIZED_WIRE_21));
	defparam	b2v_provide_1.constant_val = 1;
	defparam	b2v_provide_1.W = 8;


constant_value_gen	b2v_provide_7(
	.outs(SYNTHESIZED_WIRE_17));
	defparam	b2v_provide_7.constant_val = 7;
	defparam	b2v_provide_7.W = 3;


registers_two	b2v_READ_DATA(
	.clk(clk),
	.rst(rst),
	.wen(SYNTHESIZED_WIRE_32),
	.data(DATA_OUT[7:0]),
	.A(SYNTHESIZED_WIRE_37));
	defparam	b2v_READ_DATA.W = 8;


registers_two	b2v_xPSR(
	.clk(clk),
	.rst(rst),
	.wen(FlagUpdate),
	.data(xPSR_IN),
	.A(FLAGS));
	defparam	b2v_xPSR.W = 4;

assign	clk = clock;
assign	rst = reset;
assign	Reg_Src = RegSrc;
assign	INSTRUCTION_OUT = INSTRUCTION;

endmodule

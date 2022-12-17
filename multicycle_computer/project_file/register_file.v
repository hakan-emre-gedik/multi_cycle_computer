module register_file (
	A_1,
	A_2, 
	A_3, 
	WD3, 
	R7, 
	wen, 
	clk, 
	RD1, 
	RD2, 
	reset, 
	R0_value, 
	R1_value 
); 

	input [2:0] A_1, A_2, A_3; 
	input [7:0] WD3, R7; 
	input wen; 
	input clk; 
	input reset; 
	output[7:0] RD1, RD2; 
	output [7:0] R0_value, R1_value; 
	
	// create in total of 16 registers for the computer register file. 
	
		// create register data output wires. 
	wire [7:0] R0_out, R1_out, R2_out, R3_out, R4_out; 
	wire [7:0] SP_out, LR_out, PC_out; 
	
		// create write enables for registers. 
			// for this, create a select schema
	wire wen_0, wen_1, wen_2, wen_3, wen_4; 
	wire wen_5, wen_6, wen_7;
	
	assign wen_0 = (~A_3[0]) & (~A_3[1]) & (~A_3[2]) & wen;  
	assign wen_1 = (A_3[0]) & (~A_3[1]) & (~A_3[2]) & wen; 
	assign wen_2 = (~A_3[0]) & (A_3[1]) & (~A_3[2]) & wen; 
	assign wen_3 = (A_3[0]) & (A_3[1]) & (~A_3[2]) & wen; 
	assign wen_4 = (~A_3[0]) & (~A_3[1]) & (A_3[2]) & wen; 
	assign wen_5 = (A_3[0]) & (~A_3[1]) & (A_3[2]) & wen; 
	assign wen_6 = (~A_3[0]) & (A_3[1]) & (A_3[2]) & wen; 
	assign wen_7 = 1; // program counter register is always written.  
	
	// Instantiate the registers 
	registers_two #(.W(8)) R0 (clk, WD3, reset, wen_0, R0_out); 
	registers_two #(.W(8)) R1 (clk, WD3, reset, wen_1, R1_out);
	registers_two #(.W(8)) R2 (clk, WD3, reset, wen_2, R2_out);
	registers_two #(.W(8)) R3 (clk, WD3, reset, wen_3, R3_out);
	registers_two #(.W(8)) R4 (clk, WD3, reset, wen_4, R4_out);
	registers_two #(.W(8)) SP (clk, WD3, reset, wen_5, SP_out);
	registers_two #(.W(8)) LR (clk, WD3, reset, wen_6, LR_out);
	registers_two #(.W(8)) PC (clk, WD3, reset, wen_7, PC_out);
	//----
	
	// create 5 4x1 MUXs (x2) to create a select schema for the file outputs 
	
		// create 3 MUXs for RD1. 
	wire [7:0] rd1_0, rd1_1; 
	w_bit_four_to_one_mux #(.W(8)) mux_000_0 (R0_out, R1_out, R2_out, R3_out, A_1[1:0], rd1_0); 
	w_bit_four_to_one_mux #(.W(8)) mux_001_0 (R4_out, SP_out, LR_out, PC_out, A_1[1:0], rd1_1);
	w_bit_two_to_one_mux #(.W(8)) mux_010_0 (rd1_0, rd1_1, A_1[2], RD1);

	
		// create 3 MUXs for RD2. 
	wire [7:0] rd2_0, rd2_1; 
	w_bit_four_to_one_mux #(.W(8)) mux_000_1 (R0_out, R1_out, R2_out, R3_out, A_2[1:0], rd2_0); 
	w_bit_four_to_one_mux #(.W(8)) mux_001_1 (R4_out, SP_out, LR_out, PC_out, A_2[1:0], rd2_1);
	w_bit_two_to_one_mux #(.W(8)) mux_010_1 (rd2_0, rd2_1, A_2[2], RD2);
		
	// give r0 and r1 outputs for debugging purposes. 

	assign R0_value = R0_out; 
	assign R1_value = R1_out; 
		
endmodule 
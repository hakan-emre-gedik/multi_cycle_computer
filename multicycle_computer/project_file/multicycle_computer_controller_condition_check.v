module multicycle_computer_controller_condition_check (
	INSTRUCTION, 
	FLAGS,
	BranchTaken 
); 
	input [31:0]INSTRUCTION; 
	input [3:0]FLAGS; 
	output reg BranchTaken; 
	
	parameter cond0 = 4'b0000, cond1 = 4'b0001, cond2 = 4'b0010, cond3 = 4'b0011; 
	parameter cond4 = 4'b0100, cond5 = 4'b0101, cond6 = 4'b0110, cond7 = 4'b0111;
	parameter cond8 = 4'b1000, cond9 = 4'b1001, cond10 = 4'b1010, cond11 = 4'b1011;
	parameter cond12 = 4'b1100, cond13 = 4'b1101, cond14 = 4'b1110, cond15 = 4'b1111;
	
	wire [3:0]condition_field; 
	assign condition_field = INSTRUCTION[31:28]; 
	
	always @(INSTRUCTION) begin 
		case (condition_field) 
			cond0: 
				if (FLAGS[2] == 1) BranchTaken <= 1; // EQ
				else BranchTaken <= 0; 
			cond1: 
				if (FLAGS[2] == 0) BranchTaken <= 1; // NE 
				else BranchTaken <= 0; 
			cond2: 
				if (FLAGS[1] == 1) BranchTaken <= 1; // CS
				else BranchTaken <= 0; 
			cond3: 
				if (FLAGS[1] == 0) BranchTaken <= 1; // CC
				else BranchTaken <= 0; 
			cond4: 
				if (FLAGS[3] == 1) BranchTaken <= 1; // MI 
				else BranchTaken <= 0; 
			cond5: 
				if (FLAGS[3] == 0) BranchTaken <= 1; // PL 
				else BranchTaken <= 0; 
			cond6: 
				if (FLAGS[0] == 1) BranchTaken <= 1; // VS
				else BranchTaken <= 0; 
			cond7:
				if (FLAGS[0] == 0) BranchTaken <= 1; // VC
				else BranchTaken <= 0; 
			cond8: 
				if (FLAGS[2] == 0 && FLAGS[1] == 1) BranchTaken <= 1; // HI
				else BranchTaken <= 0; 
			cond9: 
				if (FLAGS[2] == 1 || FLAGS[1] == 0) BranchTaken <= 1; // LS
				else BranchTaken <= 0; 
			cond10: 
				if (FLAGS[3] == FLAGS[0]) BranchTaken <= 1; // GE
				else BranchTaken <= 0; 
			cond11:	
				if (FLAGS[3] != FLAGS[0]) BranchTaken <= 1; // LT 
				else BranchTaken <= 0; 
			cond12: 
				if ((FLAGS[2] == 0) || (FLAGS[3] == FLAGS[0])) BranchTaken <= 1; //GT
				else BranchTaken <= 0; 
			cond13: 
				if ((FLAGS[2] == 1) || (FLAGS[3] != FLAGS[0])) BranchTaken <= 1; // LE
				else BranchTaken <= 0; 
			cond14: 
				BranchTaken <= 1; // AL, UNCONDITIONAL 
			cond15:
				BranchTaken <= 0; // invalid. do not take the branch. 
		endcase 
	end 

endmodule 
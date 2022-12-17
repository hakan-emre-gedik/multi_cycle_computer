module multicycle_computer_controller_ALU_decoder (
	INSTRUCTION, 
	current_state,  
	ALUop
); 
	input [31:0]INSTRUCTION; 
	input [3:0]current_state; 
	output reg [2:0]ALUop; 

	// make states more readable. 
	parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011; 
	parameter s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111;
	parameter s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011;
	parameter s12 = 4'b1100, s13 = 4'b1101, s14 = 4'b1110, s15 = 4'b1111;	
	
	wire [3:0]cmd; 
	assign cmd = INSTRUCTION[24:21];
	
	always @(*) begin 
		if (current_state == s0 || current_state == s1 || current_state == s2 || current_state == s3 || 
			 current_state == s4 || current_state == s5 || current_state == s7 || current_state == s9 || 
			 current_state == s10 || current_state == s11 || current_state == s13 || 
			 current_state == s14 ) ALUop <= 3'b000; // For memory, branch, shift instruction states and 
																 // irrelevant states, perform addition with 2 operands. 
																 
		else begin // For Arithmetic/Logic with register or immediate execute stages 
			if (cmd == 4'b0000) ALUop <= 3'b100; // AND 
			else if (cmd == 4'b0001) ALUop <= 3'b110; // EXOR 
			else if (cmd == 4'b0010) ALUop <= 3'b001; // SUB 
			else if (cmd == 4'b0011) ALUop <= 3'b010; // RSB (reverse subtract) 
			
			else if (cmd == 4'b0100) ALUop <= 3'b000; // ADD 
			else if (cmd == 4'b0101) ALUop <= 3'b000; // ADC
			else if (cmd == 4'b0110) ALUop <= 3'b010; // SBC
			else if (cmd == 4'b0111) ALUop <= 3'b001; // RSC
			
			else if (cmd == 4'b1000) ALUop <= 3'b100; // TST AND 
			else if (cmd == 4'b1001) ALUop <= 3'b110; // TEQ EXOR
			else if (cmd == 4'b1010) ALUop <= 3'b010; // CMP SUB 
			else if (cmd == 4'b1011) ALUop <= 3'b000; // CMD ADD
			
			else if (cmd == 4'b1100) ALUop <= 3'b101; // OR 
			else if (cmd == 4'b1101) ALUop <= 3'b000; // SHIFTS ADD 
			else if (cmd == 4'b1110) ALUop <= 3'b000; // MOV ADD 
			else if (cmd == 4'b1111) ALUop <= 3'b100; // CLR AND 
			
			else ALUop <= 3'b000; // redundant
		end 
	end 
	
	
endmodule 
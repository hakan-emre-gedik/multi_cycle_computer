module multicycle_controller_state_machine(
	clock, 
	reset, 
	INSTRUCTION, 
	BranchTaken,  
	state
); 
	input clock, reset; 
	input [31:0]INSTRUCTION; 
	input BranchTaken; 
	output [3:0]state; // we have in total 15 states. 4-bits are enoguh to describe them all.  
	
	// make states more readable. 
	parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011; 
	parameter s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111;
	parameter s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011;
	parameter s12 = 4'b1100, s13 = 4'b1101, s14 = 4'b1110, s15 = 4'b1111;
	
	reg [3:0]current_state, previous_state; 
	wire [1:0]op; 
	wire [3:0]cond; 
	wire [3:0]cmd; 
	wire Ind_data; 
	wire Im; 
	wire Ind_branch; 
	wire Link_branch; 
	wire Load_memory; 
	
	
	assign state = current_state; // give the state output to other modules of the controller. 
	
	// we can use INSTRUCTION bus itself for conditional operations. Yet, this way coding will be more readable. 
	assign cond = INSTRUCTION[31:28];  
	assign op = INSTRUCTION[27:26]; 
	assign cmd = INSTRUCTION[24:21]; 
	assign Im = INSTRUCTION[25];
	assign Ind_data = INSTRUCTION[19]; 
	assign Link_branch = INSTRUCTION[24];
	assign Ind_branch = INSTRUCTION[25];
	assign Load_memory = INSTRUCTION[20]; 
	
	
	
	always @(posedge clock) begin 
		if (reset == 1) begin // synchronous reset to take the computer to the fetch state 
			current_state <= s0; 
		end 
		
		else begin 
			case (current_state) 
				s0: current_state <= s1; // go to decode for the fetch stage
				
				s1: 
					if (op == 2'b01) current_state <= s2; // memory 
					else if (op == 2'b00 && cmd != 4'b1101 && Im == 0 && Ind_data == 0) current_state <= s6; // arithmetic/logic
					else if (op == 2'b00 && cmd == 4'b1101 && Im == 0 && Ind_data == 0) current_state <= s7; // shift 
					else if (op == 2'b00 && Im == 1 && Ind_data == 0) current_state <= s8; // immediate (MOV etc.) 
					else if (op == 2'b00 && Ind_data == 1) current_state <= s9; // Indirect arithmetic/logic 
					else if (op == 2'b10 && Ind_branch == 0) begin 
						if (BranchTaken == 1) current_state <= s10; // branch, if link bit is high, we only pull RegWrite high
						else current_state <= s0; // if the branch is not taken, go fetch 
					end 
					else if (op == 2'b10 && Ind_branch == 1) current_state <= s11; // branch indirect
					else current_state <= s0; // invalid instruction, ignore and go fetch again. 
					
				s2: 
					if (Load_memory == 0) current_state <= s5; // store
					else if (Load_memory == 1) current_state <= s3; //load 
					
				s3: current_state <= s4;
				s4: current_state <= s0; // go fetch 
				s5: current_state <= s0; // go fetch 
				s6: current_state <= s14; // alu write back 
				s7: current_state <= s14; // alu write back 
				s8: current_state <= s14; // alu write back 
				s9: current_state <= s12;
				s10: current_state <= s0; // go fetch  
				s11: current_state <= s13;
				s12: current_state <= s14; // alu write back 
				s13: current_state <= s0; // go fetch  
				s14: current_state <= s0; // go fetch  
				s15: current_state <= s0; // something went wrong. go fetch. 
				default: current_state <= s0; // might be redundant. go fetch. 
			endcase
		end 
		
		
		
		
	end 
	
	
endmodule 
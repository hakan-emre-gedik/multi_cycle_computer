module multicycle_computer_controller_xPSR_write(
	INSTRUCTION, 
	state, 
	flagUpdate
); 
	input [31:0]INSTRUCTION; 
	input [3:0]state; 
	output reg flagUpdate; 
	
	parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011; 
	parameter s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111;
	parameter s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011;
	parameter s12 = 4'b1100, s13 = 4'b1101, s14 = 4'b1110, s15 = 4'b1111;
	
	wire flag_write; 
	assign flag_write = INSTRUCTION[20]; 
	
	always @(state) begin 
		if ((state == s6 || state == s7 || state == s8 || state == s12) &&
			 (flag_write == 1)) flagUpdate <= 1; 
		else flagUpdate <= 0; 
			
	end 

endmodule 
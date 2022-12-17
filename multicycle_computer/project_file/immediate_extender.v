module immediate_extender (
	immediate_input, 
	immediate_output
); 
	input [23:0]immediate_input; 
	output reg [7:0]immediate_output; 
	
	
	always @(*) begin 
		immediate_output <= immediate_input[7:0]; // Take last 8-bits as the immediate value. 
	end 
	
endmodule 
module immediate_extender_tb(); 

reg [23:0]immediate_input; 
wire [7:0]immediate_output; 

immediate_extender dut(
	immediate_input, 
	immediate_output
); 



initial begin 
	immediate_input = 24'd102; 
	#5; 
	immediate_input = 24'd204; 
	#5; 
	immediate_input = 24'd306; 
	#5 
	immediate_input = 24'd408; 
	#5; 
end 

endmodule 
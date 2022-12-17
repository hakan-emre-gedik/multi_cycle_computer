module unified_multicycle_computer_tb (); 
	reg clock, reset; 
	wire [3:0]FLAGS; 
	wire [7:0]R0_out;
	wire [7:0]R1_out; 
	wire [3:0]state;
	
	multicycle_computer_all multicycle_computer(
		.clock(clock), .reset(reset), .R0_out(R0_out), 
		.R1_out(R1_out), .FLAGS(FLAGS), .state(state)
		
	); 
	
	
	initial begin 
		clock = 0;
		reset = 1; #15; reset = 0; 
		 
	end 
	
	always begin 
		clock = ~clock; #5; 
	end 
	
	
endmodule

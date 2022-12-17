module barrel_shifter_tb (); 
	reg [7:0]data_in; 
	reg [4:0]shamt; 
	reg [2:0]shift_type; 
	wire [7:0] data_out; 

barrel_shifter dut(
		data_in, 
		shift_type, 
		shamt, 
		data_out
);

initial begin 
	// test all possible shifts 
	data_in = 8'b11001010; 
	shamt = 5'd3; 
	
	shift_type = 3'b000; 
	#5;
	shift_type = 3'b001; 
	#5; 
	shift_type = 3'b010; 
	#5; 
	shift_type = 3'b011; 
	#5; 
	shift_type = 3'b100; 
	#5; 
	shift_type = 3'b101; 
	#5; 
	shift_type = 3'b110; 
	#5; 
	shift_type = 3'b111; 
	#5; 
end 

endmodule 
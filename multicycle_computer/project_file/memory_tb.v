module memory_tb (); 

wire [31:0] data_out; 
reg [7:0] data_in, address_in;
reg clk, wen;  


data_memory dut(
		data_out, 
		data_in, 
		address_in, 
		wen,
		clk 
	);
	
initial begin 
	clk = 0; wen = 1;
	#5; // generate control inputs in falling edge of the clock
	
	// write the data 
	data_in = 8'd0; 
	address_in = 8'd0; 
	#10; 
	
	data_in = 8'd2; 
	address_in = 8'd1; 
	#10;
	
	data_in = 8'd4; 
	address_in = 8'd2; 
	#10;
	
	data_in = 8'd8; 
	address_in = 8'd3; 
	#10;
	
	// read in order 
	wen = 0; 
	address_in = 8'd0; 
	#5; 
	address_in = 8'd1; 
	#5; 
	address_in = 8'd2; 
	#5; 
	address_in = 8'd3; 
	#5; 
	
end 

always begin 
	clk = ~clk; #5; 
end 


endmodule 
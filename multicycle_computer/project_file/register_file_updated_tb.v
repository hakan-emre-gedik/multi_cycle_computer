module register_file_updated_tb(); 

	reg clk, reset, wen; 
	reg [2:0] A_1, A_2, A_3; 
	reg [7:0] WD3, R7; 
	wire [7:0] RD1, RD2; 
 
// instantiate the register file module 	
	register_file dut (
		A_1,
		A_2, 
		A_3, 
		WD3, 
		R7, 
		wen, 
		clk, 
		RD1, 
		RD2, 
		reset
); 


initial begin 
	clk = 0; 
	wen = 1; 
	A_1 = 3'b0; 
	A_2 = 3'b0; 
	A_3 = 3'b0; 
	WD3 = 8'b0;
	R7 = 8'b0; 
	reset = 1; #15; reset = 0; // apply reset 
	
	// test loading operation. 
	// load the register Ri with the value i. 
	wen = 1; // enable the write operation
	
	A_3 = 3'b000; 
	WD3 = 8'd0;
	#10; 
	A_3 = 3'b001; 
	WD3 = 8'd1;
	#10;
	A_3 = 3'b010; 
	WD3 = 8'd2;
	#10;
	A_3 = 3'b011; 
	WD3 = 8'd3;
	#10;
	A_3 = 3'b100; 
	WD3 = 8'd4;
	#10;
	A_3 = 3'b101; 
	WD3 = 8'd5;
	#10;
	A_3 = 3'b110; 
	WD3 = 8'd6;
	#10;
	
	wen = 0; // disable write and observe the register values. no need for waiting for the clock edge 
				// the output will directly appear after we change A_1 or A_2 ports. 
	A_1 = 3'b000; 
	A_2 = 3'b111; 
	#5; 
	A_1 = 3'b001; 
	A_2 = 3'b110; 
	#5; 
	A_1 = 3'b010; 
	A_2 = 3'b101; 
	#5; 
	A_1 = 3'b011; 
	A_2 = 3'b100; 
	#5; 
	A_1 = 3'b100; 
	A_2 = 3'b011; 
	#5; 
	A_1 = 3'b101; 
	A_2 = 3'b010; 
	#5; 
	A_1 = 3'b110; 
	A_2 = 3'b001; 
	#5; 
	A_1 = 3'b111; 
	A_2 = 3'b000; 
	#5; 
	
	
	
end 

always begin 
	clk = ~clk; #5; 
end 

endmodule 

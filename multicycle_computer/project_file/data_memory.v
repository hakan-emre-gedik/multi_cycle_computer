	module data_memory(
	data_out, 
	data_in, 
	address_in, 
	we, 
	clk 
); 
	output reg [31:0] data_out; // input and output should have 8-bit length. 	
	input [7:0] data_in; 
	input [7:0] address_in; 
	input we; 
	input clk; 
	
	reg [31:0] mem[127:0]; 
	
	initial begin 
		// INSTRUCTION SECTION 
		mem[0] = 32'h03C01005; // MOV R1, #5
		mem[1] = 32'h03C02040; // MOV R2, #64  
		mem[2] = 32'h00490002; // SUBIN R0, R1, [R2]
		
		// DATA SECTION 
		mem[64] = 32'd24; 
		mem[65] = 32'd24;
		mem[66] = 32'd25;
		mem[67] = 32'd26;
		mem[68] = 32'd27;
		mem[69] = 32'd28;
		mem[70] = 32'd29;
		mem[71] = 32'd3; 
	end 
	
	always @(*) begin 
		data_out <= mem[address_in][31:0]; 
	end 
	
	always @(posedge clk) begin 
		if (we) mem[address_in][7:0] <= data_in; 
		else mem[address_in] <= mem[address_in]; 
	end 

endmodule 
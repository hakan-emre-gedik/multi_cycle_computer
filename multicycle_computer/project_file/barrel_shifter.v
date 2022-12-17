module barrel_shifter (
	data_in, 
	shift_type, 
	shamt, 
	data_out
); 
	input [7:0]data_in; 
	input [4:0]shamt; 
	input [2:0]shift_type; 
	output reg [7:0] data_out; 
		
	always @(*) begin 
		if (shift_type == 3'b000) data_out <= data_in << shamt; // 000 for logical left shift
		else if (shift_type == 3'b001) data_out <= data_in >> shamt; // 001 for logical right shift 
		else if (shift_type == 3'b010) data_out <= data_in >>> shamt; // 010 arithmetic right shift 
		else if (shift_type == 3'b011) data_out <= (data_in << shamt) | (data_in >> (5'b01000-shamt)) ; // 011 for rotate left 
		else if (shift_type == 3'b100) data_out <= (data_in >> shamt) | (data_in << (5'b01000-shamt)) ; // 100 for rotate right
		else data_out <= data_in; // do nothing 
	end 
	
endmodule 
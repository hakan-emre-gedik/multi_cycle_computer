module multicycle_controller_instruction_decoder (
	INSTRUCTION, 
	RegSrc, 
	ShiftType, 
);  
	
	input [31:0]INSTRUCTION; 
	output reg [1:0]RegSrc; 
	output [2:0]ShiftType;  
	
	wire [1:0]op; 
	wire [3:0]cmd; 
	wire [3:0]shift_type_instruction; 
	
	assign op = INSTRUCTION[27:26]; 
	assign cmd = INSTRUCTION[24:21]; 
	
	
	assign ShiftType = INSTRUCTION[6:4];  
	
	always @(*) begin // when the INSTRUCTION changes in the decode stage
		if (op == 00) begin // data processing instructions  
			RegSrc <= 2'b00; 
		end 	
		else if (op == 01) begin // memory instructions 
			RegSrc <= 2'b10; 
		end 
		else if (op == 10) begin // branch instructions 
			RegSrc <= 2'b01; 
		end 
		else begin //invalid
			RegSrc <= 2'b00;
		end 
		
	end 

endmodule 
module xor_tb (); 
	reg clock, reset;
	wire [31:0]INSTRUCTION_OUT; 
	wire [3:0]FLAGS; 

	reg A3Src, AdrSrc, FlagUpdate, IRWrite, MemWrite, PCWrite, RegWrite, WD3Src; 
	reg [1:0]ALUSrcA, ALUSrcB, ResultSrc, RegSrc; 
	reg [2:0]ALUop, ShiftType; 
	wire [7:0]R0_out, R1_out;  


// instantiate the datapath 
multicycle_computer_datapath_verilog dut(
	.A3Src(A3Src), .AdrSrc(AdrSrc), .FlagUpdate(FlagUpdate), .IRWrite(IRWrite),
	.MemWrite(MemWrite), .PCWrite(PCWrite), .RegWrite(RegWrite), .WD3Src(WD3Src), 
	.ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ResultSrc(ResultSrc), .ALUop(ALUop), 
	.RegSrc(RegSrc), .INSTRUCTION_OUT(INSTRUCTION_OUT), .FLAGS(FLAGS), 
	.R0_out(R0_out), .R1_out(R1_out), .clock(clock), .reset(reset)
);  

initial begin 
		// LOAD THE DATA IN MEMORY LOCATION 64 TO R1, AND DATA IN MEMORY LOCATION 65 TO R2. 
		// THEN PERFORM ADDITION OF R1 AND R2, AND WRITE THE RESULT TO R0. 
		
			// LDR R1, [R1, #64]
		// reset the control signals
		clock = 0; 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; RegSrc = 2'b00; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		
		// apply synchronous reset
		reset = 1; #15; reset = 0; 
		
		// fetch cycle
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 1; MemWrite = 0; PCWrite = 1; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b11; ResultSrc = 2'b10; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// decode cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b10; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemAdr cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemRead cycle 
		A3Src = 0; AdrSrc = 1; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemwriteBack cycle 
		A3Src = 0; AdrSrc = 1; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 1; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b01; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
			
			// LDR R2, [R2, #65]
		// fetch cycle
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 1; MemWrite = 0; PCWrite = 1; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b11; ResultSrc = 2'b10; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20;
		
		// decode cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemAdr cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemRead cycle 
		A3Src = 0; AdrSrc = 1; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
		// MemwriteBack cycle 
		A3Src = 0; AdrSrc = 1; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 1; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b01; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20; 
		
			// ADD R0, R1, R2 
		// fetch cycle
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 1; MemWrite = 0; PCWrite = 1; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b11; ResultSrc = 2'b10; RegSrc = 2'b10; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20;
		
		// decode cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; RegSrc = 2'b00; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20;
		
		// ExecuteR cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 0; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b00; ResultSrc = 2'b00; RegSrc = 2'b00; 
		ALUop = 3'b110; ShiftType = 3'b111; 
		#20;
		
		// ALUWriteBack cycle 
		A3Src = 0; AdrSrc = 0; FlagUpdate = 0; IRWrite = 0; MemWrite = 0; PCWrite = 0; RegWrite = 1; WD3Src = 0; 
		ALUSrcA = 2'b01; ALUSrcB = 2'b00; ResultSrc = 2'b00; RegSrc = 2'b00; 
		ALUop = 3'b000; ShiftType = 3'b111; 
		#20;
		
		
	end 
	
	always begin 
		clock = ~clock; #10; 
	end 


endmodule 
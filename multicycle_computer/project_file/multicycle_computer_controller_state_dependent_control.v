module multicycle_computer_controller_state_dependent_control (
	WD3Src,
	A3Src,
	IRWrite,
	PCWrite,
	AdrSrc,
	MemWrite,
	RegWrite,
	ALUSrcA,
	ALUSrcB,
	ResultSrc,
	FLAGS,
	INSTRUCTION, 
	current_state
); 

	output reg	WD3Src;
	output reg	A3Src;
	output reg	IRWrite;
	output reg	PCWrite;
	output reg	AdrSrc;
	output reg	MemWrite;
	output reg	RegWrite;
	output reg	[1:0] ALUSrcA;
	output reg	[1:0] ALUSrcB;
	output reg	[1:0] ResultSrc;
	input wire	[3:0] FLAGS;
	input wire	[31:0] INSTRUCTION;
	input wire [3:0]current_state; 
	
	parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011; 
	parameter s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111;
	parameter s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011;
	parameter s12 = 4'b1100, s13 = 4'b1101, s14 = 4'b1110, s15 = 4'b1111;
	
	wire [1:0]op; 
	wire [3:0]cond; 
	wire [3:0]cmd; 
	wire Ind_data; 
	wire Im; 
	wire Ind_branch; 
	wire Link_branch; 
	wire Load_memory; 
	
	// we can use INSTRUCTION bus itself for conditional operations. Yet, this way coding will be more readable. 
	assign cond = INSTRUCTION[31:28];  
	assign op = INSTRUCTION[27:26]; 
	assign cmd = INSTRUCTION[24:21]; 
	assign Im = INSTRUCTION[25];
	assign Ind_data = INSTRUCTION[19]; 
	assign Link_branch = INSTRUCTION[24];
	assign Ind_branch = INSTRUCTION[25];
	assign Load_memory = INSTRUCTION[20]; 
	
	always @(current_state) begin // update the control signals when the state changes 
		if (current_state == s0) begin // Fetch 
			WD3Src<=0; A3Src<=0; IRWrite<=1; PCWrite<=1; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b11;
			ResultSrc[1:0] <= 2'b10;
		end 
		else if (current_state == s1) begin // Decode
			if (op == 2'b00) begin 
				WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b11;
				ResultSrc[1:0] <= 2'b10;
			end 
			else if (op == 2'b01) begin 
				WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b11;
				ResultSrc[1:0] <= 2'b10;
			end 
			else if (op == 2'b10) begin 
				WD3Src<=0; A3Src<=1; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b11;
				ResultSrc[1:0] <= 2'b10;	
			end 
			else begin // Invalid instruction. Set writes to 0. State machine will go to fetch. 
				WD3Src<=0; A3Src<=1; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b11;
				ResultSrc[1:0] <= 2'b10;
			end 
		end 
		else if (current_state == s2) begin // MemAdr 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end
		else if (current_state == s3) begin // MemRead 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=1;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end
		
		else if (current_state == s4) begin // MemWriteBack
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=1;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b01;
		end
		else if (current_state == s5) begin // MemWrite 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=1;
			MemWrite<=1; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b01;
		end
		else if (current_state == s6) begin // ExecuteArithmeticLogic 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b00;
			ResultSrc[1:0] <= 2'b00;
		end
		else if (current_state == s7) begin // ExecuteShift 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b00;
			ResultSrc[1:0] <= 2'b00;
		end
		
		else if (current_state == s8) begin // ExecuteImmediate
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end
		else if (current_state == s9) begin // ExecuteIndMemAdr
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=1;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b00;
			ResultSrc[1:0] <= 2'b10;
		end
		else if (current_state == s10) begin // Branch 
			if (Link_branch == 1) begin // if branch with link, write pc value to LR 
				WD3Src<=1; A3Src<=1; IRWrite<=0; PCWrite<=1; AdrSrc<=0;
				MemWrite<=0; RegWrite<=1;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b01;
				ResultSrc[1:0] <= 2'b10;
			end 
			else begin 
				WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=1; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b00; ALUSrcB[1:0]<=2'b01;
				ResultSrc[1:0] <= 2'b10;
			end 
		end
		else if (current_state == s11) begin // BranchIndMem 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=1;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b10;
		end
		
		else if (current_state == s12) begin // ExecuteRInd
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b10;
			ResultSrc[1:0] <= 2'b00;
		end
		else if (current_state == s13) begin // BranchInd
			if (Link_branch==0) begin 
				WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=1; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b10;
				ResultSrc[1:0] <= 2'b10;
			end 
			else begin 
				WD3Src<=1; A3Src<=1; IRWrite<=0; PCWrite<=1; AdrSrc<=0;
				MemWrite<=0; RegWrite<=0;
				ALUSrcA[1:0]<=2'b10; ALUSrcB[1:0]<=2'b10;
				ResultSrc[1:0] <= 2'b10;
			end 
		end
		else if (current_state == s14) begin // ALUWriteBack
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=1;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end
		else if (current_state == s15) begin // Should never come to this. State machine will go fetch. 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end
		else begin // redundant. set writes to 0 
			WD3Src<=0; A3Src<=0; IRWrite<=0; PCWrite<=0; AdrSrc<=0;
			MemWrite<=0; RegWrite<=0;
			ALUSrcA[1:0]<=2'b01; ALUSrcB[1:0]<=2'b01;
			ResultSrc[1:0] <= 2'b00;
		end 
	end 	
	
	
	
endmodule 
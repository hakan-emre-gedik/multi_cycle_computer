module multicycle_computer_controller_all (
	reset,
	clock,
	WD3Src,
	A3Src,
	IRWrite,
	PCWrite,
	AdrSrc,
	MemWrite,
	FlagUpdate,
	RegWrite,
	ALUop,
	ALUSrcA,
	ALUSrcB,
	RegSrc,
	ResultSrc,
	ShiftType,
	FLAGS,
	INSTRUCTION,
	state
); 
	
	output wire	WD3Src;
	output wire	A3Src;
	output wire	IRWrite;
	output wire	PCWrite;
	output wire	AdrSrc;
	output wire	MemWrite;
	output wire	FlagUpdate;
	output wire	RegWrite;
	output wire	[2:0] ALUop;
	output wire	[1:0] ALUSrcA;
	output wire	[1:0] ALUSrcB;
	output wire	[1:0] RegSrc;
	output wire	[1:0] ResultSrc;
	output wire	[2:0] ShiftType;
	input wire reset, clock;
	input wire	[3:0] FLAGS;
	input wire	[31:0] INSTRUCTION;
	output wire [3:0]state; 
	
	wire [3:0]controller_state; 
	assign state = controller_state; 
	wire BranchTaken; 
	// instantiate the controller state machine 
	multicycle_controller_state_machine controller_state_machine(
		.clock(clock), .reset(reset), .INSTRUCTION(INSTRUCTION), 
		.BranchTaken(BranchTaken),  .state(controller_state)
	); 
	
	// instantiate the ALU decoder 
	multicycle_computer_controller_ALU_decoder controller_ALU_decoder(
		.INSTRUCTION(INSTRUCTION), 
		.current_state(controller_state),  
		.ALUop(ALUop)
	); 
	
	// instantiate the instruction decoder 
	multicycle_controller_instruction_decoder controller_instruction_decoder(
		.INSTRUCTION(INSTRUCTION), 
		.RegSrc(RegSrc), 
		.ShiftType(ShiftType)
	);  
	
	// instantiate the state dependent control module 
	multicycle_computer_controller_state_dependent_control controller_state_dependent_control(
		.WD3Src(WD3Src), .A3Src(A3Src), .IRWrite(IRWrite),
		.PCWrite(PCWrite), .AdrSrc(AdrSrc), .MemWrite(MemWrite),
		.RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), 
		.ResultSrc(ResultSrc), .FLAGS(FLAGS), .INSTRUCTION(INSTRUCTION), 
		.current_state(controller_state)
	); 
	
	// instantiate the xPSR write enable module 
	multicycle_computer_controller_xPSR_write controller_xPSR_write_enable(
		.INSTRUCTION(INSTRUCTION), .state(controller_state), .flagUpdate(FlagUpdate)
	); 
	
	multicycle_computer_controller_condition_check controller_condition_check(
		.INSTRUCTION(INSTRUCTION), .FLAGS(FLAGS), .BranchTaken(BranchTaken)
	); 
	

endmodule 
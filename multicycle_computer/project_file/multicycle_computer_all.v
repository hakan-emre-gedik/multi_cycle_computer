module multicycle_computer_all (
	clock, 
	reset, 
	R0_out,
	R1_out, 
	FLAGS, 
	state
); 

input clock, reset; 
output wire [3:0]FLAGS; 
output wire [7:0]R0_out;
output wire [7:0]R1_out; 
output wire [3:0]state; 

wire A3Src, AdrSrc, FlagUpdate, IRWrite, MemWrite, PCWrite, RegWrite, WD3Src; 
wire [1:0]ALUSrcA, ALUSrcB, ResultSrc, RegSrc; 
wire [2:0]ALUop, ShiftType ; 
wire [31:0]INSTRUCTION_OUT;
 
// instantiate the datapath 
multicycle_computer_datapath_verilog multicycle_datapath(
	.A3Src(A3Src), .AdrSrc(AdrSrc), .FlagUpdate(FlagUpdate), .IRWrite(IRWrite),
	.MemWrite(MemWrite), .PCWrite(PCWrite), .RegWrite(RegWrite), .WD3Src(WD3Src), 
	.ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ResultSrc(ResultSrc), .ALUop(ALUop), 
	.RegSrc(RegSrc), .INSTRUCTION_OUT(INSTRUCTION_OUT), .FLAGS(FLAGS), 
	.R0_out(R0_out), .R1_out(R1_out), .clock(clock), .reset(reset), .ShiftType(ShiftType)
);  

// instantiate the controller
multicycle_computer_controller_all multicycle_controller(
	.reset(reset), .clock(clock), .WD3Src(WD3Src), .A3Src(A3Src),
	.IRWrite(IRWrite), .PCWrite(PCWrite), .AdrSrc(AdrSrc),
	.MemWrite(MemWrite), .FlagUpdate(FlagUpdate), .RegWrite(RegWrite),
	.ALUop(ALUop), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .RegSrc(RegSrc),
	.ResultSrc(ResultSrc), .ShiftType(ShiftType), .FLAGS(FLAGS),
	.INSTRUCTION(INSTRUCTION_OUT), .state(state)
); 

endmodule 
 
`include "extender.v"
`include "alu.v"
`include "regfile.v"
`include "mux2.v"
`include "dflop.v"
`include "adder.v"

module datapath(input  clk, reset,
	input  [1:0] RegSrc,
	input  RegWrite,
	input  [1:0] ImmSrc,
	input  ALUSrc,
	input  [1:0] ALUControl,
	input  MemtoReg,
	input  PCSrc,
	output reg [3:0] ALUFlags,
	output reg [31:0] PC,
	input  [31:0] Instr,
	output reg [31:0] ALUResult, WriteData,
	input  [31:0] ReadData);
  
	wire [31:0] PCNext, PCPlus4, PCPlus8;
	wire [31:0] ExtImm, SrcA, SrcB, Result;
	wire [3:0] RA1, RA2;
  
  // PC Logic:
  mux2 #(32) pc_mux2 (.d0(PCPlus4),.d1(Result),.s(PCSrc),.y(PCNext));
  dflop pc_counter (.clk(clk), .reset(reset), .d(PCNext),.q(PC));
  adder pc_adder1 (.a(PC), .b(32'b0100), .y(PCPlus4));
  adder pc_adder2 (.a(PCPlus4), .b(32'b0100), .y(PCPlus8));
  
  // Register Logic
  mux2 #(4) r_addr1_mux2(.d0(Instr[19:16]),.d1(4'b1111),.s(RegSrc[0]),.y(RA1));
  mux2 #(4) r_addr2_mux2(.d0(Instr[3:0]),.d1(Instr[15:12]),.s(RegSrc[1]),.y(RA2));
  regfile register (.clk(clk),.we3(RegWrite),.ra1(RA1),.ra2(RA2),.wa3(Instr[15:12]),.wd3(Result),.r15(PCPlus8), .rd1(SrcA),.rd2(WriteData));
  extender extend (.Instr(Instr[23:0]),.ImmSrc(ImmSrc),.Data_out(ExtImm));
  mux2 #(32) alu_srcB_mux2(.d0(WriteData),.d1(ExtImm),.s(ALUSrc),.y(SrcB));

    // ALU Logic
  alu alu (.SrcA(SrcA),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.ALUFlag(ALUFlags));
  mux2 #(32) mem2reg(.d0(ALUResult),.d1(ReadData),.s(MemtoReg),.y(Result));
  
endmodule
  
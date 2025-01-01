`include "controller.v"
`include "datapath.v"

module cpu(input clk, reset,
           input  [31:0] ReadData,
           input  [31:0] Instr,
           
           output [31:0] PC,
           output MemWrite,
           output [31:0] ALUResult, WriteData
			);
  
//internal wires
wire [3:0] ALUFlags;
wire RegWrite,ALUSrc, MemtoReg, PCSrc;
wire [1:0] RegSrc, ImmSrc, ALUControl;
  
// Controller Integration
controller ctrl_unit (
    .clk(clk),
    .reset(reset),
    .Instr(Instr[31:12]),
    .ALUFlags(ALUFlags),
    .RegSrc(RegSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .ALUControl(ALUControl),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .PCSrc(PCSrc)
);

// Datapath Integration
datapath dp_unit (
    .clk(clk),
    .reset(reset),
    .RegSrc(RegSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .ALUControl(ALUControl),
    .MemtoReg(MemtoReg),
    .PCSrc(PCSrc),
    .ALUFlags(ALUFlags),
    .PC(PC),
    .Instr(Instr),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .ReadData(ReadData)
);

  
endmodule
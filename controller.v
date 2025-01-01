`include "decoder.v"
`include "condlogic.v"

module controller (
  input clk, reset,
  input [31:12] Instr,
  input [3:0] ALUFlags,
  
  output reg PCSrc, RegWrite, MemWrite, MemtoReg, ALUSrc,
  output reg [1:0] ImmSrc, RegSrc, ALUControl 
);
  
  wire  [1:0] FlagW;
  wire  PCS, RegW, MemW;
  
  decoder control_decoder(Instr[27:26], Instr[25:20], Instr[15:12],FlagW,PCS,RegW,MemW,  MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl);
  
  condlogic control_condlogic (clk, reset,Instr[31:28], ALUFlags,FlagW, PCS, RegW, MemW,PCSrc, RegWrite, MemWrite);

endmodule 
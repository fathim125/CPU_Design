module alu (
  input  [31:0] SrcA,             // 32-bit input A
  input  [31:0] SrcB,             // 32-bit input B
  input  [1:0] ALUControl,        // ALU operation selector
  output reg [31:0] ALUResult,    // 32-bit result of operation
  output reg [3:0] ALUFlag        // ALU status flags: Negative, Zero, Carry, Overflow
);
  // Intermediate flag registers
  reg Negative, Zero, CarryOut, OverflowFlag;

  always @(*) begin
    // Default values to avoid latches
    ALUResult = 0;
    CarryOut = 0;
    OverflowFlag = 0;

    // Perform operation based on ALUControl
    case (ALUControl)
      2'b10: begin // Bitwise AND
        ALUResult = SrcA & SrcB;
      end
      2'b11: begin // Bitwise OR
        ALUResult = SrcA | SrcB;
      end
      2'b00: begin // Addition
        {CarryOut, ALUResult} = SrcA + SrcB;
        OverflowFlag = (~SrcA[31] & ~SrcB[31] & ALUResult[31]) | (SrcA[31] & SrcB[31] & ~ALUResult[31]);
      end
      2'b01: begin // Subtraction
        {CarryOut, ALUResult} = SrcA - SrcB;
        OverflowFlag = (~SrcA[31] & SrcB[31] & ALUResult[31]) | (SrcA[31] & ~SrcB[31] & ~ALUResult[31]);
      end
      default: begin
        ALUResult = 32'b0;
      end
    endcase

    // Compute flags
    Zero = (ALUResult == 0);
    Negative = ALUResult[31];
  end

  // Pack flags into ALUFlag output
  always @(*) begin
    ALUFlag = {Negative, Zero, CarryOut, OverflowFlag};
  end

endmodule
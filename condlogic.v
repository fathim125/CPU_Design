`include "dflop_en.v"

module condlogic(
  input clk, reset,
  input [3:0] Cond,
  input [3:0] ALUFlags,
  input [1:0] FlagW,
  input PCS, RegW, MemW,
  output PCSrc, RegWrite, MemWrite
);

  wire CondEx;

  wire [1:0] FlagWrite;
  assign FlagWrite = FlagW & {2{CondEx}};

  wire [3:0] FlagsToCondcheck;
  dflop_en #2 dflop_enNZ (.clk(clk), .reset(reset), .en(FlagWrite[1]), .d(ALUFlags[3:2]), .q(FlagsToCondcheck[3:2])); 
  dflop_en #2 dflop_enCV (.clk(clk), .reset(reset), .en(FlagWrite[0]), .d(ALUFlags[1:0]), .q(FlagsToCondcheck[1:0]));

  condcheck cc (.Cond(Cond), .Flags(FlagsToCondcheck), .CondEx(CondEx));

  assign PCSrc = PCS & CondEx;
  assign RegWrite = RegW & CondEx;
  assign MemWrite = MemW & CondEx;

endmodule

module condcheck(
  input [3:0] Cond,
  input [3:0] Flags,
  output reg CondEx
);

  wire neg, zero, carry, overflow;
  assign {neg, zero, carry, overflow} = Flags;

  wire ge;
  assign ge = ~(neg ^ overflow);

  always @(*) begin
    case (Cond)
      4'b0000: CondEx = zero;             // EQ
      4'b0001: CondEx = ~zero;           // NE
      4'b0010: CondEx = carry;           // CS
      4'b0011: CondEx = ~carry;          // CC
      4'b0100: CondEx = neg;             // MI
      4'b0101: CondEx = ~neg;            // PL
      4'b0110: CondEx = overflow;        // VS
      4'b0111: CondEx = ~overflow;       // VC
      4'b1000: CondEx = carry & ~zero;   // HI
      4'b1001: CondEx = ~(carry & ~zero); // LS
      4'b1010: CondEx = ge;              // GE
      4'b1011: CondEx = ~ge;             // LT
      4'b1100: CondEx = ~zero & ge;      // GT
      4'b1101: CondEx = ~(~zero & ge);   // LE
      4'b1110: CondEx = 1'b1;            // Always
      default: CondEx = 1'bx;            // Undefined
    endcase
  end
endmodule

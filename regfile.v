module regfile (
  input clk,
  input we3,
  input [3:0] ra1,   
  input [3:0] ra2,
  input [3:0] wa3,  
  input [31:0] wd3, 
  input [31:0] r15, 
  output reg [31:0] rd1,	// 32-bit output
  output reg [31:0] rd2	// 32-bit output
);
  reg [31:0] register [15:0];
  
  //Assign is not used inside an always block
  assign rd1 = (ra1==4'b1111) ? r15 : register[ra1]; 
  assign rd2 =  (ra2==4'b1111) ? r15 : register[ra2];
  
  always @(posedge clk) begin
    if (we3) begin
      register[wa3] <= wd3;
    end
  end
endmodule
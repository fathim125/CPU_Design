module extender (
  input [23:0] Instr,   	// 24-bit input data
  input [1:0] ImmSrc, 		// 2-bit control signal
  output reg [31:0] Data_out 	// 32-bit output
);
always @(*) begin
    case (ImmSrc)
        2'b00: Data_out = {24'b0, Instr[7:0]};   
        2'b01: Data_out = {20'b0, Instr[11:0]}; 
      2'b10: Data_out = {{6{Instr[23]}}, Instr,2'b00};  
        default: Data_out = 32'b0;                  
    endcase
end
endmodule
module decoder(
    input [1:0] Op,              // Operation type
    input [5:0] Funct,           // Function code for instruction
    input [3:0] Rd,              // Destination register
    output reg [1:0] FlagW,      // Flags for updates
    output reg PCS,              // Program Counter Select
    output reg RegW, MemW,       // Register write and memory write controls
    output reg MemtoReg, ALUSrc, // Memory-to-register and ALU source controls
    output reg [1:0] ImmSrc, RegSrc, ALUControl // Immediate source, register source, and ALU control
);

    // Internal control signals
    reg Branch, ALUOp;
    reg [9:0] control_signals;

    // Unpack control signals into individual control wires
    assign {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp} = control_signals;

    // Main Control Logic
    always @(*) begin
        casex (Op)
            2'b00: begin
                // Data-processing immediate if Funct[5] is set
                if (Funct[5]) 
                    control_signals = 10'b0001001001;
                // Data-processing register otherwise
                else 
                    control_signals = 10'b0000001001;
            end
            2'b01: begin
                // LDR (Load Register)
                if (Funct[0]) 
                    control_signals = 10'b0101011000;
                // STR (Store Register)
                else 
                    control_signals = 10'b0011010100;
            end
            2'b10: begin
                // Branch (B)
                control_signals = 10'b1001100010;
            end
            default: begin
                // Undefined behavior
                control_signals = 10'bx;
            end
        endcase
    end

    // ALU Control Logic
    always @(*) begin
        if (ALUOp) begin
            // Decode ALU operation based on Funct[4:1]
            case (Funct[4:1])
                4'b0100: ALUControl = 2'b00; // ADD
                4'b0010: ALUControl = 2'b01; // SUB
                4'b0000: ALUControl = 2'b10; // AND
                4'b1100: ALUControl = 2'b11; // ORR
                default: ALUControl = 2'bx;  // Undefined
            endcase

            // Update flags if S bit (Funct[0]) is set
            FlagW[1] = Funct[0]; // Update N and Z flags
            FlagW[0] = Funct[0] & (ALUControl == 2'b00 || ALUControl == 2'b01); // Update C and V for ADD/SUB
        end else begin
            // Default ALU operation for non-DP instructions
            ALUControl = 2'b00; 
            FlagW = 2'b00; // No flag updates
        end
    end

    // Program Counter Select Logic
    assign PCS = ((Rd == 4'b1111) && RegW) || Branch;

endmodule

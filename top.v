`include "cpu.v"
`include "imem.v"
`include "dmem.v"

module top (
    input clk,
    input reset
);

    // Internal wires
    wire [31:0] PC, Instr, ReadData;
    wire [31:0] WriteData, DataAdr;
    wire MemWrite;

    // Instantiate CPU
    cpu cpu(
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .MemWrite(MemWrite),
        .ALUResult(DataAdr), // Explicit connection for ALUResult
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // Instantiate Instruction Memory
    imem imem(
        .a(PC),
        .rd(Instr)
    );

    // Instantiate Data Memory
    dmem dmem(
        .clk(clk),
        .we(MemWrite),
        .a(DataAdr),
        .wd(WriteData),
        .rd(ReadData)
    );

endmodule

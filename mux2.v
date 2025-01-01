// 2-to-1 Multiplexer Module with Parameterized Width
module mux2 #(
    parameter WIDTH = 8 // Default data width is 8 bits, can be overridden during instantiation
)(
    input  [WIDTH-1:0] d0,  // First input data (WIDTH bits)
    input  [WIDTH-1:0] d1,  // Second input data (WIDTH bits)
    input  s,               // Select signal (1 bit)
    output [WIDTH-1:0] y    // Output data (WIDTH bits)
);

    // Output the selected input based on the select signal
    assign y = (s == 1'b1) ? d1 : d0;
endmodule
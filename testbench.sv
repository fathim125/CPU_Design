`include "top.v"

module testbench();
    reg clk;
    reg reset;

    // Instantiate device to be tested
    top dut (
        .clk(clk),
        .reset(reset)
    );

    // Initialize test
    initial begin
        reset <= 1; 
        #10 reset <= 0;
        clk <= 1;
    end

    // Generate clock to sequence tests
    always #5 clk = ~clk;

    // Testing block
    initial begin
        // Wait for some time to let the simulation run
        #10000;
        
        // Test Memory[84] (Address 21 in dmem)
        if (dut.dmem.RAM[21] === 32'd7) begin
            $display("Test Passed: Memory[84] contains 7");
        end else begin
            $display("Test Failed: Memory[84] = %d, expected 7", dut.dmem.RAM[21]);
        end
        
        // Test R5 (Register 5 in regfile)
        if (dut.cpu.dp_unit.register.register[5] === 32'd11) begin
            $display("Test Passed: R5 contains 11");
        end else begin
            $display("Test Failed: R5 = %d, expected 11", dut.cpu.dp_unit.register.register[5]);
        end

        // End simulation
        $finish;
    end

endmodule

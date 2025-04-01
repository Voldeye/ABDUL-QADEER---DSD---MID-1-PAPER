`timescale 1ns / 1ps

module binary_stream_adder_tb;
    reg clk, rst, A, B;
    wire Sum;

    // Instantiate the binary_stream_adder module
    binary_stream_adder uut (
        .clk(clk), 
        .rst(rst), 
        .A(A), 
        .B(B), 
        .Sum(Sum)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $dumpfile("binary_stream_adder_tb.vcd");  // ✅ Generates waveform for GTKWave
        $dumpvars(0, binary_stream_adder_tb);

        clk = 0; rst = 1; A = 0; B = 0; #10;  // Reset
        rst = 0;

        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;

        A = 0; B = 1; #10;
        A = 1; B = 1; #10;

        $display("Simulation Complete");  // ✅ Optional confirmation message
        $finish;
    end
endmodule

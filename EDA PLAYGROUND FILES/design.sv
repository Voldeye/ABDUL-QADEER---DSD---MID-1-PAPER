`timescale 1ns / 1ps

module binary_stream_adder (
    input clk, rst, A, B,   // Declare inputs
    output reg Sum          // Declare output as reg
);
    reg carry;              // Declare carry as reg

    // State Encoding using parameters
    parameter S0 = 1'b0, S1 = 1'b1;
    reg current_state, next_state;

    // Sequential logic: state transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S0;
            carry <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic: next state and output logic
    always @(*) begin
        case (current_state)
            S0: begin
                Sum = A ^ B;      // Sum output = A XOR B
                carry = A & B;    // Carry = A AND B
                next_state = (A & B) ? S1 : S0;
            end
            S1: begin
                Sum = A ^ B ^ carry; // Sum with carry
                carry = (A & B) | (A & carry) | (B & carry); // Updated Carry
                next_state = (carry) ? S1 : S0;
            end
        endcase
    end
endmodule

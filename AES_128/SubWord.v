`timescale 1ns/1ps
module SubWord(
    input clk,
    input [31:0] word_in,
    output reg [31:0] word_out
);
    wire [7:0] s0, s1, s2, s3;
    // Giả sử module sbox_8bit có cổng: input [7:0] data, output [7:0] dout.
    sbox_8bit sb0 (.data(word_in[31:24]), .dout(s0));
    sbox_8bit sb1 (.data(word_in[23:16]), .dout(s1));
    sbox_8bit sb2 (.data(word_in[15:8]),  .dout(s2));
    sbox_8bit sb3 (.data(word_in[7:0]),   .dout(s3));

    always @(posedge clk) begin
        word_out <= {s0, s1, s2, s3};
    end
endmodule

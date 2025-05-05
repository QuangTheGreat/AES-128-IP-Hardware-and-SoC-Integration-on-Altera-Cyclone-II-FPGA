module mux_2to1_128bit(
	input s,
	input [127:0] in0,
	input [127:0] in1,
	output wire [127:0] mux_out
);
	assign mux_out = (s == 1'b0) ? in0 : in1;
endmodule
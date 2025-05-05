module top(
	input CLOCK_50,
	input [0:0] SW
);

	system u0(
		.clk_clk(CLOCK_50),
		.reset_reset_n(SW[0])
	);
	
endmodule
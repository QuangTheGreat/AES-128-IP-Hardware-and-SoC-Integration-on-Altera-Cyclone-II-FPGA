module register(
    input clk,
    input [127:0] d,
    input we,
    input re,
    output[127:0] q
);
    reg [127:0] q_reg;

    always @(posedge clk) begin
        if (we)
            q_reg <= d;
    end

    assign q = (re) ? q_reg : 8'bz; 

endmodule

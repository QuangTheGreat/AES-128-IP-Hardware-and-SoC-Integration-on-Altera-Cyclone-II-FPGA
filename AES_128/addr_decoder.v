module addr_decoder(
	input [3:0]address,
	output reg [10:0] line
);
	always@ (*)begin
		case(address)
			4'd0: line = 11'b00000000001;
			4'd1: line = 11'b00000000010;
			4'd2: line = 11'b00000000100;
			4'd3: line = 11'b00000001000;
			4'd4: line = 11'b00000010000;
			4'd5: line = 11'b00000100000;
			4'd6: line = 11'b00001000000;
			4'd7: line = 11'b00010000000;
			4'd8: line = 11'b00100000000;
			4'd9: line = 11'b01000000000;
			4'd10: line = 11'b10000000000;
			default: line = 11'd0;
		endcase
	end
endmodule


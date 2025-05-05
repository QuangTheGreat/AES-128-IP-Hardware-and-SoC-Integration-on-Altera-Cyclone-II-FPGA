module S_box (
	input clk,
    input [127:0] addr,
    output [127:0] value
);

    ROM_2port b7(addr[127:120], addr[119:112], clk, value[127:120], value[119:112]);
    ROM_2port b6(addr[111:104], addr[103:96], clk, value[111:104], value[103:96]);
    ROM_2port b5(addr[95:88], addr[87:80], clk, value[95:88], value[87:80]);
    ROM_2port b4(addr[79:72], addr[71:64], clk, value[79:72], value[71:64]);
    ROM_2port b3(addr[63:56], addr[55:48], clk, value[63:56], value[55:48]);
    ROM_2port b2(addr[47:40], addr[39:32], clk, value[47:40], value[39:32]);
    ROM_2port b1(addr[31:24], addr[23:16], clk, value[31:24], value[23:16]);
    ROM_2port b0(addr[15:8], addr[7:0], clk, value[15:8], value[7:0]);

endmodule

module rot_word(
    input  [127:0] key,   
    output [127:0] out   
);

    // Trích xuất các hàng từ key (column-major -> row-major)
    wire [31:0] row0 = { key[127:120], key[95:88],  key[63:56],  key[31:24] };
    wire [31:0] row1 = { key[119:112], key[87:80],  key[55:48],  key[23:16] };
    wire [31:0] row2 = { key[111:104], key[79:72],  key[47:40],  key[15:8]  };
    wire [31:0] row3 = { key[103:96], key[71:64],  key[39:32],  key[7:0]   };

    // Thực hiện RotWord trên từng hàng (xoay trái 1 byte)
    // Với một hàng dạng {a0, a1, a2, a3} -> {a1, a2, a3, a0}
    wire [31:0] rot_row0 = { row0[23:16], row0[15:8], row0[7:0],  row0[31:24] };
    wire [31:0] rot_row1 = { row1[23:16], row1[15:8], row1[7:0],  row1[31:24] };
    wire [31:0] rot_row2 = { row2[23:16], row2[15:8], row2[7:0],  row2[31:24] };
    wire [31:0] rot_row3 = { row3[23:16], row3[15:8], row3[7:0],  row3[31:24] };
	 
    assign out = { rot_row0, rot_row1, rot_row2, rot_row3 };

endmodule

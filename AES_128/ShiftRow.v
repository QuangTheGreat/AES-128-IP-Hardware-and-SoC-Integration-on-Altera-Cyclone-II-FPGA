`timescale 1ns/1ps
module ShiftRow(
    input  [127:0] in_state,
    output [127:0] out_state
);
    // Tách 16 byte từ in_state (giả sử s0 là byte cao nhất)
    wire [7:0] s0  = in_state[127:120];
    wire [7:0] s1  = in_state[119:112];
    wire [7:0] s2  = in_state[111:104];
    wire [7:0] s3  = in_state[103:96];

    wire [7:0] s4  = in_state[95:88];
    wire [7:0] s5  = in_state[87:80];
    wire [7:0] s6  = in_state[79:72];
    wire [7:0] s7  = in_state[71:64];

    wire [7:0] s8  = in_state[63:56];
    wire [7:0] s9  = in_state[55:48];
    wire [7:0] s10 = in_state[47:40];
    wire [7:0] s11 = in_state[39:32];

    wire [7:0] s12 = in_state[31:24];
    wire [7:0] s13 = in_state[23:16];
    wire [7:0] s14 = in_state[15:8];
    wire [7:0] s15 = in_state[7:0];

    // Thực hiện ShiftRows:
    // Column 0: [s0, s1, s2, s3] => row0: s0, row1: s1, row2: s2, row3: s3  (không dịch)
    // Column 1: [s4, s5, s6, s7] => dịch trái 1: [s5, s6, s7, s4]
    // Column 2: [s8, s9, s10, s11] => dịch trái 2: [s10, s11, s8, s9]
    // Column 3: [s12, s13, s14, s15] => dịch trái 3: [s15, s12, s13, s14]
    // Nhưng lưu ý: kết quả ShiftRows ở dạng column-major sẽ là:
    // Column0: { row0, row1, row2, row3 } = { s0, s5, s10, s15 }
    // Column1: { s4, s9, s14, s3 }
    // Column2: { s8, s13, s2, s7 }
    // Column3: { s12, s1, s6, s11 }
    assign out_state = {
        s0,   s5,  s10, s15,  // Column0
        s4,   s9,  s14, s3,   // Column1
        s8,   s13, s2,  s7,   // Column2
        s12,  s1,  s6,  s11   // Column3
    };
    
endmodule

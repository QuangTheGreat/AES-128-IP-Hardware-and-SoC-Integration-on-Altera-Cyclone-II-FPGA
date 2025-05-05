`timescale 1ns/1ps
module RoundKeyExpander(
    input       phase,                 // 0: ROTWORD/SUBBYTES phase; 1: KEYEXPAND phase
    input [127:0] prev_key,           // Prev round key (128-bit = {W0, W1, W2, W3})
    input [3:0] round_num,            // Round number (1..10)
    input [127:0] sbox_data_in,       // Kết quả từ S_box (128-bit, chỉ quan tâm 32-bit thấp)
    output [127:0] new_round_key      // New round key (128-bit)
);

    // Tách prev_key thành 4 từ 32-bit
    wire [31:0] W0 = prev_key[127:96];
    wire [31:0] W1 = prev_key[95:64];
    wire [31:0] W2 = prev_key[63:32];
    wire [31:0] W3 = prev_key[31:0];

    // Tính hằng số Rcon dựa vào round_num
    reg [31:0] rcon_val;
    always @(*) begin
        case(round_num)
            4'd1:  rcon_val = {8'h01, 24'b0};
            4'd2:  rcon_val = {8'h02, 24'b0};
            4'd3:  rcon_val = {8'h04, 24'b0};
            4'd4:  rcon_val = {8'h08, 24'b0};
            4'd5:  rcon_val = {8'h10, 24'b0};
            4'd6:  rcon_val = {8'h20, 24'b0};
            4'd7:  rcon_val = {8'h40, 24'b0};
            4'd8:  rcon_val = {8'h80, 24'b0};
            4'd9:  rcon_val = {8'h1B, 24'b0};
            4'd10: rcon_val = {8'h36, 24'b0};
            default: rcon_val = 32'b0;
        endcase
    end

    // Lấy kết quả 32-bit thấp của sbox_data_in làm substituted word
    wire [31:0] substituted_word = sbox_data_in[31:0];

    // Tính toán tạm thời: temp = W0 XOR substituted_word XOR rcon_val
    wire [31:0] temp = W0 ^ substituted_word ^ rcon_val;

    // Tính new_round_key theo công thức AES
    // Nếu phase = 1, tính toán; nếu phase = 0, ta có thể trả về prev_key (hoặc một giá trị mặc định)
    assign new_round_key = (phase) ? 
            { temp,               // New W0 = temp
              W1 ^ temp,         // New W1 = W1 XOR temp
              W2 ^ (W1 ^ temp),  // New W2 = W2 XOR (W1 XOR temp)
              W3 ^ (W2 ^ (W1 ^ temp))  // New W3 = W3 XOR (W2 XOR (W1 XOR temp))
            }
            : prev_key;

endmodule

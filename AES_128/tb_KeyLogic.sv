`timescale 1ns/1ps
module tb_KeyLogic;

    // Khai báo các tín hiệu kết nối đến DUT
    reg         clk;
    reg         reset;
    reg         mode;         // 0: expansion mode, 1: read mode
    reg         load_key;     // tín hiệu nạp khóa
    reg [127:0] cipher_key;   // khóa ban đầu (128-bit)
    reg [3:0]   sel_round;    // chọn round key để đọc
    reg [127:0] sbox_data_in; // dữ liệu trả về từ S_box (128-bit; chỉ 32-bit thấp chứa dữ liệu)
    wire [127:0] round_key;   // round key xuất ra
    wire         expansion_done;
    wire [31:0]  rotword_out;

    // Instance của DUT: KeyLogic
    KeyLogic uut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .load_key(load_key),
        .cipher_key(cipher_key),
        .sel_round(sel_round),
        .sbox_data_in(sbox_data_in),
        .round_key(round_key),
        .expansion_done(expansion_done),
        .rotword_out(rotword_out)
    );

    // Sinh xung clock: chu kỳ 10ns (tần số 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ----------------------------
    // Mô phỏng S-box:
    // Dùng một ROM 256 phần tử 8-bit và hàm subWord để tính giá trị SubWord
    // ----------------------------
    reg [7:0] sbox_rom [0:255];
    integer i;
    initial begin
        sbox_rom[8'h00] = 8'h63; sbox_rom[8'h01] = 8'h7c; sbox_rom[8'h02] = 8'h77; sbox_rom[8'h03] = 8'h7b;
        sbox_rom[8'h04] = 8'hf2; sbox_rom[8'h05] = 8'h6b; sbox_rom[8'h06] = 8'h6f; sbox_rom[8'h07] = 8'hc5;
        sbox_rom[8'h08] = 8'h30; sbox_rom[8'h09] = 8'h01; sbox_rom[8'h0a] = 8'h67; sbox_rom[8'h0b] = 8'h2b;
        sbox_rom[8'h0c] = 8'hfe; sbox_rom[8'h0d] = 8'hd7; sbox_rom[8'h0e] = 8'hab; sbox_rom[8'h0f] = 8'h76;
        sbox_rom[8'h10] = 8'hca; sbox_rom[8'h11] = 8'h82; sbox_rom[8'h12] = 8'hc9; sbox_rom[8'h13] = 8'h7d;
        sbox_rom[8'h14] = 8'hfa; sbox_rom[8'h15] = 8'h59; sbox_rom[8'h16] = 8'h47; sbox_rom[8'h17] = 8'hf0;
        sbox_rom[8'h18] = 8'had; sbox_rom[8'h19] = 8'hd4; sbox_rom[8'h1a] = 8'ha2; sbox_rom[8'h1b] = 8'haf;
        sbox_rom[8'h1c] = 8'h9c; sbox_rom[8'h1d] = 8'ha4; sbox_rom[8'h1e] = 8'h72; sbox_rom[8'h1f] = 8'hc0;
        sbox_rom[8'h20] = 8'hb7; sbox_rom[8'h21] = 8'hfd; sbox_rom[8'h22] = 8'h93; sbox_rom[8'h23] = 8'h26;
        sbox_rom[8'h24] = 8'h36; sbox_rom[8'h25] = 8'h3f; sbox_rom[8'h26] = 8'hf7; sbox_rom[8'h27] = 8'hcc;
        sbox_rom[8'h28] = 8'h34; sbox_rom[8'h29] = 8'ha5; sbox_rom[8'h2a] = 8'he5; sbox_rom[8'h2b] = 8'hf1;
        sbox_rom[8'h2c] = 8'h71; sbox_rom[8'h2d] = 8'hd8; sbox_rom[8'h2e] = 8'h31; sbox_rom[8'h2f] = 8'h15;
        sbox_rom[8'h30] = 8'h04; sbox_rom[8'h31] = 8'hc7; sbox_rom[8'h32] = 8'h23; sbox_rom[8'h33] = 8'hc3;
        sbox_rom[8'h34] = 8'h18; sbox_rom[8'h35] = 8'h96; sbox_rom[8'h36] = 8'h05; sbox_rom[8'h37] = 8'h9a;
        sbox_rom[8'h38] = 8'h07; sbox_rom[8'h39] = 8'h12; sbox_rom[8'h3a] = 8'h80; sbox_rom[8'h3b] = 8'he2;
        sbox_rom[8'h3c] = 8'heb; sbox_rom[8'h3d] = 8'h27; sbox_rom[8'h3e] = 8'hb2; sbox_rom[8'h3f] = 8'h75;
        sbox_rom[8'h40] = 8'h09; sbox_rom[8'h41] = 8'h83; sbox_rom[8'h42] = 8'h2c; sbox_rom[8'h43] = 8'h1a;
        sbox_rom[8'h44] = 8'h1b; sbox_rom[8'h45] = 8'h6e; sbox_rom[8'h46] = 8'h5a; sbox_rom[8'h47] = 8'ha0;
        sbox_rom[8'h48] = 8'h52; sbox_rom[8'h49] = 8'h3b; sbox_rom[8'h4a] = 8'hd6; sbox_rom[8'h4b] = 8'hb3;
        sbox_rom[8'h4c] = 8'h29; sbox_rom[8'h4d] = 8'he3; sbox_rom[8'h4e] = 8'h2f; sbox_rom[8'h4f] = 8'h84;
        sbox_rom[8'h50] = 8'h53; sbox_rom[8'h51] = 8'hd1; sbox_rom[8'h52] = 8'h00; sbox_rom[8'h53] = 8'hed;
        sbox_rom[8'h54] = 8'h20; sbox_rom[8'h55] = 8'hfc; sbox_rom[8'h56] = 8'hb1; sbox_rom[8'h57] = 8'h5b;
        sbox_rom[8'h58] = 8'h6a; sbox_rom[8'h59] = 8'hcb; sbox_rom[8'h5a] = 8'hbe; sbox_rom[8'h5b] = 8'h39;
        sbox_rom[8'h5c] = 8'h4a; sbox_rom[8'h5d] = 8'h4c; sbox_rom[8'h5e] = 8'h58; sbox_rom[8'h5f] = 8'hcf;
        sbox_rom[8'h60] = 8'hd0; sbox_rom[8'h61] = 8'hef; sbox_rom[8'h62] = 8'haa; sbox_rom[8'h63] = 8'hfb;
        sbox_rom[8'h64] = 8'h43; sbox_rom[8'h65] = 8'h4d; sbox_rom[8'h66] = 8'h33; sbox_rom[8'h67] = 8'h85;
        sbox_rom[8'h68] = 8'h45; sbox_rom[8'h69] = 8'hf9; sbox_rom[8'h6a] = 8'h02; sbox_rom[8'h6b] = 8'h7f;
        sbox_rom[8'h6c] = 8'h50; sbox_rom[8'h6d] = 8'h3c; sbox_rom[8'h6e] = 8'h9f; sbox_rom[8'h6f] = 8'ha8;
        sbox_rom[8'h70] = 8'h51; sbox_rom[8'h71] = 8'ha3; sbox_rom[8'h72] = 8'h40; sbox_rom[8'h73] = 8'h8f;
        sbox_rom[8'h74] = 8'h92; sbox_rom[8'h75] = 8'h9d; sbox_rom[8'h76] = 8'h38; sbox_rom[8'h77] = 8'hf5;
        sbox_rom[8'h78] = 8'hbc; sbox_rom[8'h79] = 8'hb6; sbox_rom[8'h7a] = 8'hda; sbox_rom[8'h7b] = 8'h21;
        sbox_rom[8'h7c] = 8'h10; sbox_rom[8'h7d] = 8'hff; sbox_rom[8'h7e] = 8'hf3; sbox_rom[8'h7f] = 8'hd2;
        sbox_rom[8'h80] = 8'hcd; sbox_rom[8'h81] = 8'h0c; sbox_rom[8'h82] = 8'h13; sbox_rom[8'h83] = 8'hec;
        sbox_rom[8'h84] = 8'h5f; sbox_rom[8'h85] = 8'h97; sbox_rom[8'h86] = 8'h44; sbox_rom[8'h87] = 8'h17;
        sbox_rom[8'h88] = 8'hc4; sbox_rom[8'h89] = 8'ha7; sbox_rom[8'h8a] = 8'h7e; sbox_rom[8'h8b] = 8'h3d;
        sbox_rom[8'h8c] = 8'h64; sbox_rom[8'h8d] = 8'h5d; sbox_rom[8'h8e] = 8'h19; sbox_rom[8'h8f] = 8'h73;
        sbox_rom[8'h90] = 8'h60; sbox_rom[8'h91] = 8'h81; sbox_rom[8'h92] = 8'h4f; sbox_rom[8'h93] = 8'hdc;
        sbox_rom[8'h94] = 8'h22; sbox_rom[8'h95] = 8'h2a; sbox_rom[8'h96] = 8'h90; sbox_rom[8'h97] = 8'h88;
        sbox_rom[8'h98] = 8'h46; sbox_rom[8'h99] = 8'hee; sbox_rom[8'h9a] = 8'hb8; sbox_rom[8'h9b] = 8'h14;
        sbox_rom[8'h9c] = 8'hde; sbox_rom[8'h9d] = 8'h5e; sbox_rom[8'h9e] = 8'h0b; sbox_rom[8'h9f] = 8'hdb;
        sbox_rom[8'ha0] = 8'he0; sbox_rom[8'ha1] = 8'h32; sbox_rom[8'ha2] = 8'h3a; sbox_rom[8'ha3] = 8'h0a;
        sbox_rom[8'ha4] = 8'h49; sbox_rom[8'ha5] = 8'h06; sbox_rom[8'ha6] = 8'h24; sbox_rom[8'ha7] = 8'h5c;
        sbox_rom[8'ha8] = 8'hc2; sbox_rom[8'ha9] = 8'hd3; sbox_rom[8'haa] = 8'hac; sbox_rom[8'hab] = 8'h62;
        sbox_rom[8'hac] = 8'h91; sbox_rom[8'had] = 8'h95; sbox_rom[8'hae] = 8'he4; sbox_rom[8'haf] = 8'h79;
        sbox_rom[8'hb0] = 8'he7; sbox_rom[8'hb1] = 8'hc8; sbox_rom[8'hb2] = 8'h37; sbox_rom[8'hb3] = 8'h6d;
        sbox_rom[8'hb4] = 8'h8d; sbox_rom[8'hb5] = 8'hd5; sbox_rom[8'hb6] = 8'h4e; sbox_rom[8'hb7] = 8'ha9;
        sbox_rom[8'hb8] = 8'h6c; sbox_rom[8'hb9] = 8'h56; sbox_rom[8'hba] = 8'hf4; sbox_rom[8'hbb] = 8'hea;
        sbox_rom[8'hbc] = 8'h65; sbox_rom[8'hbd] = 8'h7a; sbox_rom[8'hbe] = 8'hae; sbox_rom[8'hbf] = 8'h08;
        sbox_rom[8'hc0] = 8'hba; sbox_rom[8'hc1] = 8'h78; sbox_rom[8'hc2] = 8'h25; sbox_rom[8'hc3] = 8'h2e;
        sbox_rom[8'hc4] = 8'h1c; sbox_rom[8'hc5] = 8'ha6; sbox_rom[8'hc6] = 8'hb4; sbox_rom[8'hc7] = 8'hc6;
        sbox_rom[8'hc8] = 8'he8; sbox_rom[8'hc9] = 8'hdd; sbox_rom[8'hca] = 8'h74; sbox_rom[8'hcb] = 8'h1f;
        sbox_rom[8'hcc] = 8'h4b; sbox_rom[8'hcd] = 8'hbd; sbox_rom[8'hce] = 8'h8b; sbox_rom[8'hcf] = 8'h8a;
        sbox_rom[8'hd0] = 8'h70; sbox_rom[8'hd1] = 8'h3e; sbox_rom[8'hd2] = 8'hb5; sbox_rom[8'hd3] = 8'h66;
        sbox_rom[8'hd4] = 8'h48; sbox_rom[8'hd5] = 8'h03; sbox_rom[8'hd6] = 8'hf6; sbox_rom[8'hd7] = 8'h0e;
        sbox_rom[8'hd8] = 8'h61; sbox_rom[8'hd9] = 8'h35; sbox_rom[8'hda] = 8'h57; sbox_rom[8'hdb] = 8'hb9;
        sbox_rom[8'hdc] = 8'h86; sbox_rom[8'hdd] = 8'hc1; sbox_rom[8'hde] = 8'h1d; sbox_rom[8'hdf] = 8'h9e;
        sbox_rom[8'he0] = 8'he1; sbox_rom[8'he1] = 8'hf8; sbox_rom[8'he2] = 8'h98; sbox_rom[8'he3] = 8'h11;
        sbox_rom[8'he4] = 8'h69; sbox_rom[8'he5] = 8'hd9; sbox_rom[8'he6] = 8'h8e; sbox_rom[8'he7] = 8'h94;
        sbox_rom[8'he8] = 8'h9b; sbox_rom[8'he9] = 8'h1e; sbox_rom[8'hea] = 8'h87; sbox_rom[8'heb] = 8'he9;
        sbox_rom[8'hec] = 8'hce; sbox_rom[8'hed] = 8'h55; sbox_rom[8'hee] = 8'h28; sbox_rom[8'hef] = 8'hdf;
        sbox_rom[8'hf0] = 8'h8c; sbox_rom[8'hf1] = 8'ha1; sbox_rom[8'hf2] = 8'h89; sbox_rom[8'hf3] = 8'h0d;
        sbox_rom[8'hf4] = 8'hbf; sbox_rom[8'hf5] = 8'he6; sbox_rom[8'hf6] = 8'h42; sbox_rom[8'hf7] = 8'h68;
        sbox_rom[8'hf8] = 8'h41; sbox_rom[8'hf9] = 8'h99; sbox_rom[8'hfa] = 8'h2d; sbox_rom[8'hfb] = 8'h0f;
        sbox_rom[8'hfc] = 8'hb0; sbox_rom[8'hfd] = 8'h54; sbox_rom[8'hfe] = 8'hbb; sbox_rom[8'hff] = 8'h16;
    end

    // Hàm subWord: áp dụng S-box lên 4 byte của từ 32-bit
    function [31:0] subWord(input [31:0] din);
        begin
            subWord = { sbox_rom[din[31:24]],
                        sbox_rom[din[23:16]],
                        sbox_rom[din[15:8]],
                        sbox_rom[din[7:0]] };
        end
    endfunction

    // Sửa lại để S-box trả dữ liệu sau 1 cạnh lên:
    // Cập nhật sbox_data_in trên cạnh lên, phản ánh kết quả của rotword_out từ chu kỳ trước.
    always @(posedge clk) begin
        sbox_data_in <= {96'd0, subWord(rotword_out)};
    end

    // ----------------------------
    // Test sequence
    // ----------------------------
    initial begin
        // Khởi tạo các tín hiệu
        reset       = 1;
        mode        = 0;           // Ban đầu: expansion mode
        load_key    = 0;
        sel_round   = 4'd0;
        cipher_key  = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c; // key ví dụ từ FIPS 197
        sbox_data_in = 128'd0;

        // Nhả reset sau 20ns
        #20;
        reset = 0;
        #10;

        // Phát xung load_key để nạp cipher_key vào key_reg[0]
        load_key = 1;
        #10;
        load_key = 0;

        // Trong khi mode = 0, in ra các giá trị debug mỗi 10ns
        // Bao gồm: mode, phase, new_round_key, round_key, rotword_out, sbox_data_in
        while ((mode == 0) && (!expansion_done)) begin
            #10;
            $display("Time: %0t ns, mode: %0b, phase: %0b, new_round_key: %h, round_key: %h, rotword_out: %h, sbox_data_in: %h", 
                      $time, mode, uut.controller_phase, uut.new_round_key_comb, round_key, rotword_out, sbox_data_in);
        end

        #20;

        // Chuyển sang chế độ đọc (read mode)
        mode = 1;
        // Duyệt qua 11 vòng (0..10) để đọc round key và in ra kết quả
        for (i = 0; i < 11; i = i + 1) begin
            sel_round = i;
            #10;
            $display("Round %0d key = %h", i, round_key);
        end

        #20;
        $finish;
    end

endmodule

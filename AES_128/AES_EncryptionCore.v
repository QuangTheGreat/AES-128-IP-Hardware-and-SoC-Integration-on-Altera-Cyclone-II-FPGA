`timescale 1ns/1ps
module AES_EncryptionCore(
    input          clk,
    input          rst,
    // Giao tiếp nạp dữ liệu
    input          LoadKey,       // Kích hoạt nạp Key
    input          LoadData,      // Kích hoạt nạp Plaintext
    input  [127:0] KeyPlaintext_in, // 128 bit, ghép chung Key/Plaintext
    // Đầu ra
    output [127:0] CipherText_out,
    output         CTValid
);

    //--------------------------------------------------------------------------
    // 1) Input Interface
    //--------------------------------------------------------------------------
    wire [127:0] key_from_input;
    wire [127:0] plaintext_from_input;
    wire         new_key_ready;    // Tín hiệu nội bộ
    wire         new_data_ready;   // Tín hiệu nội bộ
    
    InputInterface u_in(
        .clk(clk),
        .rst(rst),
        .LoadKey(LoadKey),
        .LoadData(LoadData),
        .InData(KeyPlaintext_in),
        .KeyOut(key_from_input),
        .DataOut(plaintext_from_input),
        .KeyReady(new_key_ready),
        .DataReady(new_data_ready)
    );
    
    //--------------------------------------------------------------------------
    // 2) Key Logic
    //--------------------------------------------------------------------------
    // Mở rộng khóa, lưu 11 round key, xuất round key theo yêu cầu
    wire [127:0] roundKey_out;  // round key cho Processing Core
    wire         key_exp_done;
    KeyLogic u_keylogic(
        .clk(clk),
        .reset(rst),
        // ...
        .load_key(new_key_ready),
        .cipher_key(key_from_input),
        .sel_round(/* Từ System Control or Processing Core ??? */),
        .round_key(roundKey_out),
        .expansion_done(key_exp_done)
    );
    
    //--------------------------------------------------------------------------
    // 3) S-box ROM
    //--------------------------------------------------------------------------
    // Xử lý SubBytes. Có thể để Processing Core gọi module S_box
    // Bên trong Processing Core, ta gán: S_box sbox_inst(...).
    // Hoặc ta để S_box ROM riêng và ProcessingCore => sbox_addr, sbox_data
    wire [127:0] sbox_addr;
    wire [127:0] sbox_data;
    
    S_box u_sbox(
        .addr(sbox_addr),
        .value(sbox_data)
    );
    
    //--------------------------------------------------------------------------
    // 4) Processing Core
    //--------------------------------------------------------------------------
    // Nhận plaintext_from_input, roundKey_out, sbox_data
    // Xuất CipherText_out, CTValid
    ProcessingCore u_core(
        .clk(clk),
        .reset(rst),
        .start(new_data_ready),  // Bắt đầu mã hóa khi data sẵn sàng
        .inputBlk(plaintext_from_input),
        .roundKey(roundKey_out),
        // Tín hiệu trao đổi với S_box
        .sbox_addr(sbox_addr),
        .sbox_value(sbox_data),
        // Kết quả
        .cipherText(CipherText_out),
        .cTValid(CTValid)
    );
    
    //--------------------------------------------------------------------------
    // 5) System Control Unit (tùy thiết kế)
    //--------------------------------------------------------------------------
    // Thường có 1 FSM giám sát Input Interface, KeyLogic, ProcessingCore...
    // Ở ví dụ này, ta giản lược. 
    // Tùy yêu cầu, ta có thể bổ sung mode, ReadyForKey, ReadyForData, v.v.
    
endmodule

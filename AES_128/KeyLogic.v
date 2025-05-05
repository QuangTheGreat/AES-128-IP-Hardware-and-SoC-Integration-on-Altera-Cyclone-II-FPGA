module KeyLogic(
    input clk,
    input reset,
    input mode,              // 0: expansion mode, 1: read mode
    input load_key,          
    input [127:0] cipher_key, 
    input [3:0] sel_round,   
    input [127:0] sbox_data_in, 
    output [127:0] round_key,
    output expansion_done,   
    output [31:0] rotword_out 
);

    reg [127:0] key_reg [0:10];
    integer i;

    wire expansion_start;
    wire controller_phase;
    wire [3:0] controller_round;
    wire controller_done;
    wire [127:0] new_round_key_comb;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 11; i = i + 1)
                key_reg[i] <= 128'b0;
        end else begin
            if (load_key)
                key_reg[0] <= cipher_key;
            else if (controller_phase)
                key_reg[controller_round] <= new_round_key_comb;
        end
    end

    // KeyLogic Controller
    KeyLogicController controller(
        .clk(clk),
        .reset(reset),
        .load_key(load_key),
        .expansion_start(expansion_start),
        .phase(controller_phase),
        .round_num(controller_round),
        .expansion_done(controller_done)
    );

    // RotWord: sá»­ dá»¥ng 32-bit version, láº¥y tá»« W3 cá»§a key_reg[controller_round]
    RotWord rotword_inst(
        .in(key_reg[controller_round - 1][31:0]),
        .out(rotword_out)
    );

    // RoundKeyExpander tá»• há»£p (combinational)
    RoundKeyExpander rke_comb(
        .phase(controller_phase),
        .prev_key(key_reg[controller_round - 1]),
        .round_num(controller_round),
        .sbox_data_in(sbox_data_in),
        .new_round_key(new_round_key_comb)
    );

    assign round_key = (mode == 1'b1) ? key_reg[sel_round] : 128'bz;
    assign expansion_done = controller_done;
    
endmodule

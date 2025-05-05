`timescale 1ns/1ps
module KeyLogicController(
    input clk,
    input reset,
    input load_key,           // Khi có khóa mới
    output expansion_start,   // Tín hiệu kích hoạt bắt đầu quá trình mở rộng khóa (tổ hợp)
    output phase,             // 0: ROTWORD/SUBBYTES phase; 1: KEYEXPAND phase (tổ hợp)
    output reg [3:0] round_num, // Số vòng hiện tại (0: ban đầu, 1..10: round key) - cập nhật theo clk
    output expansion_done     // Báo hiệu quá trình mở rộng khóa hoàn tất (tổ hợp)
);

    // Các trạng thái FSM
    localparam IDLE       = 2'b00,
               ROTWORD    = 2'b01,
               KEYEXPAND  = 2'b10,
               DONE       = 2'b11;
               
    reg [1:0] state, next_state;
    
    // Cập nhật state (synchronous)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Logic chuyển state (combinational)
    always @(*) begin
        case (state)
            IDLE:       next_state = (load_key) ? ROTWORD : IDLE;
            ROTWORD:    next_state = KEYEXPAND;
            KEYEXPAND:  next_state = (round_num == 4'd10) ? DONE : ROTWORD;
            DONE:       next_state = IDLE;
            default:    next_state = IDLE;
        endcase
    end

    // Các tín hiệu điều khiển được tính toán tổ hợp từ state:
    assign expansion_start = (state == ROTWORD);
    assign phase           = (state == KEYEXPAND);
    assign expansion_done  = (state == DONE);
		
    // Cập nhật round_num (synchronous)
    always @(posedge clk or posedge reset) begin
        if (reset)
            round_num <= 4'd1;
        else if (state == KEYEXPAND)
            round_num <= round_num + 1;
		  else if(state == DONE) round_num <= 4'd1;
    end

endmodule

`timescale 1ns/1ps
module ProcessingCoreController(
    input clk,
    input reset,
    input start,               // Bắt đầu mã hóa block mới
    output phase,            // 0: Phase0 (SubBytes/ShiftRows), 1: Phase1 (MixColumns+AddRoundKey)
    output [3:0] roundCount, // Đếm round: 1 đến 10
    output done              // Báo hiệu block đã mã hóa xong
);

    // Định nghĩa các trạng thái FSM
    localparam IDLE   = 2'b00,
               PHASE0 = 2'b01,
               PHASE1 = 2'b10,
               FINISH = 2'b11;
               
    // State register và bộ đếm round (cập nhật theo clk)
    reg [1:0] state, next_state;
    reg [3:0] roundCount_reg;
    
    // Cập nhật state và roundCount (synchronous)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            roundCount_reg <= 4'd1;
        end else begin
            state <= next_state;
            // Cập nhật roundCount khi đang ở PHASE1
            if (state == PHASE1)
                roundCount_reg <= roundCount_reg + 1;
            else if (state == IDLE)
                roundCount_reg <= 4'd1;
        end
    end

    // Logic chuyển state (combinational)
    always @(*) begin
        case (state)
            IDLE: begin
                if (start)
                    next_state = PHASE0;
                else
                    next_state = IDLE;
            end
            PHASE0: begin
                next_state = PHASE1;
            end
            PHASE1: begin
                if (roundCount_reg == 4'd10)
                    next_state = FINISH;
                else
                    next_state = PHASE0;
            end
            FINISH: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Các tín hiệu điều khiển được tính tổ hợp dựa trên state
    assign phase = (state == PHASE1);
    assign done  = (state == FINISH);
    assign roundCount = roundCount_reg;

endmodule

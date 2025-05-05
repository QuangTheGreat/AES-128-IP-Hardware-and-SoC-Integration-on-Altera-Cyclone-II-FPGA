`timescale 1ns/1ps
module ProcessingCore(
    input clk,
    input reset,
    input start,                   // Bắt đầu mã hóa block mới
    input [127:0] inputBlk,        // Plaintext ban đầu (sau AddRoundKey ban đầu, nếu có)
    input [127:0] roundKey,        // Round key cho round hiện tại (từ KeyLogic)
    input [127:0] subShift_data_in, // Kết quả từ S_box bên ngoài (sau SubBytes xử lý)
	 output [3:0] roundCount_to_KeyLogic,
    output [127:0] cipherText,     // Ciphertext cuối cùng sau 10 round
    output cTValid,                // Báo hiệu block đã mã hóa xong
    output [127:0] shift_out       // Dữ liệu state sau ShiftRow (để S_box xử lý SubBytes)
);

    // Thanh ghi lưu state (state của block)
    reg [127:0] stateReg;
    
    // Controller FSM (ProcessingCoreController) tạo ra các tín hiệu điều khiển:
    // - phase: 0 cho SubBytes/ShiftRows (Phase0), 1 cho MixColumns+AddRoundKey (Phase1)
    // - roundCount: đếm số vòng từ 0 đến 10
    // - done: báo hiệu quá trình mã hóa block đã hoàn tất
    wire phase;
    wire [3:0] roundCount;
    wire done;
    ProcessingCoreController controller(
        .clk(clk),
        .reset(reset),
        .start(start),
        .phase(phase),
        .roundCount(roundCount),
        .done(done)
    );
    
    // Instance của ShiftRow: xuất ra dữ liệu state đã được thực hiện ShiftRows.
    ShiftRow shift_inst (
        .in_state(stateReg),
        .out_state(shift_out)
    );
    
    // MixColumnsAddRoundKey: tính toán trạng thái mới dựa trên kết quả từ S_box (subShift_data_in)
    // và roundKey hiện tại.
    wire [127:0] mixAdd_out;
    MixColumnsAddRoundKey mixAdd(
        .in_state(subShift_data_in),
        .roundKey(roundKey),
        .out_state(mixAdd_out)
    );
    
    // Cập nhật stateReg:  
    // - Nếu đang ở trạng thái khởi đầu (roundCount==0, phase==0, và start active): nạp inputBlk.
    // - Nếu ở Phase1 (phase == 1): stateReg được cập nhật bằng mixAdd_out.
always @(posedge clk or posedge reset) begin
    if (reset)
        stateReg <= 128'b0;
    else begin
        if (start)
            stateReg <= inputBlk;
        else if (phase == 1'b1) begin
            if (roundCount == 4'd10)
                stateReg <= subShift_data_in ^ roundKey;
            else
                stateReg <= mixAdd_out;
        end
    end
end

    assign roundCount_to_KeyLogic = roundCount;
    // Khi done (sau 10 round), stateReg chứa ciphertext
    assign cipherText = (done) ? stateReg : 128'bz;
    assign cTValid = done;
    
endmodule

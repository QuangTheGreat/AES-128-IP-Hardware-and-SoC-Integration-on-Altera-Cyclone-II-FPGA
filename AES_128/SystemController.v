module SystemController(
	input clk,
	input rst,
	input KeyLogic_Done,
	input PCore_Done,
	input new_key,
	input Load_Data,
	input Load_Key,
	output reg KeyLogicMode,
	output reg KeyLogicStart,
	output reg PCoreStart,
	output reg Ready_new_input
);
	
	reg in_loaded;
	//wire key_load;
	reg key_generated;
	reg [2:0] state;
	reg [2:0] next_state;
	localparam IDLE = 3'b000;
	localparam Key_Expand = 3'b001;
	localparam wait_Keyex = 3'b011;
	localparam PCore_Prc = 3'b111;
	localparam wait_PCore = 3'b110;
	localparam Finish = 3'b100;
	
	//Transaction Logic
	always @(*) begin 
		case(state)
			IDLE: begin
    // Luôn cho phép nạp key mới khi có new_key & Load_Key
				if (Load_Key ) begin
					next_state = Key_Expand;
				end
    // Nếu đã nạp plaintext (in_loaded), thì bắt đầu xử lý P‑Core
				else if (in_loaded) begin
					next_state = PCore_Prc;
				end
    // Ngược lại, ở lại IDLE
				else begin
					next_state = IDLE;
				end
			end

			Key_Expand: next_state = wait_Keyex;
			wait_Keyex: begin
				if(!KeyLogic_Done) next_state = wait_Keyex;
				else begin
					if(in_loaded) next_state = PCore_Prc;
					else next_state = IDLE;
				end
			end
			PCore_Prc: next_state = wait_PCore;
			wait_PCore: begin
				if(!PCore_Done) next_state = wait_PCore;
				else next_state = IDLE;
			end
		endcase
	end
	
	always @(posedge clk, posedge rst) begin
		if(rst) begin 
			state <= IDLE;
			in_loaded <= 0;
			key_generated <= 0;
			//next_state <= IDLE;
		end
		else begin
			state <= next_state;
           // khi load data từ bus
           if (Load_Data) in_loaded <= 1'b1;

           // **Khi key expand xong, đánh dấu đã generate key**
           if (state == wait_Keyex && KeyLogic_Done) begin
               key_generated <= 1'b1;
           end
           // (tuỳ chọn) có thể reset in_loaded khi bắt đầu PCore
           if (state == PCore_Prc) begin
               in_loaded <= 1'b0;
		end
	end
	end
	
	always @(*) begin 
		KeyLogicStart = (state == Key_Expand) ? 1:0;
		PCoreStart = (state == PCore_Prc) ? 1:0;
		KeyLogicMode = (state == wait_Keyex) ? 0:1;
		Ready_new_input = (state == IDLE) ? 1 : 0;
	end
endmodule
	
	
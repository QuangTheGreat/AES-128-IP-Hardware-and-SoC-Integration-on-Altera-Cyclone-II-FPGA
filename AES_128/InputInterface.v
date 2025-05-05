module InputInterface(
	input clk,
	input rst,
	input [127:0] in_data,
	input Load_Key,
	input Load_Data,
	input KeyLogic_start,
	input PCore_start,
	output reg [127:0] out_data,
	output reg new_key
);

	reg [127:0] Key;
	reg [127:0] Data;
	
	always @(posedge clk, posedge rst) begin
		if(rst) begin
			Key <= 128'b0;
			Data <= 128'b0;
		end
		else begin
			if(Load_Key) Key <= in_data;
			else if(Load_Data) Data <= in_data;
			else begin
				Key <= Key;
				Data <= Data;
			end
		end
	end
	always @(*) begin 
		if(KeyLogic_start) out_data = Key;
		else if(PCore_start) out_data = Data ^ Key;
		else out_data = 128'bz;
	end
	
	always @(*) begin
		if(!Load_Key) new_key = 0;
		else new_key = (Key == in_data) ? 0 : 1;
	end
	
endmodule
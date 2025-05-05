module AES_Top (
	input clk,
	input rst,
	input [127:0] in_data,
	input Load_Key,
	input Load_Data,
	output Ready_new_input,
	output CTValid,
	output [127:0] CipherText
//	output test_keylogic_start,
//	output test_pcore_start,
//	output test_mode,
//	output test_keyex_done
);

	wire keylogic_start;
	wire pcore_start;
	wire mode;
	wire keyex_done;
	//wire pcore_done;
	SystemController ins_systemcontroller(
	.clk(clk),
	.rst(rst),
	.KeyLogic_Done(keyex_done),
	.PCore_Done(CTValid),
	.new_key(newkey),
	.Load_Data(Load_Data),
	.Load_Key(Load_Key),
	.KeyLogicMode(mode),
	.KeyLogicStart(keylogic_start),
	.PCoreStart(pcore_start),
	.Ready_new_input(Ready_new_input)
);
	wire [127:0] tempbus;
	wire newkey;
	InputInterface ins_inputinterface(
	.clk(clk),
	.rst(rst),
	.in_data(in_data),
	.Load_Key(Load_Key),
	.Load_Data(Load_Data),
	.KeyLogic_start(keylogic_start),
	.PCore_start(pcore_start),
	.out_data(tempbus),
	.new_key(newkey)
);
	wire [31:0] rw_out;
	wire [127:0] sbox_in;
	KeyLogic ins_KeyLogic(
    .clk(clk),
    .reset(rst),
    .mode(mode),              // 0: expansion mode, 1: read mode
    .load_key(keylogic_start),          
    .cipher_key(tempbus), 
    .sel_round(roundcount_pcore_to_keylogic),   
    .sbox_data_in(sbox_out), 
    .round_key(roundkey_keylogic_to_pcore),
    .expansion_done(keyex_done),   
    .rotword_out(rw_out) 
);
	wire [3:0] roundcount_pcore_to_keylogic;
	wire [127:0] roundkey_keylogic_to_pcore;
	ProcessingCore ins_ProcessingCore(
    .clk(clk),
    .reset(rst),
    .start(pcore_start),                  	
    .inputBlk(tempbus),        
    .roundKey(roundkey_keylogic_to_pcore),        
    .subShift_data_in(sbox_out), 
	 .roundCount_to_KeyLogic(roundcount_pcore_to_keylogic),
    .cipherText(CipherText),     
    .cTValid(CTValid),                
    .shift_out(mux1)       
);
	wire [127:0] mux1;
	wire [127:0] muxout;
	wire [127:0] mux0;
	assign mux0 = {96'b0,rw_out};
	mux_2to1_128bit ins_mux(
	.s(mode),
	.in0(mux0),
	.in1(mux1),
	.mux_out(muxout)
);
	wire [127:0] sbox_out;
	S_box ins_SBox(
	.clk(clk),
	.addr(muxout),
   .value(sbox_out)
);
//	assign test_keylogic_start = keylogic_start;
//	assign test_pcore_start = pcore_start;
//	assign test_mode = mode;
//	assign test_keyex_done = keyex_done;

endmodule
library verilog;
use verilog.vl_types.all;
entity AES_Top_vlg_sample_tst is
    port(
        Load_Data       : in     vl_logic;
        Load_Key        : in     vl_logic;
        clk             : in     vl_logic;
        in_data         : in     vl_logic_vector(127 downto 0);
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end AES_Top_vlg_sample_tst;

library verilog;
use verilog.vl_types.all;
entity AES_Top_vlg_check_tst is
    port(
        CTValid         : in     vl_logic;
        CipherText      : in     vl_logic_vector(127 downto 0);
        Ready_new_input : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end AES_Top_vlg_check_tst;

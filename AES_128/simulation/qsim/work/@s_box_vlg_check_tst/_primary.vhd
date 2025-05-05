library verilog;
use verilog.vl_types.all;
entity S_box_vlg_check_tst is
    port(
        value           : in     vl_logic_vector(127 downto 0);
        sampler_rx      : in     vl_logic
    );
end S_box_vlg_check_tst;

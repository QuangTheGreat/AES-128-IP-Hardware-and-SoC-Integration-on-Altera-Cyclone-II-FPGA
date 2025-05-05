library verilog;
use verilog.vl_types.all;
entity S_box_vlg_sample_tst is
    port(
        addr            : in     vl_logic_vector(127 downto 0);
        clk             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end S_box_vlg_sample_tst;

library verilog;
use verilog.vl_types.all;
entity S_box is
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector(127 downto 0);
        value           : out    vl_logic_vector(127 downto 0)
    );
end S_box;

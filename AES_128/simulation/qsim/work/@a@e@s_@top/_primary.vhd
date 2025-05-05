library verilog;
use verilog.vl_types.all;
entity AES_Top is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        in_data         : in     vl_logic_vector(127 downto 0);
        Load_Key        : in     vl_logic;
        Load_Data       : in     vl_logic;
        Ready_new_input : out    vl_logic;
        CTValid         : out    vl_logic;
        CipherText      : out    vl_logic_vector(127 downto 0)
    );
end AES_Top;

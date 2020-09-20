library verilog;
use verilog.vl_types.all;
entity Gompegolomb is
    port(
        m               : in     vl_logic_vector(7 downto 0);
        numberofzeroes  : in     vl_logic_vector(7 downto 0);
        codeword        : out    vl_logic_vector(15 downto 0)
    );
end Gompegolomb;

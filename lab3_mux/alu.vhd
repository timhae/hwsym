LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY alu IS
    GENERIC (WIDTH : POSITIVE := 8);
    PORT (
        in0, in1 : IN std_logic_vector (WIDTH - 1 DOWNTO 0);
        op_code : IN std_logic_vector (3 DOWNTO 0);
        result : OUT std_logic_vector (WIDTH - 1 DOWNTO 0);
        status : OUT std_logic_vector (3 DOWNTO 0)
    );
END alu;

ARCHITECTURE structural OF alu IS
    SIGNAL inter_res, nullvector : std_logic_vector (WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL big_inter_res, big_in0, big_in1 : std_logic_vector (WIDTH DOWNTO 0);
    SIGNAL z, n, c, v : std_logic := '0';
BEGIN
    -- setup container vectors
    big_in0 <= in0(in0'high) & '0' & in0(in0'high - 1 DOWNTO 0) WHEN op_code < "0101" ELSE -- sign matters
        '0' & in0; -- sign does not matter
    big_in1 <= in1(in1'high) & '0' & in1(in1'high - 1 DOWNTO 0) WHEN op_code < "0101" ELSE -- sign matters
        '0' & in1; -- sign does not matter
    inter_res <= big_inter_res(big_inter_res'high - 1 DOWNTO 0);

    -- handle result
    WITH op_code SELECT
        big_inter_res <= std_logic_vector(signed(big_in0) + signed(big_in1)) WHEN "0000", -- ADD Output bitwise addition of A and B
        std_logic_vector(signed(big_in0) - signed(big_in1)) WHEN "0001", -- SUB Output bitwise subtraction of A and B
        std_logic_vector(signed(big_in0) * signed(big_in1)) WHEN "0010", -- MUL Output multiplication of A and B
        std_logic_vector(signed(big_in0) SLL to_integer(signed(big_in1))) WHEN "0011", -- SLL Output logical shift to A w.r.t. B to the left
        std_logic_vector(signed(big_in0) SRL to_integer(signed(big_in1))) WHEN "0100", -- SRL Output logical shift to A w.r.t. B to the right
        --        in0 + in1 WHEN "0101", -- MOVL Move 16-bit immediate to lower 16-bits of register we only work with 8 bit wide registers
        --        in0 + in1 WHEN "0110", -- MOVH Move 16-bit immediate to upper 16-bits of register same as above
        big_in0 AND big_in1 WHEN "0111", -- AND Output bitwise AND operation on A and B
        big_in0 OR big_in1 WHEN "1000", -- OR Output bitwise OR operation on A and B
        big_in0 XOR big_in1 WHEN "1001", -- XOR Output bitwise XOR operation on A and B
        big_in0 NOR big_in1 WHEN "1010", -- NOR Output bitwise NOR operation on A and B
        big_in0 NAND big_in1 WHEN "1011", -- NAND Output bitwise NAND operation on A and B
        big_in0 XNOR big_in1 WHEN "1100", -- XNOR Output bitwise XNOR operation on A and B
        NOT(big_in0) WHEN "1101"; -- NOT Output NOT operation on A
    --        in0 + in1 WHEN "1110", -- JAL Jump to immediate address what does this mean in this context?
    --        in0 + in1 WHEN "1111"; -- BEQ Jump when A and B are equal jump where to?
    result <= inter_res;

    -- handle flags
    --status(3) z: bit is set if the result is zero
    z <= '1' WHEN inter_res = nullvector ELSE
        '0';
    --status(2) n: bit is set if the result is negative
    n <= '1' WHEN inter_res(inter_res'high) = '1' ELSE
        '0';
    --status(1) c: is the following bit -> result(WIDTH)
    c <= big_inter_res(big_inter_res'high);
    --status(0) v: if a negativ or positiv number has an overflow
    v <= '1' WHEN big_inter_res(big_inter_res'high) /= inter_res(inter_res'high) AND op_code < "0101" ELSE
        '0'; -- sign only matters for operations < 0101
    status <= z & n & c & v;

END structural;
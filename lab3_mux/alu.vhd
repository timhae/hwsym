LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;
USE ieee.numeric_bit.ALL;

ENTITY ALU IS
    GENERIC (WIDTH : POSITIVE := 8);
    PORT (
        in0, in1 : IN std_logic_vector (WIDTH - 1 DOWNTO 0);
        op_code : IN std_logic_vector (3 DOWNTO 0);
        result : OUT std_logic_vector (WIDTH - 1 DOWNTO 0);
        status : OUT std_logic_vector (3 DOWNTO 0)
    );
END ALU;

ARCHITECTURE structural OF ALU IS
BEGIN
    PROCESS (in0, in1, op_code)
    BEGIN
        CASE op_code IS
            WHEN "0000" => result <= in0 + in1; -- ADD Output bitwise addition of A and B
            WHEN "0001" => result <= in0 - in1; -- SUB Output bitwise subtraction of A and B
            WHEN "0010" => result <= in0 * in1; -- MUL Output multiplication of A and B
                -- import error
                --WHEN "0011" => result <= in0 sll in1; -- SLL Output logical shift to A w.r.t. B to the left
                --WHEN "0100" => result <= in0 slr in1; -- SRL Output logical shift to A w.r.t. B to the right
                --WHEN "0101" => result <= in0 sla in1; -- SLA Output arithmetic shift to A w.r.t. B to the left
                --WHEN "0110" => result <= in0 sra in1; -- SRA Output arithmetic shift to A w.r.t. B to the right
            WHEN "0111" => result <= in0 AND in1; -- AND Output bitwise AND operation on A and B
            WHEN "1000" => result <= in0 OR in1; -- OR Output bitwise OR operation on A and B
            WHEN "1001" => result <= in0 XOR in1; -- XOR Output bitwise XOR operation on A and B
            WHEN "1010" => result <= NOT (in0 OR in1); -- NOR Output bitwise NOR operation on A and B
            WHEN "1011" => result <= NOT (in0 OR in1); -- NAND Output bitwise NAND operation on A and B
            WHEN "1100" => result <= NOT (in0 XOR in1); -- XNOR Output bitwise XNOR operation on A and B
            WHEN "1101" => result <= NOT in0; -- NOT Output NOT operation on A
                -- vhdl 2008 only
                --WHEN "1110" => result <= MAXIMUM(in0, in1); -- MAX Output largest operand of the two A and B
                --WHEN "1111" => result <= MINIMUM(in0, in1); -- MIN Output smallest operand of the two A and B
        END CASE;
    END PROCESS;
END structural;
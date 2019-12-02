LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY half_adder IS
    PORT (
        A     : IN  STD_LOGIC;
        B     : IN  STD_LOGIC;
        SUM   : OUT STD_LOGIC;
        CARRY : OUT STD_LOGIC
    );
END half_adder;
ARCHITECTURE structural OF half_adder IS
    COMPONENT and2
        PORT (
            in1, in2 : IN  STD_LOGIC;
            and_out  : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT xor2
        PORT (
            in1, in2 : IN  STD_LOGIC;
            xor_out  : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    AND2U : and2
    PORT MAP(in1 => A, in2 => B, and_out => CARRY);
    XOR2U : xor2
    PORT MAP(in1 => A, in2 => B, xor_out => SUM);
END structural;
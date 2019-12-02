LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY xor2 IS
    PORT (
        in1, in2 : IN  STD_LOGIC;
        xor_out  : OUT STD_LOGIC
    );
END xor2;
ARCHITECTURE structural OF xor2 IS
BEGIN
    xor_out <= in1 XOR in2;
END structural;
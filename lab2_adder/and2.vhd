LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY and2 IS
    PORT (
        in1, in2 : IN  STD_LOGIC;
        and_out  : OUT STD_LOGIC
    );
END and2;
ARCHITECTURE structural OF and2 IS
BEGIN
    and_out <= in1 AND in2;
END structural;
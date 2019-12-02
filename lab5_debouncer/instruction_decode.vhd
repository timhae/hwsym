LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Instruction_Decode IS
    GENERIC (WIDTH : POSITIVE := 8);
    PORT (
        instruction                 : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        IF_valid, EX_valid, rd, clk : IN  STD_LOGIC;
        ID_valid                    : OUT STD_LOGIC;
        opcode                      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        in1, in2                    : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)
    );
END Instruction_Decode;

ARCHITECTURE Behavioral OF Instruction_Decode IS

BEGIN
END Behavioral;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Splitter IS
    PORT (
        Counter : IN  STD_LOGIC_VECTOR (5 DOWNTO 0);
        D1      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        D0      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Splitter;

ARCHITECTURE Behavioral OF Splitter IS
    CONSTANT const_val       : unsigned(13 DOWNTO 0) := to_unsigned(6553, 14); --(2^16)/10 = 6553
    SIGNAL valIn_x_const_val : unsigned(19 DOWNTO 0);
BEGIN

    D1(3) <= '0';
    D1(2) <= (Counter(5) AND Counter(3)) OR (Counter(5) AND Counter(4));
    D1(1) <= (NOT Counter(5) AND Counter(4) AND Counter(2)) OR
    (NOT Counter(5) AND Counter(4) AND Counter(3)) OR
    (Counter(4) AND Counter(3) AND Counter(2)) OR
    (Counter(5) AND (NOT Counter(4)) AND (NOT Counter(3)));
    D1(0) <= (Counter(5) AND (NOT Counter(4)) AND (NOT Counter(3))) OR
    (Counter(5) AND (NOT Counter(3) AND Counter(1))) OR
    (Counter(5) AND (NOT Counter(3)) AND Counter(2)) OR
    (NOT Counter(5) AND (NOT Counter(4)) AND Counter(3) AND Counter(1)) OR
    ((NOT Counter(5)) AND (NOT Counter(4)) AND Counter(3) AND Counter(2)) OR
    ((NOT Counter(5)) AND Counter(3) AND Counter(2) AND Counter(1)) OR
    ((NOT Counter(5)) AND Counter(4) AND (NOT Counter(3)) AND (NOT Counter(2))) OR
    (Counter(5) AND Counter(4) AND Counter(3) AND (NOT Counter(2)));

    D0(3) <= ((NOT Counter(5)) AND (NOT Counter(4)) AND Counter(3) AND (NOT Counter(2)) AND (NOT Counter(1))) OR
    ((NOT Counter(5)) AND Counter(4) AND (NOT Counter(3)) AND (NOT Counter(2)) AND Counter(1)) OR
    ((NOT Counter(5)) AND Counter(4) AND Counter(3) AND Counter(2) AND (NOT Counter(1))) OR
    (Counter(5) AND (NOT Counter(4)) AND (NOT Counter(3)) AND Counter(2) AND Counter(1)) OR
    (Counter(5) AND Counter(4) AND (NOT Counter(3)) AND (NOT Counter(2)) AND (NOT Counter(1))) OR
    (Counter(5) AND Counter(4) AND Counter(3) AND (NOT Counter(2)) AND Counter(1));
    D0(2) <= ((NOT Counter(5)) AND (NOT Counter(4)) AND (NOT Counter(3)) AND Counter(2)) OR
    ((NOT Counter(4)) AND Counter(3) AND Counter(2) AND Counter(1)) OR
    ((NOT Counter(5)) AND Counter(4) AND (NOT Counter(2)) AND (NOT Counter(1))) OR
    ((NOT Counter(5)) AND Counter(4) AND Counter(3) AND (NOT Counter(2))) OR
    (Counter(4) AND Counter(3) AND (NOT Counter(2)) AND (NOT Counter(1))) OR
    (Counter(5) AND (NOT Counter(4)) AND Counter(2) AND (NOT Counter(1))) OR
    (Counter(5) AND (NOT Counter(4)) AND (NOT Counter(3)) AND (NOT Counter(2)) AND Counter(1)) OR
    (Counter(5) AND Counter(4) AND (NOT Counter(3)) AND Counter(2) AND Counter(1));
    D0(1) <= ((NOT Counter(5)) AND (NOT Counter(4)) AND (NOT Counter(3)) AND Counter(1)) OR
    ((NOT Counter(5)) AND (NOT Counter(3)) AND Counter(2) AND Counter(1)) OR
    (Counter(5) AND (NOT Counter(4)) AND (NOT Counter(3)) AND (NOT Counter(1))) OR
    (Counter(5) AND (NOT Counter(3)) AND Counter(2) AND (NOT Counter(1))) OR
    (Counter(5) AND (NOT Counter(4)) AND Counter(3) AND Counter(1)) OR
    (Counter(5) AND Counter(3) AND Counter(2) AND Counter(1)) OR
    ((NOT Counter(5)) AND (NOT Counter(4)) AND Counter(3) AND Counter(2) AND (NOT Counter(1))) OR
    ((NOT Counter(5)) AND Counter(4) AND (NOT Counter(3)) AND (NOT Counter(2)) AND (NOT Counter(1))) OR
    ((NOT Counter(5)) AND Counter(4) AND Counter(3) AND (NOT Counter(2)) AND Counter(1)) OR
    (Counter(5) AND Counter(4) AND Counter(3) AND (NOT Counter(2)) AND (NOT Counter(1)));
    D0(0)             <= Counter(0);

    valIn_x_const_val <= unsigned(Counter) * const_val + (2 ** 13);
    --div <= std_logic_vector(valIn_x_const_val(19 downto 14));

END Behavioral;
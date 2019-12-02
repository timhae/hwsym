LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY full_adder IS
    PORT (
        A, B, CIN : IN  STD_LOGIC;
        SUM, COUT : OUT STD_LOGIC
    );
END full_adder;
ARCHITECTURE structural OF full_adder IS
    COMPONENT half_adder
        PORT (
            a, b       : IN  STD_LOGIC;
            sum, carry : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL SIG1, SIG2, SIG3 : STD_LOGIC;
BEGIN
    U1 : half_adder
    PORT MAP(a => A, b => B, sum => SIG1, carry => SIG2);

    U2 : half_adder
    PORT MAP(a => CIN, b => SIG1, sum => SUM, carry => SIG3);

    COUT <= SIG2 OR SIG3;
END structural;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ripple_adder IS
    GENERIC (WIDTH : POSITIVE := 8);
    PORT (
        A, B : IN  STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        SUM  : OUT STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        COUT : OUT STD_LOGIC
    );
END ripple_adder;
ARCHITECTURE structural OF ripple_adder IS
    COMPONENT full_adder
        PORT (
            a, b, cin : IN  STD_LOGIC;
            sum, cout : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL C : STD_LOGIC_VECTOR(WIDTH - 2 DOWNTO 0);
BEGIN
    reg : FOR i IN WIDTH DOWNTO 0 GENERATE
        reg_begin : IF i = 0 GENERATE
            FA : full_adder
            PORT MAP(A => A(i), B => B(i), CIN => '0', sum => SUM(i), cout => C(i));
        END GENERATE;
        reg_middle : IF i > 0 AND i < (WIDTH - 1) GENERATE
            FAM : full_adder
            PORT MAP(A => A(i), B => B(i), CIN => C(i - 1), sum => SUM(i), cout => C(i));
        END GENERATE;
        reg_end : IF i = (WIDTH - 1) GENERATE
            FAE : full_adder
            PORT MAP(A => A(i), B => B(i), CIN => C(i - 1), sum => SUM(i), cout => COUT);
        END GENERATE;
    END GENERATE;
END structural;
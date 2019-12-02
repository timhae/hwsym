LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EdgeDetector IS
    PORT (
        Clk         : IN  STD_LOGIC;
        InputSignal : IN  STD_LOGIC;
        Edge        : OUT STD_LOGIC
    );
END EdgeDetector;

ARCHITECTURE behavioral OF EdgeDetector IS
    COMPONENT flipflop IS
        PORT (
            clk, input : IN  STD_LOGIC;
            output     : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL Q_1, Q_2 : STD_LOGIC;

BEGIN
    ff_1 : flipflop
    PORT MAP(clk => Clk, input => InputSignal, output => Q_1);

    ff_2 : flipflop
    PORT MAP(clk => Clk, input => Q_1, output => Q_2);

    Edge <= (Q_1 AND (NOT Q_2));

END behavioral;
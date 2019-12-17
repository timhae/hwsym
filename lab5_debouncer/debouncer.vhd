LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Debouncer IS
    GENERIC (threshold : POSITIVE := 10);

    PORT (
        clk       : IN  STD_LOGIC;
        Button    : IN  STD_LOGIC;
        debounced : OUT STD_LOGIC
    );
END Debouncer;

ARCHITECTURE Behavioral OF debouncer IS
    COMPONENT EdgeDetector IS
        PORT (
            Clk         : IN  STD_LOGIC;
            InputSignal : IN  STD_LOGIC;
            Edge        : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL counter     : INTEGER   := 0;
--    SIGNAL Q1, Q2, ena : STD_LOGIC := '0';
--    SIGNAL rst         : STD_LOGIC := '1';
    SIGNAL tmp         : STD_LOGIC := '0';
BEGIN
    PROCESS (clk, Button) IS
    BEGIN
        tmp <= '0';
        IF rising_edge(clk) then
            if Button = '1' THEN
                IF counter = threshold then
                    tmp <= '1';
                elsif counter < threshold then
                    counter <= counter + 1;
                end if;
            else
                counter <= 0;
            end if;
        END IF;
    END PROCESS;

--    PROCESS (clk) IS
--    BEGIN
--        IF rising_edge(clk) THEN
--            Q2 <= Q1;
--        END IF;
--    END PROCESS;

--    rst <= Q1 NAND Q2;

--    PROCESS (rst, clk) IS
--    BEGIN
--        IF rst = '0' THEN
--            IF rising_edge(clk) THEN
--                IF counter < threshold THEN
--                    counter <= counter + 1;
--                ELSE
--                    ena <= '1';
--                END IF;
--            END IF;
--        ELSE
--            ena     <= '0';
--            counter <= 0;
--        END IF;
--    END PROCESS;

--    PROCESS (clk) IS
--    BEGIN
--        IF rising_edge(clk) THEN
--            fin <= ena AND Q2;
--        END IF;
--    END PROCESS;

    detector : EdgeDetector
    PORT MAP(Clk => clk, InputSignal => tmp, Edge => debounced);

END Behavioral;
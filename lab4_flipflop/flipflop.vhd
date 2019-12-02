LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY flipflop IS
    PORT (
        --        clk, input, rst, enable : IN std_logic;
        clk, input : IN  STD_LOGIC;
        output     : OUT STD_LOGIC);
END flipflop;

ARCHITECTURE behavioral OF flipflop IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            output <= input;
        END IF;
    END PROCESS;
END behavioral;

-- Using synchronous Reset
--ARCHITECTURE behavioral2 OF flipflop IS
--BEGIN
--    PROCESS (clk)
--    BEGIN
--        IF (clk'event AND clk = '1') THEN
--            IF (rst = '0') THEN
--                output <= input;
--            ELSE
--                output <= '0';
--            END IF;
--        END IF;
--    END PROCESS;
--END behavioral2;

--ARCHITECTURE behavioral3 OF flipflop IS
--BEGIN
--    -- Using asynchronous Reset
--    PROCESS (clk, rst)
--    BEGIN
--        IF (rst = '0') THEN
--            IF (clk'event AND clk = '1') THEN
--                output <= input;
--            END IF;
--        ELSE

--            output <= '0';
--        END IF;
--    END PROCESS;
--END behavioral3;

--ARCHITECTURE behavioral4 OF flipflop IS
--BEGIN
--    -- Using Chip Enable
--    PROCESS (clk, rst)
--    BEGIN
--        IF (rst = '0') THEN
--            IF (clk'event AND clk = '1') THEN
--                IF (enable = '1') THEN
--                    output <= input;
--                END IF;
--            END IF;
--        ELSE
--            output <= '0';
--        END IF;
--    END PROCESS;
--END behavioral4;
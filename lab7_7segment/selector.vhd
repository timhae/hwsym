LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Selector IS
    GENERIC (delay : INTEGER := 100000); -- should be 1ms
    PORT (
        Clk     : IN  STD_LOGIC;
        Count   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Display : OUT STD_LOGIC_VECTOR (5 DOWNTO 0));
END Selector;

ARCHITECTURE behavioural OF Selector IS
    SIGNAL counter        : INTEGER RANGE 0 TO delay := 0;
    SIGNAL display_select : INTEGER RANGE 0 TO 5     := 0;
BEGIN
    PROCESS (Clk)
    BEGIN
        IF (counter < delay) THEN
            counter <= counter + 1;
        ELSE
            counter        <= 0;
            display_select <= display_select + 1;
            CASE display_select IS -- make sure the mapping is correct
                WHEN 0 =>
                    Count   <= "000";
                    Display <= "000001";
                WHEN 1 =>
                    Count   <= "001";
                    Display <= "000010";
                WHEN 2 =>
                    Count   <= "010";
                    Display <= "000100";
                WHEN 3 =>
                    Count   <= "011";
                    Display <= "001000";
                WHEN 4 =>
                    Count   <= "100";
                    Display <= "010000";
                WHEN 5 =>
                    Count   <= "101";
                    Display <= "100000";
                WHEN OTHERS =>
                    Count   <= "000";
                    Display <= "000000";
            END CASE;
        END IF;
    END PROCESS;
END behavioural;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux IS
    PORT (
        A, B, C, D : IN  STD_LOGIC;
        S          : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
        O          : OUT STD_LOGIC
    );
END mux;

ARCHITECTURE structural OF mux IS
BEGIN
    WITH S SELECT
        O <= A WHEN "00",
        B WHEN "01",
        C WHEN "10",
        D WHEN OTHERS;
END structural;

ARCHITECTURE structural_2 OF mux IS
BEGIN
    O <= A WHEN S = "00" ELSE
        B WHEN S = "01" ELSE
        C WHEN S = "10" ELSE
        D;
END structural_2;

ARCHITECTURE structural_3 OF mux IS
BEGIN
    PROCESS (A, B, C, D, S)
    BEGIN
        IF (S(0) = '1') THEN
            IF (S(1) = '1') THEN
                O <= A;
            ELSE
                O <= B;
            END IF;
        ELSE
            IF (S(1) = '1') THEN
                O <= C;
            ELSE
                O <= D;
            END IF;
        END IF;
    END PROCESS;
END structural_3;

ARCHITECTURE structural_4 OF mux IS
BEGIN
    PROCESS (A, B, C, D, S)
    BEGIN
        CASE s IS
            WHEN "00"   => O   <= A;
            WHEN "01"   => O   <= B;
            WHEN "10"   => O   <= C;
            WHEN "11"   => O   <= D;
            WHEN OTHERS => O <= A;
        END CASE;
    END PROCESS;
END structural_4;
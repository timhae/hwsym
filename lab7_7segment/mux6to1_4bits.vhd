LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux6to1_4bits IS
    PORT (
        A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        C : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        E : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        F : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Mux6to1_4bits;

ARCHITECTURE behavioural OF Mux6to1_4bits IS
BEGIN

    PROCESS (Sel)
    BEGIN

        CASE Sel IS
            WHEN "000" => Output <= A;
            WHEN "001" => Output <= B;
            WHEN "010" => Output <= C;
            WHEN "011" => Output <= D;
            WHEN "100" => Output <= E;
            WHEN "101" => Output <= F;
            WHEN OTHERS => Output <= "0000";
        END CASE;

    END PROCESS;

END behavioural;
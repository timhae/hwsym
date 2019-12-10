LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BCDto7Seg IS
    PORT (
        BCD      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        Segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
    );
END BCDto7Seg;

ARCHITECTURE structural OF BCDto7seg IS
BEGIN
    PROCESS (BCD)
    BEGIN
        CASE BCD IS
            WHEN "0000" => Segments <= "1000000";       -- 0 
            WHEN "0001" => Segments <= "1111001";       -- 1 
            WHEN "0010" => Segments <= "0100100";       -- 2 
            WHEN "0011" => Segments <= "0110000";       -- 3 
            WHEN "0100" => Segments <= "0011001";       -- 4 
            WHEN "0101" => Segments <= "0010010";       -- 5 
            WHEN "0110" => Segments <= "0000010";       -- 6 
            WHEN "0111" => Segments <= "1111000";       -- 7 
            WHEN "1000" => Segments <= "0000000";       -- 8 
            WHEN "1001" => Segments <= "0010000";       -- 9
            WHEN OTHERS => Segments <= (OTHERS => '0'); -- default
        END CASE;
    END PROCESS;
END structural;
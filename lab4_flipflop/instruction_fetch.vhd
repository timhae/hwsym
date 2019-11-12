LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- PROGRAM COUNTER
ENTITY program_counter IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        addr_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        addr_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END program_counter;

ARCHITECTURE behavioral OF program_counter IS
    SIGNAL counter : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst)
    BEGIN
        -- reset highest prio
        IF rst = '1' THEN
            addr_out <= (OTHERS => '0');
            counter <= (OTHERS => '0');

            -- increase counter or pipe through, sync
        ELSIF clk'event AND clk = '1' THEN
            IF sel = '1' THEN
                addr_out <= addr_in;
            ELSIF sel = '0' THEN
                counter <= std_logic_vector(signed(counter) + 1);
                addr_out <= counter;
            END IF;
        END IF;
    END PROCESS;
END behavioral;

-- RAM
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY rams_08 IS
    PORT (
        CLK : IN std_logic;
        WriteEnable : IN std_logic;
        Address : IN std_logic_vector(7 DOWNTO 0);
        DataIn : IN std_logic_vector(31 DOWNTO 0);
        DataOut : OUT std_logic_vector(31 DOWNTO 0));
END rams_08;

ARCHITECTURE syn OF rams_08 IS
    TYPE ram_type IS ARRAY (255 DOWNTO 0) OF std_logic_vector (31 DOWNTO 0);
    SIGNAL RAM : ram_type;
BEGIN

    PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            IF (WriteEnable = '1') THEN -- how to write program instructions to rom?
                RAM(to_integer(unsigned(Address))) <= DataIn;
            END IF;
        END IF;
    END PROCESS;

    DataOut <= RAM(to_integer(unsigned(Address)));
END syn;
-- set_property file_type {VHDL 2008} [get_files *]
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Counters IS
    GENERIC (
        Fin : INTEGER := 100000000;
        Fout : INTEGER := 1);
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Up : IN STD_LOGIC;
        Down : IN STD_LOGIC;
        RW : IN STD_LOGIC;
        Condition : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        Hours : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
        Minutes : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        Seconds : OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
    );
END Counters;

ARCHITECTURE behavioral OF counters IS
    SIGNAL h_count : std_logic_vector(4 DOWNTO 0);
    SIGNAL m_count, s_count : std_logic_vector(5 DOWNTO 0);
    SIGNAL modulo_count : INTEGER := 0;
    SIGNAL slow_clock : std_logic := '0';
BEGIN
    -- clock divisor
    PROCESS (Clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (modulo_count = Fin - 1) THEN
                modulo_count <= 0;
                slow_clock <= '1';
            ELSE
                modulo_count <= modulo_count + 1;
                slow_clock <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- actual processing
    PROCESS (Clk, Reset, Up, Down, RW, Condition)
    BEGIN
        -- reset highest prio, async
        IF (reset = '1') THEN
            h_count <= "00000";
            m_count <= "000000";
            s_count <= "000000";

            -- write second highest prio, async, overflow only within number
        ELSIF (RW = '1') THEN
            -- change hours
            IF (Condition = "00") THEN
                IF (Up = '1' AND Down = '0' AND h_count = "10111") THEN
                    h_count <= "00000";
                ELSIF (Up = '0' AND Down = '1' AND h_count = "00000") THEN
                    h_count <= "10111";
                ELSE
                    h_count <= h_count + 1;
                END IF;

                -- change minutes
            ELSIF Condition = "01" THEN
                IF (Up = '1' AND Down = '0' AND m_count = "111011") THEN
                    m_count <= "000000";
                ELSIF (Up = '0' AND Down = '1' AND m_count = "000000") THEN
                    m_count <= "111011";
                ELSE
                    m_count <= m_count + 1;
                END IF;

                -- change seconds
            ELSIF Condition = "10" THEN
                IF (Up = '1' AND Down = '0' AND s_count = "111011") THEN
                    s_count <= "000000";
                ELSIF (Up = '0' AND Down = '1' AND s_count = "000000") THEN
                    s_count <= "111011";
                ELSE
                    s_count <= s_count + 1;
                END IF;
            END IF;

            -- normal counting mode last prio, sync
        ELSIF (RW = '0' AND clk'event AND clk = '1' AND slow_clock = '1') THEN
            s_count <= s_count + 1;
            -- handle overflows
            IF (s_count = "111011") THEN
                s_count <= "000000";
                m_count <= m_count + 1;
            END IF;
            IF (m_count = "111011") THEN
                m_count <= "000000";
                h_count <= h_count + 1;
            END IF;
            IF (h_count = "10111") THEN
                h_count <= "00000";
            END IF;
        END IF;
    END PROCESS;

    Hours <= h_count;
    Minutes <= m_count;
    Seconds <= s_count;
END behavioral;
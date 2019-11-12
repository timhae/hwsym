LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Counters IS
    GENERIC (
        Fin : INTEGER := 10;
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
    SIGNAL h_count, m_count, s_count : INTEGER := 0;
    SIGNAL modulo_count : INTEGER := 0;
BEGIN
    PROCESS (Clk, Reset, Up, Down, RW)
    BEGIN
        -- reset highest prio, async
        IF (reset = '0') THEN
            -- write mode second highest prio, async
            IF (RW = '1') THEN

                -- change hours
                IF (Condition = "00") THEN
                    IF (Up = '1' AND Down = '0') THEN
                        IF (h_count = 23) THEN
                            h_count <= 0;
                        ELSE
                            h_count <= h_count + 1;
                        END IF;
                    ELSIF (Up = '0' AND Down = '1') THEN
                        IF (h_count = 0) THEN
                            h_count <= 23;
                        ELSE
                            h_count <= h_count - 1;
                        END IF;
                    END IF;

                -- change minutes
                ELSIF Condition = "01" THEN
                    IF (Up = '1' AND Down = '0') THEN
                        IF (m_count = 59) THEN
                            m_count <= 0;
                        ELSE
                            m_count <= m_count + 1;
                        END IF;
                    ELSIF (Up = '0' AND Down = '1') THEN
                        IF (m_count = 0) THEN
                            m_count <= 59;
                        ELSE
                            m_count <= m_count - 1;
                        END IF;
                    END IF;

                -- change seconds
                ELSIF Condition = "10" THEN
                    IF (Up = '1' AND Down = '0') THEN
                        IF (s_count = 59) THEN
                            s_count <= 0;
                        ELSE
                            s_count <= s_count + 1;
                        END IF;
                    ELSIF (Up = '0' AND Down = '1') THEN
                        IF (s_count = 0) THEN
                            s_count <= 59;
                        ELSE
                            s_count <= s_count - 1;
                        END IF;
                    END IF;
                END IF;

            -- normal counting mode last prio, sync
            ELSIF (RW = '0' AND clk'event AND clk = '1') THEN
                IF (modulo_count = Fin) THEN
                    modulo_count <= 0;
                    s_count <= s_count + 1;
                    -- handle overflows
                    IF (s_count = 59) THEN
                        s_count <= 0;
                        m_count <= m_count + 1;
                        IF (m_count = 59) THEN
                            m_count <= 0;
                            h_count <= h_count + 1;
                            IF (h_count = 23) THEN
                                h_count <= 0;
                            END IF;
                        END IF;
                    END IF;
                ELSE
                    modulo_count <= modulo_count + 1;
                END IF;
            END IF;

        -- reset
        ELSE
            modulo_count <= 0;
            h_count <= 0;
            m_count <= 0;
            s_count <= 0;
        END IF;
    END PROCESS;

    Hours <= std_logic_vector(to_unsigned(h_count, 5));
    Minutes <= std_logic_vector(to_unsigned(m_count, 6));
    Seconds <= std_logic_vector(to_unsigned(s_count, 6));
END behavioral;
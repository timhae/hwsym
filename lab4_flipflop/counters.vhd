-- set_property file_type {VHDL 2008} [get_files *]
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
    -- actual processing
    PROCESS (Clk, Reset, Up, Down, RW)
    BEGIN
        -- reset highest prio, async
        IF (reset = '0') THEN


    
            -- normal counting mode last prio, sync
            IF (clk'event AND clk = '1') THEN
            
                
                    -- write second highest prio, async, overflow only within number
                    IF (RW = '1') THEN
                        -- change hours
                        IF (Condition = "00") THEN
                            IF (Up = '1' AND Down = '0') THEN
                                if (h_count = 23) then
                                    h_count <= 0;
                                else
                                    
                                end if;           
                            ELSIF (Up = '0' AND Down = '1') THEN
                                if (h_count = 0) then
                                    h_count <= 23;
                            END IF;
        
                        -- change minutes
                        ELSIF Condition = "01" THEN
                            IF (Up = '1' AND Down = '0' AND m_count = 59) THEN
                                m_count <= 0;
                            ELSIF (Up = '0' AND Down = '1' AND m_count = 0) THEN
                                m_count <= 59;
                            ELSE
                                m_count <= m_count + 1;
                            END IF;
            
                        -- change seconds
                        ELSIF Condition = "10" THEN
                            IF (Up = '1' AND Down = '0' AND s_count = 59) THEN
                                s_count <= 0;
                            ELSIF (Up = '0' AND Down = '1' AND s_count = 0) THEN
                                s_count <= 59;
                            ELSE
                                s_count <= s_count + 1;
                            END IF;
                        END IF;
    
                    elsif (rw='0') then
                        IF (modulo_count = Fin) then
                            modulo_count <= 0;
                            s_count <= s_count + 1;
                            -- handle overflows
                            IF (s_count = 60) THEN
                                s_count <= 0;
                                m_count <= m_count + 1;
                            END IF;
                            IF (m_count = 60) THEN
                                m_count <= 0;
                                h_count <= h_count + 1;
                            END IF;
                            IF (h_count = 24) THEN
                                h_count <= 0;
                            END IF;
                        else
                            modulo_count <= modulo_count + 1;
                        end if;
                    end if;
                
            END IF;
        
        -- reset
        else
            modulo_count <= 0;
            h_count <= 0;
            m_count <= 0;
            s_count <= 0;
        end if;

    END PROCESS;

    Hours <= std_logic_vector(to_signed(h_count, 5));
    Minutes <= std_logic_vector(to_signed(m_count, 6));
    Seconds <= std_logic_vector(to_signed(s_count, 6));
END behavioral;
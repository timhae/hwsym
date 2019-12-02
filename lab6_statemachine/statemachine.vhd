LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY StateMachine IS
    PORT (
        Clk       : IN  STD_LOGIC;
        Reset     : IN  STD_LOGIC;
        PB_Left   : IN  STD_LOGIC;
        PB_Right  : IN  STD_LOGIC;
        PB_Center : IN  STD_LOGIC;
        RW        : OUT STD_LOGIC;
        Condition : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END StateMachine;

ARCHITECTURE Behavioral OF StateMachine IS

    TYPE state_type IS (read, write_h, write_m, write_s);
    SIGNAL state, next_state : state_type;

BEGIN

    SYNC_PROC : PROCESS (Clk)
    BEGIN
        IF (Clk'event AND Clk = '1') THEN
            IF (Reset = '1') THEN
                state <= read;
            ELSE
                state <= next_state;
                -- assign other outputs to internal signals
            END IF;
        END IF;
    END PROCESS;

    OUTPUT_DECODE : PROCESS (state)
    BEGIN
        --insert statements to decode internal output signals
        --below is simple example
        IF state = read THEN
            RW <= '0';
        ELSE
            RW <= '1';
        END IF;

        IF state = write_h THEN
            Condition <= "00";
        ELSIF state = write_m THEN
            Condition <= "01";
        ELSIF state = write_s THEN
            Condition <= "10";
        ELSE
            Condition <= "11";
        END IF;
    END PROCESS;

    NEXT_STATE_DECODE : PROCESS (state, PB_Left, PB_Right, PB_Center)
    BEGIN
        --declare default state for next_state to avoid latches
        next_state <= state; --default is to stay in current state
        --insert statements to decode next_state
        --below is a simple example
        CASE (state) IS
            WHEN read =>
                IF PB_center = '1' THEN
                    next_state <= write_h;
                END IF;

            WHEN write_h =>
                IF PB_right = '1' THEN
                    next_state <= write_m;
                ELSIF PB_left = '1' THEN
                    next_state <= write_s;
                END IF;

                IF PB_center = '1' THEN
                    next_state <= read;
                END IF;

            WHEN write_m =>
                IF PB_right = '1' THEN
                    next_state <= write_s;
                ELSIF PB_left = '1' THEN
                    next_state <= write_h;
                END IF;

                IF PB_center = '1' THEN
                    next_state <= read;
                END IF;

            WHEN write_s =>
                IF PB_right = '1' THEN
                    next_state <= write_h;
                ELSIF PB_left = '1' THEN
                    next_state <= write_m;
                END IF;

                IF PB_center = '1' THEN
                    next_state <= read;
                END IF;

        END CASE;
    END PROCESS;

END Behavioral;
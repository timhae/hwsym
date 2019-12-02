LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Debouncer_tb IS
END Debouncer_tb;

ARCHITECTURE Behavioral OF Debouncer_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT Debouncer IS
        PORT (
            clk       : IN  STD_LOGIC;
            Button    : IN  STD_LOGIC;
            debounced : OUT STD_LOGIC
        );
    END COMPONENT;

    --Inputs
    SIGNAL Clk          : STD_LOGIC := '0';
    SIGNAL Button       : STD_LOGIC := '0';

    --Outputs
    SIGNAL Debounced    : STD_LOGIC := '0';
    -- Clock period definitions
    CONSTANT clk_period : TIME      := 5 ns; -- 100MHz (PIN Y9 on the Zedboard)

BEGIN

    --Instantiate the Unit Under Test (UUT)
    uut : debouncer PORT MAP
        (clk, Button, Debounced);

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        Clk <= '1';
        WAIT FOR clk_period/2;
        Clk <= '0';
        WAIT FOR clk_period/2;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 2 * clk_period;
        Button <= '1';
        WAIT FOR 2 * clk_period;
        Button <= '0';
        WAIT FOR 4 * clk_period;
        Button <= '1';
        WAIT FOR 11 * clk_period;
        Button <= '0';
        WAIT FOR 4 * clk_period;
        Button <= '1';
        WAIT FOR 14 * clk_period;
        Button <= '0';
        WAIT FOR 4 * clk_period;
        Button <= '1';
        WAIT FOR 42 * clk_period;
        Button <= '0';
        WAIT;
    END PROCESS;
END;
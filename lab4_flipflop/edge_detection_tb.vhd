LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EdgeDetector_tb IS
END EdgeDetector_tb;

ARCHITECTURE behavior OF EdgeDetector_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT EdgeDetector
        PORT (
            Clk         : IN  STD_LOGIC;
            InputSignal : IN  STD_LOGIC;
            Edge        : OUT STD_LOGIC
        );
    END COMPONENT;
    --Inputs
    SIGNAL Clk          : STD_LOGIC := '0';
    SIGNAL Input        : STD_LOGIC := '0';

    --Outputs
    SIGNAL Output       : STD_LOGIC;

    -- Clock period definitions
    CONSTANT clk_period : TIME := 20 ns; -- 50MHz

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : EdgeDetector PORT MAP(
        Clk         => Clk,
        InputSignal => Input,
        Edge        => Output
    );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        Clk <= '1';
        WAIT FOR clk_period/2;
        Clk <= '0';
        WAIT FOR clk_period/2;
    END PROCESS;
    -- Stimulus process
    stim_proc : PROCESS
    BEGIN

        Input <= '0';
        WAIT FOR 200 ns;
        Input <= '1';
        WAIT FOR 200 ns;
        Input <= '0';
        WAIT FOR 200 ns;
        Input <= '1';
        WAIT FOR 200 ns;
        Input <= '0';
        WAIT;

    END PROCESS;
END;
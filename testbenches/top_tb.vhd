LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Top_tb IS
END Top_tb;

ARCHITECTURE Behavioral OF Top_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT Top
        PORT (
            Clk       : IN  STD_LOGIC;
            Reset     : IN  STD_LOGIC;
            PB_Left   : IN  STD_LOGIC;
            PB_Right  : IN  STD_LOGIC;
            PB_Up     : IN  STD_LOGIC;
            PB_Down   : IN  STD_LOGIC;
            PB_Center : IN  STD_LOGIC;
            --SW : in STD_LOGIC_VECTOR (1 downto 0);
            --Leds : out STD_LOGIC_VECTOR (7 downto 0)
            Digits    : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
            Segments  : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
    END COMPONENT;

    --Inputs
    SIGNAL Clk          : STD_LOGIC := '0';
    SIGNAL Reset        : STD_LOGIC := '0';
    SIGNAL PB_Left      : STD_LOGIC := '0';
    SIGNAL PB_Right     : STD_LOGIC := '0';
    SIGNAL PB_Up        : STD_LOGIC := '0';
    SIGNAL PB_Down      : STD_LOGIC := '0';
    SIGNAL PB_Center    : STD_LOGIC := '0';
    SIGNAL SW           : STD_LOGIC_VECTOR (1 DOWNTO 0);

    --Outputs
    SIGNAL Segments     : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL Digits       : STD_LOGIC_VECTOR (5 DOWNTO 0);
    --signal Leds : STD_LOGIC_VECTOR (7 downto 0);

    -- Clock period definitions
    CONSTANT clk_period : TIME := 10 ns; -- 100MHz (PIN Y9 on the Zedboard)

BEGIN

    --Instantiate the Unit Under Test (UUT)
    uut : Top PORT MAP(
        Clk       => Clk,
        Reset     => Reset,
        PB_Left   => PB_Left,
        PB_Right  => PB_Right,
        PB_Up     => PB_Up,
        PB_Down   => PB_Down,
        PB_Center => PB_Center,
        --Leds => Leds,
        --SW => SW
        Digits    => Digits,
        Segments  => Segments
    );

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
        WAIT FOR clk_period;
        Reset <= '0';
        SW    <= "00";
        WAIT FOR (1ms - clk_period);

        PB_Center <= '1';
        WAIT FOR 500 us;
        PB_Center <= '0';
        WAIT FOR 150 us;
        PB_Center <= '1';
        WAIT FOR 250 us;
        PB_Center <= '0';
        WAIT FOR 200 us;
        PB_Center <= '1';

        WAIT FOR 3 ms;
        PB_Center <= '0';
        WAIT FOR 200 us;
        PB_Center <= '1';
        WAIT FOR 500 us;
        PB_Center <= '0';
        WAIT FOR 150 us;
        PB_Center <= '1';
        WAIT FOR 250 us;
        PB_Center <= '0';

        WAIT FOR 5 ms;
        PB_Center <= '1';
        WAIT FOR 500 us;
        PB_Center <= '0';
        WAIT FOR 150 us;
        PB_Center <= '1';
        WAIT FOR 250 us;
        PB_Center <= '0';
        WAIT FOR 200 us;
        PB_Center <= '1';

        WAIT FOR 3 ms;
        PB_Center <= '0';
        WAIT FOR 200 us;
        PB_Center <= '1';
        WAIT FOR 500 us;
        PB_Center <= '0';
        WAIT FOR 150 us;
        PB_Center <= '1';
        WAIT FOR 250 us;
        PB_Center <= '0';

        WAIT;
    END PROCESS;

END;
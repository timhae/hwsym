library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_tb is
end Top_tb;

architecture Behavioral of Top_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    
    Component Top
    Port(
       Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       PB_Left : in STD_LOGIC;
       PB_Right : in STD_LOGIC;
       PB_Up : in STD_LOGIC;
       PB_Down : in STD_LOGIC;
       PB_Center : in STD_LOGIC;
       --SW : in STD_LOGIC_VECTOR (1 downto 0);
       --Leds : out STD_LOGIC_VECTOR (7 downto 0)
       Digits : out STD_LOGIC_VECTOR (5 downto 0);
       Segments : out STD_LOGIC_VECTOR (6 downto 0)
       );
    End Component;
    
    --Inputs
    signal Clk : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal PB_Left : STD_LOGIC := '0';
    signal PB_Right : STD_LOGIC := '0';
    signal PB_Up : STD_LOGIC := '0';
    signal PB_Down : STD_LOGIC := '0';
    signal PB_Center : STD_LOGIC := '0';
    signal SW : STD_LOGIC_VECTOR (1 downto 0);
    
    --Outputs
    signal Segments : STD_LOGIC_VECTOR (6 downto 0);
    --signal Leds : STD_LOGIC_VECTOR (7 downto 0);
    
   -- Clock period definitions
    constant clk_period : time := 10 ns;    -- 100MHz (PIN Y9 on the Zedboard)
    
begin

    --Instantiate the Unit Under Test (UUT)
    uut: Top Port Map (
        Clk => Clk,
        Reset => Reset,
        PB_Left => PB_Left,
        PB_Right => PB_Right,
        PB_Up => PB_Up,
        PB_Down => PB_Down,
        PB_Center => PB_Center,
        --Leds => Leds,
        --SW => SW
        Digits => Digits,
        Segments => Segments
    );
    
    -- Clock process definitions
    clk_process :process
    begin
        Clk <= '1';
        wait for clk_period/2;
        Clk <= '0';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        wait for clk_period;
        Reset <= '0';
        SW <= "00";
        wait for (1ms - clk_period);
         
        PB_Center <= '1';
        wait for 500 us;
        PB_Center <= '0';
        wait for 150 us;
        PB_Center <= '1';
        wait for 250 us;
        PB_Center <= '0';
        wait for 200 us;
        PB_Center <= '1';
        
        wait for 3 ms;
        PB_Center <= '0';
        wait for 200 us;
        PB_Center <= '1';
        wait for 500 us;
        PB_Center <= '0';
        wait for 150 us;
        PB_Center <= '1';
        wait for 250 us;
        PB_Center <= '0';
        
        wait for 5 ms;
        PB_Center <= '1';
        wait for 500 us;
        PB_Center <= '0';
        wait for 150 us;
        PB_Center <= '1';
        wait for 250 us;
        PB_Center <= '0';
        wait for 200 us;
        PB_Center <= '1';
        
        wait for 3 ms;
        PB_Center <= '0';
        wait for 200 us;
        PB_Center <= '1';
        wait for 500 us;
        PB_Center <= '0';
        wait for 150 us;
        PB_Center <= '1';
        wait for 250 us;
        PB_Center <= '0';
        
        wait;
    end process;

end;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counters_tb is
end counters_tb;

architecture Behavioral of counters_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    
    Component counters
    Port(
       Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       Up : in STD_LOGIC;
       Down : in STD_LOGIC;
       RW : in STD_LOGIC;
       Condition : in STD_LOGIC_VECTOR (1 downto 0);
       Hours : out STD_LOGIC_VECTOR (4 downto 0);
       Minutes : out STD_LOGIC_VECTOR (5 downto 0);
       Seconds : out STD_LOGIC_VECTOR (5 downto 0)
       );
    End Component;
    
    --Inputs
    signal Clk : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal Up : STD_LOGIC := '0';
    signal Down : STD_LOGIC := '0';
    signal RW : STD_LOGIC := '0';
    signal Condition : STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');
    
    --Outputs
    signal Hours : STD_LOGIC_VECTOR (4 downto 0) := (others=>'0');
    signal Minutes : STD_LOGIC_VECTOR (5 downto 0) := (others=>'0');
    signal Seconds : STD_LOGIC_VECTOR (5 downto 0) := (others=>'0');
    
   -- Clock period definitions
    constant clk_period : time := 5 ns;    -- 100MHz (PIN Y9 on the Zedboard)
    
begin

    --Instantiate the Unit Under Test (UUT)
    uut: Counters Port Map (
        Clk => Clk,
        Reset => Reset,
        Up => Up,
        Down => Down,
        RW => RW,
        Condition => Condition,
        Hours => Hours,
        Minutes => Minutes,
        Seconds => Seconds
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
        wait for 2*clk_period;
        Reset <= '0';

        wait for clk_period;
        Reset <= '1';
        wait for clk_period;
        Reset <= '0';
        wait for clk_period;
        
        wait for 900 ns;
        RW <= '1';
        Condition <= "01";
        wait for 10*clk_period;
        Up <= '1';
        wait for clk_period;
        Up <= '0';
        wait for clk_period;
        Up <= '1';
        wait for clk_period;
        Up <= '0';
        wait for clk_period;
        
        RW <='0';
        Condition <= "00";
        
        wait for 100 ns;
        RW <= '1';
        Condition <= "10";
        wait for clk_period;
        Down <= '1';
        wait for clk_period;
        Down <= '0';
        
        wait for 5*clk_period;
        RW <= '0';
        Condition <= "00";

        wait for 5*clk_period;
        RW <= '1';
        Down <= '1';
        wait for clk_period;
        Down <= '0';
        RW <= '0';

        wait for 5*clk_period;
        RW <= '1';
        Up <= '1';
        wait for clk_period/2;
        Up <= '0';
        Condition <= "01";
        Down <= '1';
        wait for 3*clk_period;
        Down <= '0';
        Condition <= "00";
        RW <= '0';

        wait;
    end process;
end;
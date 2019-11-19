library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer_tb is
end Debouncer_tb;

architecture Behavioral of Debouncer_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    
    Component Debouncer is
    Port (clk : in STD_LOGIC;
              Button : in STD_LOGIC;
              debounced : out STD_LOGIC
              );
    End Component;
    
    --Inputs
    signal Clk : STD_LOGIC := '0';
    signal Button : STD_LOGIC := '0';
    
    --Outputs
    signal Debounced : STD_LOGIC := '0';
   -- Clock period definitions
    constant clk_period : time := 5 ns;    -- 100MHz (PIN Y9 on the Zedboard)
    
begin

    --Instantiate the Unit Under Test (UUT)
    uut: debouncer Port map
     (clk, Button, Debounced);
     
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
        wait for 2 * clk_period;
        Button <= '1';
        wait for 2 * clk_period;
        Button <= '0';
        wait for 4 * clk_period;
        Button <= '1';
        wait for 11 * clk_period;
        Button <= '0';
        wait for 4 * clk_period;
        Button <= '1';
        wait for 14 * clk_period;
        Button <= '0';
        wait for 4 * clk_period;
        Button <= '1';
        wait for 42 * clk_period;
        Button <= '0';
        wait;
    end process;
end;

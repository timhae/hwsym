library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Statemachine_tb is
end Statemachine_tb;

architecture Behavioral of Statemachine_tb is
component StateMachine is
    port (
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		PB_Left : in STD_LOGIC;
		PB_Right : in STD_LOGIC;
		PB_Center : in STD_LOGIC;
		RW : out STD_LOGIC;
		Condition : out STD_LOGIC_VECTOR(1 downto 0)
	);
end component;

signal clock, res, left, right, center, readwrite : std_logic := '0';
constant clk_period : time := 5 ns;
signal cond : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
begin
    state_machine : StateMachine
    Port map(Clk => clock, Reset => res, PB_Left => left, PB_Right => right, PB_Center => center, RW => readwrite, Condition => cond);
    
    clk_process :process
        begin
            Clock <= '1';
            wait for clk_period/2;
            Clock <= '0';
            wait for clk_period/2;
        end process;
        
    stim_process :process
    begin
         wait for 2 * clk_period;
         -- activate write mode
         center <= '1';
         wait for 1 * clk_period;
         center <= '0';
         -- count up
         right <= '1';
         wait for 2 * clk_period;
         right <= '0';
         wait for 2 * clk_period;
         right <= '1';
         wait for 2 * clk_period;
         right <= '0';
         -- count down
         left <= '1';
         wait for 2 * clk_period;
         left <= '0';
         wait for 2 * clk_period;
         left <= '1';
         wait for 2 * clk_period;
         -- activate read mode
         center <= '1';
         left <= '0';
         wait for 1 * clk_period;
         center <= '0';
         wait for 3 * clk_period;
         -- should not react because in read mode
         right <= '1';
         wait for 2 * clk_period;
         right <= '0';
         
         wait;
    end process;                        

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Debouncer is
    generic (delay : positive := 2;
             threshold : positive := 5);
    
    
    Port (clk : in STD_LOGIC;
          Button : in STD_LOGIC;
          debounced : out STD_LOGIC
          );
end Debouncer;

architecture Behavioral of debouncer is
component EdgeDetector is
Port (Clk : in STD_LOGIC;
          InputSignal : in STD_LOGIC;
          Edge : out STD_LOGIC
          );
end component;

begin
       
end Behavioral;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity Top is 
    Port ( Clk : in STD_LOGIC; 
           Reset : in STD_LOGIC; 
           PB_Left : in STD_LOGIC; 
           PB_Right : in STD_LOGIC; 
           PB_Up : in STD_LOGIC; 
           PB_Down : in STD_LOGIC; 
           PB_Center : in STD_LOGIC; 
           Digits : out STD_LOGIC_VECTOR (5 downto 0); 
           Segments : out STD_LOGIC_VECTOR (6 downto 0)); 
end Top; 

architecture behavioural of Top is


begin

end architecture;
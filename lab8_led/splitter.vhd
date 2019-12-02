library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Splitter is
    Port ( Counter : in STD_LOGIC_VECTOR (5 downto 0);
           D1 : out STD_LOGIC_VECTOR (3 downto 0);
           D0 : out STD_LOGIC_VECTOR (3 downto 0));
end Splitter;

architecture Behavioral of Splitter is
    constant const_val : unsigned(13 downto 0) := to_unsigned(6553,14); --(2^16)/10 = 6553
    signal valIn_x_const_val    : unsigned(19 downto 0);
begin

    D1(3) <= '0';
    D1(2) <= (Counter(5) and Counter(3)) or (Counter(5) and Counter(4));
    D1(1) <= (not Counter(5) and Counter(4) and Counter(2)) or 
             (not Counter(5) and Counter(4) and Counter(3)) or 
             (Counter(4) and Counter(3) and Counter(2)) or
             (Counter(5) and (not Counter(4)) and (not Counter(3)));
    D1(0) <= (Counter(5) and (not Counter(4)) and (not Counter(3))) or
             (Counter(5) and (not Counter(3) and Counter(1))) or
             (Counter(5) and (not Counter(3)) and Counter(2)) or
             (not Counter(5) and (not Counter(4)) and Counter(3) and Counter(1)) or
             ((not Counter(5)) and (not Counter(4)) and Counter(3) and Counter(2)) or
             ((not Counter(5)) and Counter(3) and Counter(2) and Counter(1)) or
             ((not Counter(5)) and Counter(4) and (not Counter(3)) and (not Counter(2))) or
             (Counter(5) and Counter(4) and Counter(3) and (not Counter(2)));

    D0(3) <= ((not Counter(5)) and (not Counter(4)) and Counter(3) and (not Counter(2)) and (not Counter(1))) or
             ((not Counter(5)) and Counter(4) and (not Counter(3)) and (not Counter(2)) and Counter(1)) or
             ((not Counter(5)) and Counter(4) and Counter(3) and Counter(2) and (not Counter(1))) or
             (Counter(5) and (not Counter(4)) and (not Counter(3)) and Counter(2) and Counter(1)) or
             (Counter(5) and Counter(4) and (not Counter(3)) and (not Counter(2)) and (not Counter(1))) or
             (Counter(5) and Counter(4) and Counter(3) and (not Counter(2)) and Counter(1));
    D0(2) <=  ((not Counter(5)) and (not Counter(4)) and (not Counter(3)) and Counter(2)) or
              ((not Counter(4)) and Counter(3) and Counter(2) and Counter(1)) or
              ((not Counter(5)) and Counter(4) and (not Counter(2)) and (not Counter(1))) or
              ((not Counter(5)) and Counter(4) and Counter(3) and (not Counter(2))) or 
              (Counter(4) and Counter(3) and (not Counter(2)) and (not Counter(1))) or
              (Counter(5) and (not Counter(4)) and Counter(2) and (not Counter(1))) or
              (Counter(5) and (not Counter(4)) and (not Counter(3)) and (not Counter(2)) and Counter(1)) or
              (Counter(5) and Counter(4) and (not Counter(3)) and Counter(2) and Counter(1));
    D0(1) <= ((not Counter(5)) and (not Counter(4)) and (not Counter(3)) and Counter(1)) or
             ((not Counter(5)) and (not Counter(3)) and Counter(2) and Counter(1)) or
             (Counter(5) and (not Counter(4)) and (not Counter(3)) and (not Counter(1))) or
             (Counter(5) and (not Counter(3)) and Counter(2) and (not Counter(1))) or
             (Counter(5) and (not Counter(4)) and Counter(3) and Counter(1)) or
             (Counter(5) and Counter(3) and Counter(2) and Counter(1)) or
             ((not Counter(5)) and (not Counter(4)) and Counter(3) and Counter(2) and (not Counter(1))) or
             ((not Counter(5)) and Counter(4) and (not Counter(3)) and (not Counter(2)) and (not Counter(1))) or
             ((not Counter(5)) and Counter(4) and Counter(3) and (not Counter(2)) and Counter(1)) or
             (Counter(5) and Counter(4) and Counter(3) and (not Counter(2)) and (not Counter(1)));
    D0(0) <= Counter(0);
    
    valIn_x_const_val <= unsigned(Counter) * const_val  + (2**13);
    --div <= std_logic_vector(valIn_x_const_val(19 downto 14));
    
end Behavioral;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Selector is
generic ( period : integer := 100000 );
Port ( Clk : in STD_LOGIC;
Count : out STD_LOGIC_VECTOR (2 downto 0);
Display : out STD_LOGIC_VECTOR (5 downto 0));
end Selector;

ARCHITECTURE behavioural OF Selector IS
signal counter : integer := 0;
signal temp : STD_LOGIC_VECTOR (2 downto 0);
BEGIN
    temp <= Count;
    PROCESS (Clk)
    BEGIN
        if (counter < period) then
            counter <= counter + 1;
        else
            counter <= 0;
            case temp is
            
                Count <= "001" when count = "000";
            end case;
        end if;
    END PROCESS;
END behavioural;
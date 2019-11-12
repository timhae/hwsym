library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Counters is
    Generic (Fin : integer := 100000000;
             Fout : integer := 1);
    Port (Clk : in STD_LOGIC;
          Reset : in STD_LOGIC;
          Up : in STD_LOGIC;
          Down : in STD_LOGIC;
          RW : in STD_LOGIC;
          Condition : in STD_LOGIC_VECTOR (1 downto 0);
          Hours : out STD_LOGIC_VECTOR (4 downto 0);
          Minutes : out STD_LOGIC_VECTOR (5 downto 0);
          Seconds : out STD_LOGIC_VECTOR (5 downto 0)
          );
          
end Counters;

architecture behavioral of counters is

component EdgeDetector is
    port (Clk : in STD_LOGIC;
          InputSignal : in STD_LOGIC;
          Edge : out STD_LOGIC
          );
end component;

signal ticks : integer := 0;
signal Seconds_int : integer := 0;
signal Minutes_int : integer := 0;
signal Hours_int : integer := 0;

begin
    process (Clk) is
    begin
        if rising_edge(Clk) then
            if (Reset = '1')then 
                ticks <= 0;
                Seconds_int <= 0;
                Minutes_int <= 0;
                Hours_int <= 0;
            else
                if (RW = '0') then -- read mode
                    if ticks = Fin then -- one second
                        ticks <= 0;
                        
                        if Seconds_int = 59 then -- one minute
                            Seconds_int <= 0;
            
                            if Minutes_int = 59 then -- one hour
                                Minutes_int <= 0;
                                
                                if Hours_int = 23 then -- one day
                                    Hours_int <= 0;
                                else
                                    Hours_int <= Hours_int + 1;
                                end if;
                            else
                                Minutes_int <= Minutes_int + 1;
                            end if;
                        else
                            Seconds_int <= Seconds_int + 1;
                        end if;
                   else
                       ticks <= ticks + 1;
                   end if;
                else --write mode
                    if (condition = "00") then -- seconds
                        if (up = '1') then
                            Seconds_int <= Seconds_int + 1;
                        elsif (down = '1') then
                            Seconds_int <= Seconds_int - 1;
                        end if;
                    elsif (condition = "01") then -- minutes
                         if (up = '1') then
                            Minutes_int <= Minutes_int + 1;
                        elsif (down = '1') then
                            Minutes_int <= Minutes_int - 1;
                        end if;
                    elsif (condition = "10") then -- hours
                         if (up = '1') then
                            Hours_int <= Hours_int + 1;
                        elsif (down = '1') then
                            Hours_int <= Hours_int - 1;
                        end if;
                    end if;
                end if;
               Seconds <= std_logic_vector(to_signed(Seconds_int, Seconds'length));
               Minutes <= std_logic_vector(to_signed(Minutes_int, Minutes'length));
               Hours <= std_logic_vector(to_signed(Hours_int, Hours'length));
                
          end if;
    end process;
end behavioral;

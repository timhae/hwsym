library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library STD_LOGIC_ARITH;
use STD_LOGIC_ARITH.ALL;

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

signal condition_real : STD_LOGIC_VECTOR (1 downto 0);
signal up_real : STD_LOGIC;
signal down_real : STD_LOGIC;

begin
    edge_detector_component : edge_detector
    port map(Clk <= Clk, InputSignal <= Component, Edge <= component_real);
    
    edge_detector_up : edge_detector
    port map(Clk <= Clk, InputSignal <= Up, Edge <= up_real);
    
    edge_detector_down : edge_detector
    port map(Clk <= Clk, InputSignal <= Down, Edge <= down_real);
    
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
                    if (condition_real = "00") then -- seconds
                        if (up_real = '1') then
                            Seconds_int <= Seconds_int + 1;
                        elsif (down_real = '1') then
                            Seconds_int <= Seconds_int - 1;
                        end if;
                    elsif (condition_real = "01") then -- minutes
                         if (up_real = '1') then
                            Minutes_int <= Minutes_int + 1;
                        elsif (down_real = '1') then
                            Minutes_int <= Minutes_int - 1;
                        end if;
                    elsif (condition_real = "10") then -- hours
                         if (up_real = '1') then
                            Hours_int <= Hours_int + 1;
                        elsif (down_real = '1') then
                            Hours_int <= Hours_int - 1;
                        end if;
                    end if;
                end if;
               Seconds <= conv_std_logic_vector(Seconds_int, Seconds'length);
               Minutes <= conv_std_logic_vector(Minutes_int, Minutes'length);
               Hours <= conv_std_logic_vector(Hours_int, Hours'length);     
                
          end if;
    end process;
end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Debouncer is
    generic (threshold : positive := 10);   
    
    Port (clk : in STD_LOGIC;
          Button : in STD_LOGIC;
          debounced : out STD_LOGIC
          );
end Debouncer;

architecture Behavioral of debouncer is
Component EdgeDetector is
    PORT (
            Clk : IN STD_LOGIC;
            InputSignal : IN STD_LOGIC;
            Edge : OUT STD_LOGIC
        );
end component;

signal counter : integer := 0;
signal Q1, Q2, ena : std_logic := '0';
signal rst : std_logic := '1';
signal fin : std_logic := '0';
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            Q1 <= Button;
        end if;
    end process;
    
    process(clk) is
        begin
            if rising_edge(clk) then
                Q2 <= Q1;
            end if;
    end process;
    
    rst <= Q1 nand Q2;
    
    process(rst, clk) is
    begin
        if rst = '0' then
            if rising_edge(clk) then
                if counter < threshold then
                    counter <= counter + 1;
                else
                    ena <= '1';
                end if;
            end if;        
        else
            ena <= '0';
            counter <= 0;
        end if;
    end process;

    process(clk) is
    begin
        if rising_edge(clk) then
            fin <= ena and Q2;
        end if;
    end process;
    
    detector : EdgeDetector
    Port map(clk, fin, debounced);
               
end Behavioral;


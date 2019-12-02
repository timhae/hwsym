library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Splitter_tb is
end Splitter_tb;

architecture Behavioral of Splitter_tb is

    -- Component Declaration for the Unit Under Tets (UUT)
    
    COMPONENT Splitter
    PORT (
          Counter : in STD_LOGIC_VECTOR (5 downto 0);
          D1 : out STD_LOGIC_VECTOR (3 downto 0);
          D0 : out STD_LOGIC_VECTOR (3 downto 0)
          );
      END COMPONENT;

    signal clk : STD_LOGIC;

    --Inputs
    signal Counter : STD_LOGIC_VECTOR (5 downto 0) := (others=>'0');
    
    --Outputs
    signal D1 : STD_LOGIC_VECTOR (3 downto 0);
    signal D0 : STD_LOGIC_VECTOR (3 downto 0);
     
    -- Clock period definitions
    constant clk_period : time := 10 ns; -- 100MHz

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Splitter PORT MAP (
        Counter => Counter,
        D1 => D1,
        D0 => D0);

    -- Clock process definitions
       clk_process :process
       begin
            clk <= '1';
            wait for clk_period/2;
            clk <= '0';
            wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proce: process
    begin
        wait for clk_period;
        
        for I in 0 to 63 loop
            Counter <= Counter + 1;
            wait for clk_period;
        end loop;
        
        wait;
    end process;

END;

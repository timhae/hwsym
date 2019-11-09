----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2019 11:50:42 AM
-- Design Name: 
-- Module Name: edge_detector - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EdgeDetector is
    Port (Clk : in STD_LOGIC;
          InputSignal : in STD_LOGIC;
          Edge : out STD_LOGIC
          );
end EdgeDetector;

architecture behavioral of EdgeDetector is
component flipflop is
    port(clk, input: IN std_logic;
         output : out std_logic);
end component;

signal Q_1, Q_2 : std_logic;

begin
    ff_1 : flipflop
    port map(clk => Clk, input => InputSignal, output => Q_1);
    
    ff_2 : flipflop
    port map(clk => Clk, input => Q_1, output => Q_2);
    
    Edge <= (Q_1 AND (NOT Q_2));
    
end behavioral; 
    
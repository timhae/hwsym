----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2019 11:35:18 AM
-- Design Name: 
-- Module Name: flipflop - Behavioral
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

entity flipflop is
    port(clk, input, rst : IN std_logic;
         output : out std_logic);
end flipflop;

architecture behavioral_0 of flipflop is
begin
    process (clk)
    begin
        if (clk'event and clk='1') then
            output <= input;
        end if;
    end process;
end behavioral_0;

--architecture behavioral_1 of flipflop is
--begin
--    process (clk, rst)
--    begin
--        if (rst = '0') then
--            if (clk'event and clk='1') then
--                output <= input;
--            end if;
--        else
--            output <= '0';
--        end if;
--     end process;
--end behavioral_1;
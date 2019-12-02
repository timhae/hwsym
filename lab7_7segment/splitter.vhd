library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity splitter is
	port (
		Binary : in std_logic_vector(5 downto 0);
		BCD_0, BCD_1 : out std_logic_vector(3 downto 0)
	);
end splitter;

architecture Behavioral of splitter is
	signal temp_0, temp_1 : unsigned(3 downto 0) := (others => '0');
	signal bin : unsigned(5 downto 0) := unsigned(Binary);
	signal entire : unsigned(13 downto 0);
begin
	process (Binary) is
	begin
		for i in 5 to 0 loop
			entire <= temp_1 & temp_0 & bin;
			entire <= entire sll 1; 
			temp_1 <= entire(13 downto 10);
			temp_0 <= entire(9 downto 6);
			bin <= entire(5 downto 0);
 
			if to_integer(temp_0) > 4 then
				temp_0 <= temp_0 + "0011";
			end if;
 
			if to_integer(temp_1) > 4 then
				temp_1 <= temp_1 + "0011";
			end if;
 
			BCD_0 <= std_logic_vector(temp_0);
			BCD_1 <= std_logic_vector(temp_1);
		end loop;
 
	end process;
end Behavioral;

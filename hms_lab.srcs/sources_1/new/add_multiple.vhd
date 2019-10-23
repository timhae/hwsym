LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY add_multiple IS
	GENERIC (WIDTH : POSITIVE := 8);
	PORT (
		A, B, C : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
		SUM : OUT std_logic_vector(WIDTH DOWNTO 0);
		COUT : OUT std_logic
	);
END add_multiple;
ARCHITECTURE structural OF add_multiple IS
	COMPONENT ripple_adder
		PORT (
            a, b : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
			sum : OUT std_logic_vector(WIDTH - 1 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
	SIGNAL TEMP : std_logic_vector(WIDTH DOWNTO 0);
BEGIN
    TEMP <= (WIDTH => '0', others => '0');
END structural;
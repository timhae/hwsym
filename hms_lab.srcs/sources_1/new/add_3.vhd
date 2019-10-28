LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY add_multiple IS
	GENERIC (WIDTH : POSITIVE := 8);
	PORT (
		A, B, C : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
		SUM : OUT std_logic_vector(WIDTH DOWNTO 0);
		COUT : OUT std_logic(WIDTH DOWNTO 0)
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
	SIGNAL TEMP : std_logic_vector(WIDTH DOWNTO 0) := (others => '0');
	SIGNAL ZERO : std_logic := '0';
BEGIN
		ra : ripple_adder
		MAP PORT(A, B, TEMP(WIDTH - 1 DOWNTO 0), TEMP(WIDTH));

		ra_2 : ripple_adder
		MAP PORT(TEMP, ZERO & C, SUM, COUT);

END structural;

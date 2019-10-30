LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY add_3 IS
	GENERIC (WIDTH : POSITIVE := 8);
	PORT (
		A, B, C : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
		SUM : OUT std_logic_vector(WIDTH DOWNTO 0);
		COUT : OUT std_logic
	);
END add_3;
ARCHITECTURE structural OF add_3 IS
	COMPONENT ripple_adder
		PORT (
			a, b : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
			sum : OUT std_logic_vector(WIDTH - 1 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
	COMPONENT ripple_adder_big
		PORT (
			a, b : IN std_logic_vector(WIDTH DOWNTO 0);
			sum : OUT std_logic_vector(WIDTH DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
	SIGNAL INTER : std_logic_vector(WIDTH - 1 DOWNTO 0);
	SIGNAL CARRY : std_logic := '0';
	SIGNAL INTER_PLUS_CARRY : std_logic_vector(WIDTH DOWNTO 0);
	SIGNAL BIG_C : std_logic_vector(WIDTH DOWNTO 0);
BEGIN
	ra : ripple_adder
	PORT MAP(A, B, INTER, CARRY);
	INTER_PLUS_CARRY <= CARRY & INTER;
	BIG_C <= '0' & C;
	ra_2 : ripple_adder_big
	PORT MAP(BIG_C, INTER_PLUS_CARRY, SUM, COUT);

END structural;

ARCHITECTURE structural_2 OF add_3 IS
	COMPONENT carry_save_adder
		PORT (
			A, B, C : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
			SUM, CARRIES : OUT std_logic_vector(WIDTH - 1 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT ripple_adder_big
		PORT (
			a, b : IN std_logic_vector(WIDTH DOWNTO 0);
			sum : OUT std_logic_vector(WIDTH DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
 
	SIGNAL INTER_1, INTER_2 : std_logic_vector(WIDTH - 1 DOWNTO 0);
	SIGNAL INTER_3, INTER_4 : std_logic_vector(WIDTH DOWNTO 0);
BEGIN
	csa : carry_save_adder
	PORT MAP(A, B, C, INTER_1, INTER_2);
	INTER_3 <= '0' & INTER_1;
	INTER_4 <= '0' & INTER_2;
	ra : ripple_adder_big
	PORT MAP(INTER_3, INTER_4, SUM, COUT);
END structural_2;
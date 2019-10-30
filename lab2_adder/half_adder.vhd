LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY half_adder IS
	PORT (
		A : IN std_logic;
		B : IN std_logic;
		SUM : OUT std_logic;
		CARRY : OUT std_logic
	);
END half_adder;
ARCHITECTURE structural OF half_adder IS
	COMPONENT and2
		PORT (
			in1, in2 : IN std_logic;
			and_out : OUT std_logic
		);
	END COMPONENT;
	COMPONENT xor2
		PORT (
			in1, in2 : IN std_logic;
			xor_out : OUT std_logic
		);
	END COMPONENT;
BEGIN
	AND2U : and2
	PORT MAP(in1 => A, in2 => B, and_out => CARRY);
	XOR2U : xor2
	PORT MAP(in1 => A, in2 => B, xor_out => SUM);
END structural;
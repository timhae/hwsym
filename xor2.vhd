LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY xor2 IS
	PORT (
		in1, in2 : IN std_logic;
		xor_out : OUT std_logic
	);
END xor2;
ARCHITECTURE structural OF xor2 IS
BEGIN
	xor_out <= in1 XOR in2;
END structural;
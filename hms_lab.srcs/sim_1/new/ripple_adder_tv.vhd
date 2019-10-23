LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

LIBRARY xil_defaultlib;
USE xil_defaultlib.ripple_adder;

ENTITY ripple_adder_tb IS
END ripple_adder_tb;

ARCHITECTURE Behavioral OF ripple_adder_tb IS

	CONSTANT WIDTH : INTEGER := 8;

	-- signals
	SIGNAL in1 : std_logic_vector(WIDTH - 1 DOWNTO 0);
	SIGNAL in2 : std_logic_vector(WIDTH - 1 DOWNTO 0);
	SIGNAL sum : std_logic_vector(WIDTH - 1 DOWNTO 0);
	SIGNAL carry : std_logic;

BEGIN

	uut : ENTITY xil_defaultlib.ripple_adder
		GENERIC MAP(WIDTH)
		PORT MAP(
			A => in1,
			B => in2,
			SUM => sum,
			COUT => carry
		);

	stim_proc : PROCESS
	BEGIN

		in1 <= (OTHERS => '0');
		in2 <= (OTHERS => '0');
		WAIT FOR 10 ns;

		in1 <= std_logic_vector(to_unsigned(2, WIDTH));
		in2 <= std_logic_vector(to_unsigned(3, WIDTH));
		WAIT FOR 10 ns;

		in1 <= std_logic_vector(to_unsigned(15, WIDTH));
		in2 <= std_logic_vector(to_unsigned(8, WIDTH));
		WAIT FOR 10 ns;

		in1 <= std_logic_vector(to_unsigned(200, WIDTH));
		in2 <= std_logic_vector(to_unsigned(100, WIDTH));
		WAIT FOR 10 ns;

		in1 <= (OTHERS => '0');
		in2 <= (OTHERS => '0');
		WAIT;

	END PROCESS;
END Behavioral;
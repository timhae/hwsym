LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_leds IS
	PORT (
		A : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- hours
		B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		C : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- minutes
		D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		E : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- seconds
		F : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- time in read, from switches
		State : IN STD_LOGIC; -- read=0/write=1
		Condition : IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- time in write, from state machine
		Leds : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END mux_leds;

ARCHITECTURE structural OF mux_leds IS
BEGIN
	PROCESS (Sel, State, Condition)
	BEGIN
		IF (State = '0') THEN -- read
			CASE Sel IS
				WHEN "00" => Leds <= A & B;
				WHEN "01" => Leds <= C & D;
				WHEN "10" => Leds <= E & F;
				WHEN OTHERS => Leds <= E & F; -- remember that when debugging
			END CASE;
		ELSE -- write
			CASE Condition IS
				WHEN "00" => Leds <= A & B;
				WHEN "01" => Leds <= C & D;
				WHEN "10" => Leds <= E & F;
				WHEN OTHERS => Leds <= E & F; -- remember that when debugging
			END CASE;
		END IF;
	END PROCESS;
END structural;

ARCHITECTURE alternative OF mux_leds IS
BEGIN
	PROCESS (Sel, State, Condition)
		VARIABLE inter : std_logic_vector(1 DOWNTO 0);
	BEGIN
		IF (State = '0') THEN -- read
			inter := Sel;
		ELSIF (State = '1') THEN -- write
			inter := Condition;
		ELSE
			inter := (OTHERS => '0');
		END IF;
		CASE inter IS
			WHEN "00" => Leds <= A & B;
			WHEN "01" => Leds <= C & D;
			WHEN "10" => Leds <= E & F;
			WHEN OTHERS => Leds <= (OTHERS => '0'); -- remember that when debugging. do we actually need that?
		END CASE;
	END PROCESS;
END alternative;
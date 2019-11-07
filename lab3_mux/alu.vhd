LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;
--USE ieee.numeric_bit.ALL;

ENTITY alu IS
	GENERIC (WIDTH : POSITIVE := 8);
	PORT (
		in0, in1 : IN std_logic_vector (WIDTH - 1 DOWNTO 0);
		op_code : IN std_logic_vector (3 DOWNTO 0);
		result : OUT std_logic_vector (WIDTH - 1 DOWNTO 0);
		status : OUT std_logic_vector (3 DOWNTO 0)
	);
END alu;

ARCHITECTURE structural OF alu IS
--	SIGNAL inter : std_logic_vector(WIDTH DOWNTO 0);
	SIGNAL zero : std_logic_vector(WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL unsign0, unsign1 : unsigned(WIDTH - 1 DOWNTO 0);
    SIGNAL int1 : integer;
	SIGNAL ext_in0 : std_logic_vector(WIDTH DOWNTO 0) := (OTHERS => '0');
	SIGNAL ext_in1 : std_logic_vector(WIDTH DOWNTO 0) := (OTHERS => '0');
BEGIN
    unsign0 <= unsigned(in0);
    unsign1 <= unsigned(in1);
    int1 <= to_integer(unsigned(in1));

	WITH op_code SELECT
        result <= in0 + in1 WHEN "0000", -- ADD Output bitwise addition of A and B
									PROCESS -- Has to be process, no clue how to do this without
										BEGIN -- sign valued extensions
											IF in0(0) = '0'
											THEN
												ext_in0 <= '0' & in0(0);
											ELSE
												ext_in0 <= '1' & in0(0);
											END IF;

											IF in1(0) <= '0'
											THEN
												ext_in1 <= '0' & in1(0);
											ELSE
												ext_in1 <= '1' & in1(0);
											END IF;

											status(1) <= (ext_in0 + ext_in1)(0); -- carry bit

											-- overflow calculation
											IF ((in0(0) = '1' AND in1(0) = '1') AND result(0) = '0')
											THEN
												status(0) <= '1';
											ELSE IF ((in0(0) = '0' AND in1(0) = '0') AND result(0) = '1')
												status(0) <= '1';
											ELSE
												status(0) <= '0';
											END IF;
									END PROCESS;

					        in0 - in1 WHEN "0001", -- SUB Output bitwise subtraction of A and B
					        in0 * in1 WHEN "0010", -- MUL Output multiplication of A and B
					        std_logic_vector(unsign0 sll int1) WHEN "0011", -- SLL Output logical shift to A w.r.t. B to the left
					        std_logic_vector(unsign0 srl int1) WHEN "0100", -- SRL Output logical shift to A w.r.t. B to the right
					        in0 - in1 WHEN "0101", -- MOVL Move xx-bit immediate to lower xx-bits of register
					        in0 - in1 WHEN "0110", -- MOVH Move xx-bit immediate to upper xx-bits of register
					        in0 - in1 WHEN "0111", -- AND Output bitwise AND operation on A and B
					        in0 - in1 WHEN "1000", -- OR Output bitwise OR operation on A and B
					        in0 - in1 WHEN "1001", -- XOR Output bitwise XOR operation on A and B
					        in0 - in1 WHEN "1010", -- NOR Output bitwise NOR operation on A and B
					        in0 - in1 WHEN "1011", -- NAND Output bitwise NAND operation on A and B
					        in0 - in1 WHEN "1100", -- XNOR Output bitwise XNOR operation on A and B
					        in0 - in1 WHEN "1101", -- NOT Output NOT operation on A
					        in0 - in1 WHEN "1110", -- JAL Jump to immediate address
					        in0 - in1 WHEN "1111"; -- BEQ Jump when A and B are equal

--status(3) z: bit is set if the result is zero
--status(2) n: bit is set if the result is negative
--status(1) c: is the following bit -> result(WIDTH)
--status(0) v: if a negativ or positiv number has an overflow
	WITH op_code SELECT
        status <= WHEN "0000", -- ADD Output bitwise addition of A and B
        in0 - in1 WHEN "0001", -- SUB Output bitwise subtraction of A and B
        in0 * in1 WHEN "0010", -- MUL Output multiplication of A and B
        std_logic_vector(unsign0 sll int1) WHEN "0011", -- SLL Output logical shift to A w.r.t. B to the left
        std_logic_vector(unsign0 srl int1) WHEN "0100", -- SRL Output logical shift to A w.r.t. B to the right
        in0 - in1 WHEN "0101", -- MOVL Move xx-bit immediate to lower xx-bits of register
        in0 - in1 WHEN "0110", -- MOVH Move xx-bit immediate to upper xx-bits of register
        in0 - in1 WHEN "0111", -- AND Output bitwise AND operation on A and B
        in0 - in1 WHEN "1000", -- OR Output bitwise OR operation on A and B
        in0 - in1 WHEN "1001", -- XOR Output bitwise XOR operation on A and B
        in0 - in1 WHEN "1010", -- NOR Output bitwise NOR operation on A and B
        in0 - in1 WHEN "1011", -- NAND Output bitwise NAND operation on A and B
        in0 - in1 WHEN "1100", -- XNOR Output bitwise XNOR operation on A and B
        in0 - in1 WHEN "1101", -- NOT Output NOT operation on A
        in0 - in1 WHEN "1110", -- JAL Jump to immediate address
        in0 - in1 WHEN "1111"; -- BEQ Jump when A and B are equal

END structural;

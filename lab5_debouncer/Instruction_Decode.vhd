library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Instruction_Decode is
    generic(WIDTH : positive := 8);
    Port(instruction : in std_logic_vector(31 downto 0);
         IF_valid, EX_valid, rd, clk : in std_logic;
         ID_valid : out std_logic;
         opcode : out std_logic_vector(3 downto 0);
         in1, in2 : out std_logic_vector(WIDTH - 1 downto 0)
         );
end Instruction_Decode;

architecture Behavioral of Instruction_Decode is

begin


end Behavioral;

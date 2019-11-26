library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity StateMachine is
	port (
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		PB_Left : in STD_LOGIC;
		PB_Right : in STD_LOGIC;
		PB_Center : in STD_LOGIC;
		RW : out STD_LOGIC;
		Condition : out STD_LOGIC_VECTOR(1 downto 0)
	);
end StateMachine;

architecture Behavioral of StateMachine is

type state_type is (read, write_h, write_m, write_s);
   signal state, next_state : state_type;
       
begin

 SYNC_PROC: process (Clk)
   begin
      if (Clk'event and Clk = '1') then
         if (Reset = '1') then
            state <= read;
         else
            state <= next_state;
         -- assign other outputs to internal signals
         end if;
      end if;
   end process;
   
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      if state = read then
         RW <= '1';
      else
         RW <= '0';
      end if;
      
      if state = read then
        Condition <= "00";
      elsif state = write_h then
        Condition <= "01";
      elsif state = write_m then
        Condition <= "10";
      else
        Condition <= "11";
      end if;
   end process;
   
   NEXT_STATE_DECODE: process (state, PB_Left, PB_Right, PB_Center)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
         when read =>
            if PB_center = '1' then
               next_state <= write_h;
            end if;
            
         when write_h =>
            if PB_right = '1' then
               next_state <= write_m;
            elsif PB_left = '1' then
               next_state <= write_s;
            end if;
            
            if PB_center = '1' then
               next_state <= read;
            end if;
            
         when write_m =>
            if PB_right = '1' then
               next_state <= write_s;
            elsif PB_left = '1' then
               next_state <= write_h;
            end if;
            
            if PB_center = '1' then
               next_state <= read;
            end if;
         
         when write_s =>
            if PB_right = '1' then
               next_state <= write_h;
            elsif PB_left = '1' then
               next_state <= write_m;
            end if;
            
            if PB_center = '1' then
               next_state <= read;
            end if;
            
      end case;
   end process;

end Behavioral;

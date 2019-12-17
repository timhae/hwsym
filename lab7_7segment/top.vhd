LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity Top is 
    Port ( Clk : in STD_LOGIC; 
           Reset : in STD_LOGIC; 
           PB_Left : in STD_LOGIC; 
           PB_Right : in STD_LOGIC; 
           PB_Up : in STD_LOGIC; 
           PB_Down : in STD_LOGIC; 
           PB_Center : in STD_LOGIC; 
           Digits : out STD_LOGIC_VECTOR (5 downto 0); 
           Segments : out STD_LOGIC_VECTOR (6 downto 0)
    ); 
end Top; 

architecture behavioural of Top is

component ila_0 is
PORT (clk : in STD_LOGIC;
    PROBE0 : in STD_LOGIC
    );
end component;
--components
component Debouncer is
--GENERIC (threshold : POSITIVE := 5);
GENERIC (threshold : POSITIVE := 1000000);
PORT (
        clk       : IN  STD_LOGIC;
        Button    : IN  STD_LOGIC;
        debounced : OUT STD_LOGIC
    );
end component;

component Statemachine is
PORT (
        Clk       : IN  STD_LOGIC;
        Reset     : IN  STD_LOGIC;
        PB_Left   : IN  STD_LOGIC;
        PB_Right  : IN  STD_LOGIC;
        PB_Center : IN  STD_LOGIC;
        RW        : OUT STD_LOGIC;
        Condition : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END component;

component Counters is
GENERIC (
--        Fin  : INTEGER := 10; -- should be 1s
        Fin  : INTEGER := 100000000; -- should be 1s
        Fout : INTEGER := 1);
PORT (
        Clk       : IN  STD_LOGIC;
        Reset     : IN  STD_LOGIC;
        Up        : IN  STD_LOGIC;
        Down      : IN  STD_LOGIC;
        RW        : IN  STD_LOGIC;
        Condition : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
        Hours     : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        Minutes   : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        Seconds   : OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
    );
END component;

component Splitter is
PORT (
        Counter : IN  STD_LOGIC_VECTOR (5 DOWNTO 0);
        D1      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        D0      : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END component;

component Mux61 is
PORT (
        A      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        B      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        C      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        D      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        E      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        F      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        Sel    : IN  STD_LOGIC_VECTOR (2 DOWNTO 0);
        Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
end component;

component bcdto7seg is
PORT (
        BCD      : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
        Segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
    );
end component;

component selector is
--GENERIC (delay : INTEGER := 1); -- should be 1ms
GENERIC (delay : INTEGER := 10000); -- should be 1ms
PORT (
        Clk     : IN  STD_LOGIC;
        Count   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Display : OUT STD_LOGIC_VECTOR (5 DOWNTO 0));
end component;

--signals
SIGNAL up, down, center, right, left, state :  STD_LOGIC := '0';
SIGNAL condition : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
SIGNAL select_signal : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
SIGNAL h0, h1, m0, m1, s0, s1, bcd : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
SIGNAL hours, minutes, seconds, display : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
SIGNAL segments_signal : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');

begin
-- port maps
la0: ila_0
port map(clk => clk, probe0 => PB_Center);

la1: ila_0
port map(clk => clk, probe0 => center);

debouncer_0 : debouncer
Port map(clk => clk, button => PB_Up, debounced => up);
debouncer_1 : debouncer
Port map(clk => clk, button => PB_Down, debounced => down);
debouncer_2 : debouncer
Port map(clk => clk, button => PB_Center, debounced => center);
debouncer_3 : debouncer
Port map(clk => clk, button => PB_Right, debounced => right);
debouncer_4 : debouncer
Port map(clk => clk, button => PB_Left, debounced => left);

state_machine : StateMachine
Port Map (clk => clk, reset => reset, PB_left => left, PB_right => right, PB_center => center, RW => state, condition => condition);

time_counters : Counters
Port Map(clk => clk, reset => reset, up => PB_Up, down => PB_down, rw => state, condition => condition, hours => hours, minutes => minutes, seconds => seconds);


splitter_0 : Splitter
Port Map(counter => hours, D1 => h0, D0 => h1);

splitter_1 : Splitter
Port Map(counter => minutes, D1 => m0, D0 => m1);

splitter_2 : Splitter
Port Map(counter => seconds, D1 => s0, D0 => s1);

mux : Mux61
Port Map(A => h0, B => h1, C => m0, D => m1, E => s0, F => s1, Sel => select_signal, Output => bcd);

bcdto7s: bcdto7seg
PORT map(BCD => bcd, Segments => Segments);

sel : selector
port map(Clk => clk, Count => select_signal, Display => Digits);

end architecture;
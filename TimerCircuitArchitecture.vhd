--And gate component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ag is
	port(a, b : in std_logic;
		  c : out std_logic);
end entity ag;

architecture agg of ag is
begin
process(a, b)
begin
	c <= a and b;
end process;
end architecture agg;

--And gate with reverse entry component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity agb is
	port(a, b : in std_logic;
		  c : out std_logic);
end entity;

architecture aggb of agb is
begin
process(a, b)
begin
	c <= (not a) and b;
end process;
end architecture aggb;

--D flip flop component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
	port(d, clk, clear : in std_logic;
		  q : buffer std_logic);
end entity dff;

architecture dfff of dff is
signal info : std_logic;
begin
process(clk, clear)
begin
	if rising_edge(clk) then
		if clear = '1' then
			q <= '0';
		else
			q <= d;
		end if;
	end if;
end process;
end architecture dfff;

--JK flip flop component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jkff is
	port(j, k, clk : in std_logic;
		  q, qb : out std_logic);
end entity jkff;

architecture jkfff of jkff is
begin
process (clk)
variable tmp: std_logic := '0';
begin 
	if rising_edge(clk) then
		if(j = '0' and k = '0') then
			tmp := tmp;
		elsif (j = '0' and k = '1') then
			tmp := '0';
		elsif (j = '1' and k = '0') then
			tmp := '1';
		elsif (j = '1' and k = '1') then
			tmp := not tmp;
		else
			tmp := tmp;
		end if;
	end if;
	q <= tmp;
	qb <= not tmp;
end process;
end architecture jkfff;

--State component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state is
	port(a, b : in std_logic_vector (5 downto 0);
		  clk0 : in std_logic;
		  o : out std_logic);
end entity state;

architecture statee of state is
signal statement_out : std_logic;
begin 
	process(clk0) is
	begin
		if (clk0 = '1') then
			if (a = b) then
				statement_out <= '1';
			else
				statement_out <= '0';
			end if;
		end if;
	end process;
	o <= statement_out;
end architecture statee;

--6 Bit Counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity cout is
	port(clk0, clear : in std_logic;
		  o : out std_logic_vector (5 downto 0));
end entity cout;

architecture coutt of cout is
signal count : std_logic_vector (5 downto 0) := "000000";
begin
	process (clk0, clear)
	begin
		if clear = '0' then
			if rising_edge(clk0) then
				count <= count + 1;
			end if;
		else
			count <= "000000";
		end if;
	end process;
	o <= count;
end architecture coutt;

--6 Bit Register
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity reg is
	port(d : in std_logic_vector (5 downto 0);
		  clk1 : in std_logic;
		  q : out std_logic_vector (5 downto 0));
end entity reg;

architecture regg of reg is
signal data : std_logic_vector (5 downto 0);
begin
	process (clk1) is
	begin
		if rising_edge(clk1) then
			data <= d;
		end if;
	end process;
q <= data;
end architecture regg;

--Choice component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity choice is
	port(s1, s2, clk1 : in std_logic;
		  o : out std_logic_vector (5 downto 0));
end entity choice;

architecture choicee of choice is
signal result : std_logic_vector (5 downto 0) := "000000";
begin 
process (clk1, s1, s2)
begin 
	if clk1 = '1' then
		if (s1 = '0' and s2 = '0') then 
			result <= result;
		elsif (s1 = '1' and s2 = '0') then 
			result <= "011110";
		elsif (s1 = '0' and s2 = '1') then 
			result <= "111100";
		else 
			result <= "000001";
		end if;
	end if;
	o <= result;
end process;
end architecture choicee;

--Top of Bell circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Bell is
	port(sw0, sw1, clk0, clk1, start : in std_logic;
		  time_out : out std_logic_vector (5 downto 0));
end Bell;

architecture Behavioral of Bell is

component reg
	port(d : in std_logic_vector (5 downto 0);
		  clk1 : in std_logic;
		  q : out std_logic_vector (5 downto 0));
end component;

component cout
	port(clk0, clear : in std_logic;
		  o : out std_logic_vector (5 downto 0));
end component;

component state
	port(a, b : in std_logic_vector (5 downto 0);
		  clk0 : in std_logic;
		  o : out std_logic);
end component;

component choice 
	port(s1, s2, clk1 : in std_logic;
		  o : out std_logic_vector (5 downto 0));
end component;

component jkff 
	port(j, k, clk : in std_logic;
		  q, qb : out std_logic);
end component;

component dff 
	port(d, clk, clear : in std_logic;
		  q : buffer std_logic);
end component;

component ag
	port(a, b : in std_logic;
		  c : out std_logic);
end component;

component agb
	port(a, b : in std_logic;
		  c : out std_logic);
end component;

signal U1toU2 : std_logic_vector (5 downto 0);
signal U2toU4 : std_logic_vector (5 downto 0);
signal U3toU4 : std_logic_vector (5 downto 0);
signal U4toU5 : std_logic;
signal clk0i : std_logic;
signal clk1i : std_logic;
signal clear : std_logic;
signal clock_status : std_logic;
signal U5toU6 : std_logic;


begin

u1 : choice port map (s1=>sw0, s2=>sw1, clk1 => clk1, o=>U1toU2);
u2 : reg port map (d=>U1toU2, q=>U2toU4, clk1 => clk1i);
u3 : cout port map (clk0 => clk0i, clear => clear, o => U3toU4);
u4 : state port map (a => U2toU4, b => U3toU4, clk0 => clk0, o => U4toU5);
u5 : jkff port map (j => start, k => U4toU5, clk => clk1, q=>U5toU6, qb => clear);
u6 : dff port map (d => clear, clear => U5toU6, clk => clk1, q => clock_status);
u7 : agb port map (a => clock_status, b => clk0, c => clk0i);
u8 : ag port map (a => clock_status, b => clk1, c=>clk1i);

time_out <= U3toU4;

end Behavioral;

library ieee;
use ieee.std_logic_1164.all;

entity BellTest is
end entity BellTest;

architecture BellTestt of BellTest is
component Bell
	port(sw0, sw1, clk0, clk1, start : in std_logic;
		  time_out : out std_logic_vector (5 downto 0));
end component;

signal clk0 : std_logic := '0';
signal clk1 : std_logic := '0';
signal sw0 : std_logic;
signal sw1 : std_logic;
signal start : std_logic;
signal o : std_logic_vector (5 downto 0);
constant clk_period : time := 1 us;

begin

uut : Bell port map (clk0 => clk0, clk1 => clk1, sw0 => sw0, sw1 => sw1, start => start, time_out => o);

clk1_process : process
begin
	clk1 <= '0';
	wait for clk_period/512;
	clk1 <= '1';
	wait for clk_period/512;
end process;

clk0_process : process
begin
	clk0 <= '0';
	wait for clk_period/2;
	clk0 <= '1';
	wait for clk_period/2;
end process;

end architecture BellTestt;
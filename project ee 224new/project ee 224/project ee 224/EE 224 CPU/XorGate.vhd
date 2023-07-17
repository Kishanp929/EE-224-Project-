library ieee;
use ieee.std_logic_1164.all;


entity xorg is
	port ( a,b: in std_logic; c: out std_logic);
end entity;

architecture xora of xorg is

	signal nota, notb, anotb, bnota: std_logic;
	
	component org
		port ( x,y: in std_logic; z: out std_logic);
	end component;
	
	component andg
		port ( x,y: in std_logic; z: out std_logic);
	end component;
		
	component notg
		port ( a: in std_logic; b: out std_logic);
	end component;

begin
	not1 : notg
		port map (a=>a, b=>nota);
		
	not2 : notg
		port map (a=>b, b=>notb);
		
	and1 : andg
		port map (x=>a, y=>notb, z=>anotb);
		
	and2 : andg
		port map (x=>nota, y=>b, z=>bnota);
	
	or1 : org
		port map (x=>anotb, y=>bnota, z=>c);

end architecture;
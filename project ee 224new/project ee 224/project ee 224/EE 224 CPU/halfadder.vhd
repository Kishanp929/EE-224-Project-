library ieee;
use ieee.std_logic_1164.all;


entity halfadder is
	port ( a,b: in std_logic; s,c: out std_logic);
end entity;

architecture halfadder_arc of halfadder is
	
	component andg
		port ( x,y: in std_logic; z: out std_logic);
	end component;
	
	component xorg
		port ( a,b: in std_logic; c: out std_logic);
	end component;

begin

	xor1 : xorg
		port map (a=>a, b=>b, c=>s);
		
	and1 : andg
		port map (x=>a, y=>b, z=>c);
		
end architecture;
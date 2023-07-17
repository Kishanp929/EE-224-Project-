library ieee;
use ieee.std_logic_1164.all;


entity Full_Adder is
	port ( a, b, cin : in std_logic;
			sum, cout: out std_logic); 
end entity;

architecture OnebitFullAdd_arc of Full_Adder is

	signal s1,c1,c2: std_logic;
	
	component org
		port ( x,y: in std_logic; z: out std_logic);
	end component;
	
	component halfadder
		port ( a,b: in std_logic; s,c: out std_logic);
	end component;
		

begin
	halfadder1 : halfadder
		port map (a=>a, b=>b, s=>s1, c=>c1);
		
	halfadder2 : halfadder
		port map (a=>s1, b=>cin, s=>sum, c=>c2);
	
	or1 : org
		port map (x=>c1, y=>c2, z=>cout);

end architecture;
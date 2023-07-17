library ieee;
use ieee.std_logic_1164.all;

entity Add16 is 
port( inp1 : in std_logic_vector(15 downto 0);
      inp2 : in std_logic_vector(15 downto 0);
		sum : out std_logic_vector(15 downto 0);
    cout : out std_logic);
end entity Add16;

architecture desc of Add16 is

component Full_Adder  is
  port ( a, b, cin : in std_logic;
			sum, cout: out std_logic);
end component Full_Adder;

signal c : std_logic_vector(15 downto 0);

begin

a1: Full_Adder
port map(inp1(0),inp2(0),'0',sum(0),c(0));
a2: Full_Adder
port map(inp1(1),inp2(1),c(0),sum(1),c(1));
a3: Full_Adder
port map(inp1(2),inp2(2),c(1),sum(2),c(2));
a4: Full_Adder
port map(inp1(3),inp2(3),c(2),sum(3),c(3));
a5: Full_Adder
port map(inp1(4),inp2(4),c(3),sum(4),c(4));
a6: Full_Adder
port map(inp1(5),inp2(5),c(4),sum(5),c(5));
a7: Full_Adder
port map(inp1(6),inp2(6),c(5),sum(6),c(6));
a8: Full_Adder
port map(inp1(7),inp2(7),c(6),sum(7),c(7));
a9: Full_Adder
port map(inp1(8),inp2(8),c(7),sum(8),c(8));
a10: Full_Adder
port map(inp1(9),inp2(9),c(8),sum(9),c(9));
a11: Full_Adder
port map(inp1(10),inp2(10),c(9),sum(10),c(10));
a12: Full_Adder
port map(inp1(11),inp2(11),c(10),sum(11),c(11));
a13: Full_Adder
port map(inp1(12),inp2(12),c(11),sum(12),c(12));
a14: Full_Adder
port map(inp1(13),inp2(13),c(12),sum(13),c(13));
a15: Full_Adder
port map(inp1(14),inp2(14),c(13),sum(14),c(14));
a16: Full_Adder
port map(inp1(15),inp2(15),c(14),sum(15),c(15));

cout <= c(15);

end architecture;

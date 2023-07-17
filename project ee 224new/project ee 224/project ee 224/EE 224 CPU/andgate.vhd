library ieee;
use ieee.std_logic_1164.all;

entity andg is
	port ( x,y: in std_logic; z: out std_logic);
end entity;

architecture anda of andg is
begin
	z <= x and y;
end architecture;
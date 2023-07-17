library ieee;
use ieee.std_logic_1164.all;

entity org is
	port ( x,y: in std_logic; z: out std_logic);
end entity;

architecture ora of org is
begin
	z <= x or y;
end architecture;
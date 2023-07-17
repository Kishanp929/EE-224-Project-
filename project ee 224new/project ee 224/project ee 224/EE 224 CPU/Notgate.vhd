library ieee;
use ieee.std_logic_1164.all;

entity notg is
	port ( a: in std_logic; b: out std_logic); 
end entity;

architecture nota of notg is
begin
	b <= not a;
end architecture;
library ieee;
use ieee.std_logic_1164.all;

entity LeftShift1 is 
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end entity LeftShift1;

architecture desc of LeftShift1 is 
begin
op(0) <= '0';
op(15 downto 1) <= inp(14 downto 0);
end architecture;
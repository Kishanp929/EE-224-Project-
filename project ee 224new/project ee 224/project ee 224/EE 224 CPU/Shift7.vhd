library ieee;
use ieee.std_logic_1164.all;

entity LeftShift7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end entity LeftShift7;

architecture desc of LeftShift7 is
begin
op(6 downto 0) <= "0000000";
op(15 downto 7) <= inp(8 downto 0);
end architecture;


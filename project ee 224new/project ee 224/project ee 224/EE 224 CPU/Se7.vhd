library ieee;
use ieee.std_logic_1164.all;

entity se7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end entity se7;

architecture desc of se7 is
begin
op(8 downto 0) <= inp(8 downto 0);
op(9) <= '0';
op(10) <= '0';
op(11) <= '0';
op(12) <= '0';
op(13) <= '0';
op(14) <= '0';
op(15) <= '0';
end architecture;
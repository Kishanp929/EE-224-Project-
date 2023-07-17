library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port(inp : in std_logic_vector(15 downto 0);
       clk : in std_logic;
       op  : out std_logic_vector(15 downto 0));
end entity reg;

architecture desc of reg is
begin
process(clk)
begin
if rising_edge(clk) then
  op <= inp;
end if;
end process;
end architecture;

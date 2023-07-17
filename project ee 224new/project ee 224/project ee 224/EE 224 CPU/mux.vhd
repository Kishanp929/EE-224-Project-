library ieee;
use ieee.std_logic_1164.all;

entity mux is
  port( inp0 : in std_logic_vector(15 downto 0);
        inp1 : in std_logic_vector(15 downto 0);
		  inp2 : in std_logic_vector(15 downto 0);
		  inp3 : in std_logic_vector(15 downto 0);
		  inp4 : in std_logic_vector(15 downto 0);
		  inp5 : in std_logic_vector(15 downto 0);
		  inp6 : in std_logic_vector(15 downto 0);
		  inp7 : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(2 DOWNTO 0);
        op: out std_logic_vector(15 downto 0));
end entity mux;

architecture desc of mux is
begin

process(inp0,inp1,inp2,inp3,inp4,inp5,inp6,inp7,sel)
begin
  if sel="000" then
  op <= inp0;
  elsif sel="001" then
  op <= inp1;
  elsif sel="010" then
  op <= inp2;
  elsif sel="011" then
  op <= inp3;
  elsif sel="100" then
  op <= inp4;
  elsif sel="101" then
  op <= inp5;
  elsif sel="110" then
  op <= inp6;
  elsif sel="111" then
  op <= inp7;
  end if;
end process;
end architecture;
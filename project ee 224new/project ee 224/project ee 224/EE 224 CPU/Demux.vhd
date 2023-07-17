library ieee;
use ieee.std_logic_1164.all;

entity demux is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(2 DOWNTO 0);
        out0: out std_logic_vector(15 downto 0); 
		  out1: out std_logic_vector(15 downto 0); 
		  out2: out std_logic_vector(15 downto 0);
        out3: out std_logic_vector(15 downto 0);
		  out4: out std_logic_vector(15 downto 0);
		  out5: out std_logic_vector(15 downto 0);
		  out6: out std_logic_vector(15 downto 0);
		  out7: out std_logic_vector(15 downto 0));
end entity demux;

architecture desc of demux is
begin

process(inp,sel)
begin
  if sel="000" then
  out0 <= inp;
  elsif sel="001" then
  out1 <= inp;
  elsif sel="010" then
  out2 <= inp;
  elsif sel="011" then
  out3 <= inp;
  elsif sel="100" then
  out4 <= inp;
  elsif sel="101" then
  out5 <= inp;
  elsif sel="110" then
  out6 <= inp;
  elsif sel="111" then
  out7 <= inp;
  end if;
end process;
end architecture;
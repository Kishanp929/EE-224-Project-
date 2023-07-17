library ieee;
use ieee.std_logic_1164.all; 

entity mux_2x1 is
  port (w0, w1 : in std_logic_vector(15 downto 0);
        s : in std_logic;
     f : out std_logic_vector(15 downto 0)); 
end mux_2x1;

architecture behaviour of mux_2x1 is 
begin
process(w0,w1,s)
begin
if s ='0' then
  f <=w0;
  else 
  f<=w1;
 end if;
 end process;
end behaviour;

library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
port ( inp0: in std_logic_vector(15 downto 0);
          inp1: in std_logic_vector(15 downto 0);
			 inp2: in std_logic_vector(15 downto 0);
			 inp3: in std_logic_vector(15 downto 0);
          sel: in std_logic_vector(1 downto 0);
			 op: out std_logic_vector(15 downto 0));
end entity;

architecture desc of mux_4x1 is
begin
process(inp0,inp1,inp2,inp3,sel)
begin
  if sel="00" then
  op <= inp0;
  elsif sel ="01" then
  op <=inp1;
    elsif sel ="10" then
  op <=inp2;
    elsif sel ="11" then
  op <=inp3;
 end if;
end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity demux_1x2 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic;
        out0: out std_logic_vector(15 downto 0); 
		  out1: out std_logic_vector(15 downto 0));
end entity demux_1x2;

architecture desc of demux_1x2 is
begin

process(inp,sel)
begin
  if sel='0' then
  out0 <= inp;
  else
  out1 <= inp;
  end if;
end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity demux_1x4 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(1 downto 0);
        out0: out std_logic_vector(15 downto 0);
		  out1: out std_logic_vector(15 downto 0); 
		  out2: out std_logic_vector(15 downto 0);  
		  out3: out std_logic_vector(15 downto 0));
end entity demux_1x4;

architecture desc of demux_1x4 is
begin

process(inp,sel)
begin
  if sel="00" then
  out0 <= inp;
  elsif sel="01" then
  out1 <= inp;
  elsif sel="10" then
  out2 <= inp;
  elsif sel="11" then
  out3 <= inp;
  end if;
end process;
end architecture;
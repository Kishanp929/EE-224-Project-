library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
port (mem_d : in std_logic_vector(15 downto 0);
      mem_a : in std_logic_vector(15 downto 0);
		rd_bar: in std_logic;
		wr_bar: in std_logic;
		clk : in std_logic;
		mem_out : out std_logic_vector(15 downto 0));
end entity mem;

architecture desc of mem is
type memarr is array(0 to 31) of std_logic_vector(15 downto 0);
signal RAM : memarr := ("1001011010000000","0001011000000010","0000001010011000","0010001010111000","0010001010100010",X"0001",X"FFFF",X"FFFF",others => X"F000");
signal addr : std_logic_vector(4 downto 0);

begin
addr <= mem_a(4 downto 0);

process(rd_bar,wr_bar,clk,addr)
begin
  if rd_bar = '0' then
  mem_out <= RAM(to_integer(unsigned(addr)));
  elsif rising_edge(clk) then
    if wr_bar ='0' then
	 RAM(to_integer(unsigned(addr))) <= mem_d;
	 mem_out <= (others => '0');
	 end if;
  end if;
end process;
end architecture;

-- 
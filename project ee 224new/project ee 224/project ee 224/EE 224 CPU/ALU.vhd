library ieee;
use ieee.std_logic_1164.all;

entity ALU is
port( alu_a : in std_logic_vector(15 downto 0);
      alu_b : in std_logic_vector(15 downto 0);
		ctrl : in std_logic_vector(1 downto 0);
		alu_out : out std_logic_vector(15 downto 0);
		c_out : out std_logic_vector(15 downto 0);
		z_out : out std_logic_vector(15 downto 0));
end entity ALU;

architecture desc of ALU is

component Add16 is 
port( inp1 : in std_logic_vector(15 downto 0);
      inp2 : in std_logic_vector(15 downto 0);
		sum : out std_logic_vector(15 downto 0);
		cout : out std_logic);
end component Add16;

signal t: std_logic_vector(15 downto 0);
signal carry : std_logic;

begin
	add1: Add16
	port map(alu_a,alu_b, t,carry);

	process(alu_a,alu_b,ctrl)
		begin
			if ctrl = "00" then
				alu_out <= t;
				c_out(0) <= carry;
				c_out(15 downto 1) <= "000000000000000";
				if(alu_a = "0000000000000000" and alu_b = "0000000000000000") then
					z_out <= "0000000000000001";
				else
					z_out <= "0000000000000000";
				end if;

			elsif ctrl = "01" then
				alu_out <= (alu_a nand alu_b);
				if(alu_a = "1111111111111111" and alu_b = "1111111111111111") then
					z_out <= "0000000000000001";
				else
					z_out <= "0000000000000000";
				end if;
				
			elsif ctrl = "10" then
				alu_out <= (alu_a xor alu_b);
				if(alu_a = alu_b) then
					z_out <= "0000000000000001";
				else
					z_out <= "0000000000000000";
				end if;
			end if;
	end process;
end architecture;

		
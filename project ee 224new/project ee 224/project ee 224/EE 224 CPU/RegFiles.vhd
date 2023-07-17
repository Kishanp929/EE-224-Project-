library ieee;
use ieee.std_logic_1164.all;

entity rf is
port( a1 : in std_logic_vector(2 downto 0);
      a2 : in std_logic_vector(2 downto 0);
		a3 : in std_logic_vector(2 downto 0);
		d3 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		d1 : out std_logic_vector(15 downto 0);
		d2 : out std_logic_vector(15 downto 0);
		t3_out : out std_logic_vector(15 downto 0));
end entity rf;

architecture desc of rf is
signal s0,s1,s2,s3,s4,s5,s6,s7: std_logic_vector(15 downto 0);
signal t0,t3,t4,t5,t6,t7: std_logic_vector(15 downto 0);
signal t1 : std_logic_vector(15 downto 0) := "0000000000000010";
signal t2 : std_logic_vector(15 downto 0) := "0000000000000100";


component demux is
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
end component demux;

component mux is
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
end component mux;

component reg is
  port(inp : in std_logic_vector(15 downto 0);
       clk : in std_logic;
       op  : out std_logic_vector(15 downto 0));
end component reg;

begin
dem1: demux
port map(d3,a3,s0,s1,s2,s3,s4,s5,s6,s7);
r0: reg
port map(s0,clk,t0);
r1: reg
port map(s1,clk,t1);
r2: reg
port map(s2,clk,t2);
r3: reg
port map(s3,clk,t3);
r4: reg
port map(s4,clk,t4);
r5: reg
port map(s5,clk,t5);
r6: reg
port map(s6,clk,t6);
r7: reg
port map(s7,clk,t7);
m1: mux
port map(t0,t1,t2,t3,t4,t5,t6,t7,a1,d1);
m2: mux
port map(t0,t1,t2,t3,t4,t5,t6,t7,a2,d2);

t3_out <= t3;

end architecture;

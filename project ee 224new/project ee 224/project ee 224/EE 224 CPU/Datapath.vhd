library ieee;
use ieee.std_logic_1164.all;

entity temp is
port (inp: in std_logic_vector(15 downto 0);
      clk: in std_logic;
       op: out std_logic_vector(15 downto 0));
end entity;

architecture desc of temp is
begin
process(clk)
begin
if rising_edge(clk) then
  op <= inp;
end if;
end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
port( 	clk : in std_logic;
      	rd_bar: in std_logic;
		wr_bar: in std_logic;
      	ctrl : in std_logic_vector(48 downto 0);
			pc_in : in std_logic_vector(15 downto 0);
			
	  	flag_c : out std_logic_vector(15 downto 0);
	  	instruction : out std_logic_vector(15 downto 0);
		flag_z : out std_logic_vector(15 downto 0);
		pre_t3 : out std_logic_vector(15 downto 0);
		t3_val : out std_logic_vector(15 downto 0);
		t3_out_risc : out std_logic_vector(15 downto 0);
		pc_out : out std_logic_vector(15 downto 0);
		pre_t2 : out std_logic_vector(15 downto 0);
		t2_val : out std_logic_vector(15 downto 0));
	
end entity;

architecture desc of Datapath is

signal t1,t2,shift1,shift7,t3,alu_a,alu_b,alu_out,rfd1,rfd2,rfd3,rfa1,rfa2,rfa3,ir,z1,z2,z3,z4,z5,z6,z7,z8,z9,z17,memd,mema,memout,z10,se_7,z12,se_10,address,z16 : std_logic_vector(15 downto 0);
signal pc_alu_a, t2_alu_a, se10_alu_a, t2_alu_b, shift1_alu_b, se10_alu_b, se7_alu_b, alu_out_pc, alu_out_t3, alu_ou_t1, rfd1_t1, t1_alu_a, t1_se10, t1_memd, t1_mema, memd_t3, rfd1_t3, t3_rfd1, t3_mema, t3_rfd3, t3_memd, rfd2_t2, rfd1_t2, t2_shift1, t2_se10, t2_se7: std_logic_vector(15 downto 0);
signal pc_mema, se7_shift7, rfd1_pc, pc_rfd3, pc_mema_and_alua,t1_mema_and_alua, alu_out_t1, shift7_rfd3 : std_logic_vector(15 downto 0);
signal z14,pc : std_logic_vector(15 downto 0) := "0000000000000010";
signal pc_prev,pc_inmux_output : std_logic_vector(15 downto 0) := "0000000000000010";
--signal pc : std_logic_vector(15 downto 0);

component ALU is
port( alu_a : in std_logic_vector(15 downto 0);
      alu_b : in std_logic_vector(15 downto 0);
		ctrl : in std_logic_vector(1 downto 0);
		alu_out : out std_logic_vector(15 downto 0);
		c_out : out std_logic_vector(15 downto 0);
		z_out : out std_logic_vector(15 downto 0));
end component ALU;

component mux_4x1 is
port ( inp0: in std_logic_vector(15 downto 0);
          inp1: in std_logic_vector(15 downto 0);
			 inp2: in std_logic_vector(15 downto 0);
			 inp3: in std_logic_vector(15 downto 0);
          sel: in std_logic_vector(1 downto 0);
			 op: out std_logic_vector(15 downto 0));
end component;

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

component demux_1x4 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(1 downto 0);
        out0: out std_logic_vector(15 downto 0);
		  out1: out std_logic_vector(15 downto 0); 
		  out2: out std_logic_vector(15 downto 0);  
		  out3: out std_logic_vector(15 downto 0));
end component demux_1x4;

component temp is
port (inp: in std_logic_vector(15 downto 0);
      clk: in std_logic;
       op: out std_logic_vector(15 downto 0));
end component;

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

component mem is
port (mem_d : in std_logic_vector(15 downto 0);
      mem_a : in std_logic_vector(15 downto 0);
		rd_bar: in std_logic;
		wr_bar: in std_logic;
		clk : in std_logic;
		mem_out : out std_logic_vector(15 downto 0));
end component mem;

component mux_2x1 is
  port (w0, w1 : in std_logic_vector(15 downto 0);
        s : in std_logic;
     f : out std_logic_vector(15 downto 0)); 
end component mux_2x1;

component demux_1x2 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic;
        out0: out std_logic_vector(15 downto 0); 
		  out1: out std_logic_vector(15 downto 0));
end component demux_1x2;

component se7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component se7;

component se10 is
port (inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component se10;

component LeftShift1 is 
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component LeftShift1;

component LeftShift7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component LeftShift7;

component reg is
  port(inp : in std_logic_vector(15 downto 0);
       clk : in std_logic;
       op  : out std_logic_vector(15 downto 0));
end component reg;

component rf is
port( a1 : in std_logic_vector(2 downto 0);
      a2 : in std_logic_vector(2 downto 0);
		a3 : in std_logic_vector(2 downto 0);
		d3 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		d1 : out std_logic_vector(15 downto 0);
		d2 : out std_logic_vector(15 downto 0);
		t3_out : out std_logic_vector(15 downto 0));
end component rf;


begin

-- ALU
dev1: mux
port map(pc_alu_a,t1_alu_a,se10_alu_a,t2_alu_a,pc_mema_and_alua,t1_mema_and_alua,"0000000000000000","0000000000000000", ctrl(2 downto 0),alu_a);
dev2: mux
port map("0000000000000001",t2_alu_b,shift1_alu_b,se10_alu_b,se7_alu_b,"0000000000000000","0000000000000000","0000000000000000",ctrl(5 downto 3),alu_b);
dev3: ALU
port map(alu_a,alu_b,ctrl(7 downto 6),alu_out,flag_c,flag_z);
dev4: demux_1x4
port map(alu_out,ctrl(9 downto 8),alu_out_pc,alu_out_t3,alu_out_t1,alu_out_t1);

pc_out <= alu_out;


z1(5 downto 0) <= ir(5 downto 0);
z1(15 downto 6) <= "0000000000";
z2(2 downto 0) <= ir(11 downto 9);
z2(15 downto 3) <= "0000000000000";
z17(2 downto 0) <= ir(5 downto 3);
z17(15 downto 3) <= "0000000000000";
z7(8 downto 0) <= ir(8 downto 0);
z7(15 downto 9) <= "0000000";
z16(2 downto 0) <= ir(8 downto 6);
z16(15 downto 3) <= "0000000000000";  


instruction <= ir;


-- T1
dev5: mux_4x1
port map(rfd1_t1,z1,z2,alu_out_t1,ctrl(11 downto 10),z3);
dev6: temp
port map(z3,clk,t1);
dev7: demux
port map(t1,ctrl(14 downto 12),t1_alu_a,t1_se10,t1_memd,t1_mema,t1_mema_and_alua,t1_mema,t1_mema,t1_mema);


-- T3
dev8: mux_4x1
port map(alu_out_t3,memd_t3,rfd1_t3,"0000000000000000",ctrl(16 downto 15),z5);
dev9: temp
port map(z5,clk,t3);
dev10: demux_1x4
port map(t3,ctrl(18 downto 17),rfd1,t3_mema,t3_rfd3,t3_memd);

pre_t3 <= z5;
t3_val <= t3;



-- T2
dev11: mux_4x1
port map(rfd2_t2,z1,z7,rfd1_t2,ctrl(20 downto 19),z8);
dev12: temp
port map(z8,clk,t2);
dev13: demux
port map(t2,ctrl(23 downto 21),t2_alu_b,t2_shift1,t2_se10,t2_se7,t2_alu_a,t2_alu_a,t2_alu_a,t2_alu_a);

pre_t2 <= z8;
t2_val <= t2;



-- MEMORY
dev14: mux_4x1
port map(pc_mema,t3_mema,t1_mema,t1_mema_and_alua,ctrl(26 downto 25),mema);
dev15: mux_2x1
port map(t1_memd,t3_memd,ctrl(27),memd);
dev16: mem
port map(memd,mema,rd_bar,wr_bar,clk,memout);
dev17: demux_1x2
port map(memout,ctrl(28),ir,memd_t3);

--pc_out <= mema;


-- SE7
dev18: mux_2x1
port map(t2_se7,z7,ctrl(29),z10);
dev19: se7
port map(z10,se_7);
dev20: demux_1x2
port map(se_7,ctrl(30),se7_alu_b,se7_shift7);



-- SE10
dev21: mux_4x1
port map(t2_se10,t1_se10,z1,"0000000000000000",ctrl(32 downto 31),z12);
dev22: se10
port map(z12,se_10);
dev23: demux_1x2
port map(se_10,ctrl(33),se10_alu_b,se10_alu_a);



-- LEFT SHIFT 1
dev24: LeftShift1
port map(t2_shift1,shift1_alu_b);


-- LEFT SHIFT 7
dev25: LeftShift7
port map(se7_shift7,shift7_rfd3);



-- PC
dev26: mux_2x1
port map(rfd1_pc,alu_out_pc,ctrl(34),pc_inmux_output);
dev27: reg
port map(z14,clk,pc);
dev28: demux_1x4
port map(pc,ctrl(36 downto 35),pc_mema,pc_alu_a,pc_rfd3,pc_mema_and_alua);
--pc <= pc_in;

process(pc_inmux_output)
	begin
	if pc_inmux_output(0) = '0' or pc_inmux_output(0) = '1' then
		pc_prev <= pc_inmux_output;
	end if;		
end process;

z14 <= pc_prev;

--pc_out <= pc;



-- RF
dev29: mux
port map("0000000000000000","0000000000000001","0000000000000010","0000000000000011","0000000000000100","0000000000000101","0000000000000110","0000000000000111",ctrl(39 downto 37),address);
dev30: mux_4x1
port map(z17,z2,z16,address,ctrl(41 downto 40),rfa1);
dev31: mux_2x1
port map(z16,z7,ctrl(42),rfa2);
dev32: mux_4x1
port map(z17,z2,z16,address,ctrl(44 downto 43),rfa3);
dev33: mux_4x1
port map(t3_rfd3,shift7_rfd3,pc_rfd3,"0000000000000000",ctrl(46 downto 45),rfd3);
dev34: rf
port map(rfa1(2 downto 0),rfa2(2 downto 0),rfa3(2 downto 0),rfd3,clk,rfd1,rfd2,t3_out_risc);
dev35: demux_1x4
port map(rfd1,ctrl(48 downto 47), rfd1_t1,rfd1_t3,rfd1_pc,rfd1_t2);

end architecture;
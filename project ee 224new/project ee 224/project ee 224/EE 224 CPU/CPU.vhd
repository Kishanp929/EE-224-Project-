library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity CPU is

port(rst,clk:in std_logic);

end entity;

architecture arc of CPU is

    --components
    component controller is
        port( clk : in std_logic;
              rst : in std_logic;
              flag_c : in std_logic_vector(15 downto 0);
              instruction : in std_logic_vector(15 downto 0);
              flag_z : in std_logic_vector(15 downto 0);
              pre_t3 : in std_logic_vector(15 downto 0);
              t3_val : in std_logic_vector(15 downto 0);
				  

              ctrl : out std_logic_vector(48 downto 0);
              rd_bar : out std_logic;
              wr_bar : out std_logic;
				  state_out : out integer;
				  pc_in : out std_logic_vector(15 downto 0));
            
    end component;

    component Datapath is
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
            
    end component;


    --signals
    signal rd_bar : std_logic;
    signal wr_bar : std_logic;
    signal instruction, pre_t3, t3_val,t3_out_risc,pc_out, pc_in,pre_t2, t2_val : std_logic_vector(15 downto 0);
    signal ctrl : std_logic_vector(48 downto 0);
    signal flag_c : std_logic_vector(15 downto 0) := "0000000000000000";
    signal flag_z : std_logic_vector(15 downto 0) := "0000000000000000";
	 signal state_out : integer;

    begin
        my_controller : controller
            port map(clk,rst,flag_c,instruction,flag_z,pre_t3,t3_val,ctrl,rd_bar,wr_bar,state_out,pc_in);
        
        my_datapath : Datapath
            port map(clk,rd_bar,wr_bar,ctrl,pc_in,flag_c,instruction,flag_z,pre_t3,t3_val,t3_out_risc,pc_out,pre_t2,t2_val);


    end architecture;
        

    --0001 0010 1010 0000
    --0111 1001 0100 0000
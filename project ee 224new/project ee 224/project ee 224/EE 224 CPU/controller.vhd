library ieee;
use ieee.std_logic_1164.all;

entity controller is
port( clk : in std_logic;
      rst : in std_logic;
	  flag_c : in std_logic_vector(15 downto 0);
	  instruction : in std_logic_vector(15 downto 0);
	  flag_z : in std_logic_vector(15 downto 0);
      pre_t3 : in std_logic_vector(15 downto 0);
      t3_val : in std_logic_vector(15 downto 0);
      ctrl : out std_logic_vector(48 downto 0);
      rd_bar : out std_logic;
      wr_bar : out std_logic);
	
end entity;

architecture desc of controller is

    signal state : integer;
	 signal nextstate : integer;
    signal carry_flag_actual : std_logic_vector(15 downto 0) := "0000000000000000";
    signal zero_flag_actual : std_logic_vector(15 downto 0) := "0000000000000000";

	 begin 
	 
    process(clk, rst)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    state <= 0;
                else
                    state <= nextstate;
                end if;
            end if;
    end process;


    process(state)
        begin

            if state = 0 then
                --control bits
                ctrl(36 downto 35) <= "00";
                ctrl(26 downto 24) <= "000";
                ctrl(28) <= '0';
                rd_bar <= '0';
                wr_bar <= '1';
                 
                --nextstate
                nextstate <= 1;
                

            elsif state = 1 then
                --control bits
                ctrl(36 downto 35) <= "11";
                ctrl(26 downto 24) <= "011";
                ctrl(2 downto  0) <= "100";
                ctrl(28) <= '0';
                ctrl(5 downto 3) <= "000";
                ctrl(9 downto 8) <= "00";
                ctrl(34) <= '1';
                ctrl(7 downto 6) <= "00";
                rd_bar <= '0';   
                wr_bar <= '1';
                
                --next state
                --if(instruction = 1,13,5) then
                if( (instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "00" ) or (instruction(15 downto 12) = "1100" ) or (instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "00") ) then
                    nextstate <= 2;
                --elsif(instruction = 2,6) then
                elsif( (instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "00" )  or ( instruction(15 downto 12)="0010"  and instruction(1 downto 0) = "10") ) then
                    if( carry_flag_actual = "0000000000000001") then
                        nextstate <= 5;
                    else
                        nextstate <= 0;
                    end if;
                --elsif(instruction = 3,7) then
                elsif( (instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "01" ) or (instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "01") ) then
                    if( zero_flag_actual = "0000000000000001") then
                        nextstate <= 8;
                    else
                        nextstate <= 0;
                    end if;
                --elsif(instruction = 4) then
                elsif( instruction(15 downto 12) = "0001" ) then
                    nextstate <= 11;
                --elsif(instruction = 8) then
                elsif( instruction(15 downto 12) = "0011" ) then
                    nextstate <= 14;
                --elsif(instruction = 9,10) then
                elsif( (instruction(15 downto 12) = "0100") or (instruction(15 downto 12) = "0101") ) then
                    nextstate <= 16;   
                --elsif(instruction = 14,15) then
                    --nextstate <= 28;
                --elsif(instruction = 15,16) then
                elsif( (instruction(15 downto 12) = "1000") or (instruction(15 downto 12) = "1001") ) then
                    nextstate <= 28;
                --elsif(instruction = 17) then
                elsif(instruction =  "0110")then
					 nextstate <= 22;
                end if;


            elsif state = 2 then
                --control bits
                ctrl(41 downto 40) <= "01";
                ctrl(42) <= '1';
                ctrl(11 downto 10) <= "00";
                ctrl(48 downto 47) <= "00";
                ctrl(20 downto 19) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';
                
                --next state
                --if(instruction = 1,6,14) then
                if( (instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "00" ) or (instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "00") or (instruction(15 downto 12) = "1100" ) ) then
                    nextstate <= 3;
                --elsif(instruction = 4) then
                
                end if;

            
            elsif state = 3 then
                --control bits
                ctrl(2 downto 0) <= "001";
                ctrl(5 downto 3) <= "001";
                ctrl(9 downto 8) <= "01";
                ctrl(14 downto 12) <= "000";
                ctrl(23 downto 21) <= "000";
                ctrl(16 downto 15) <= "00";
                -- 1 add, 6 nand, 14 xor
                --if (instruction = 1) then 
                if ((instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "00" )) then
                    ctrl(7 downto 6) <= "00";
                    --flag set
                    carry_flag_actual <= flag_c;
                    zero_flag_actual <= flag_z;
                --elsif(instruction = 6) then
                elsif(instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "00") then
                    ctrl(7 downto 6) <= "01";
                    --flag set
                    zero_flag_actual <= flag_z;
                --elsif(instruction = 14) then
                elsif(instruction(15 downto 12) = "1100" ) then
                    ctrl(7 downto 6) <= "10";
                end if;
                rd_bar <= '1';
                wr_bar <= '1';

                --flag set
                carry_flag_actual <= flag_c;
                zero_flag_actual <= flag_z;

                --next_state
                --if(instruction = 14) then
                if(instruction(15 downto 12) = "1100" ) then
                    if pre_t3 = "0000000000000000" then
                        nextstate <= 27;
                    else 
                        nextstate <= 0;
                    end if;
                --elsif(instruction = 1,6) then
                elsif( (instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "00" ) or (instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "00") ) then
                    nextstate <= 5;
                end if;

            
            elsif state = 4 then
                -- control bits
                ctrl(18 downto 17) <= "10";
                ctrl(46 downto 45) <= "00";
                ctrl(44 downto 43) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                -- next state
                nextstate <= 0;


            elsif state = 5 then
                --control bits
                ctrl(41 downto 40) <= "01";
                ctrl(42) <= '1';
                ctrl(11 downto 10) <= "00";
                ctrl(48 downto 47) <= "00";
                ctrl(20 downto 19) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --next state
                nextstate <= 6;


            elsif state = 6 then
                --control bits
                ctrl(2 downto 0) <= "001";
                ctrl(5 downto 3) <= "001";
                ctrl(9 downto 8) <= "01";
                ctrl(14 downto 12) <= "000";
                ctrl(23 downto 21) <= "000";
                ctrl(16 downto 15) <= "00";
                -- 2 add, 7 nand
                --if (instruction = 2) then 
                if(instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "10" ) then
                    ctrl(7 downto 6) <= "00";
                    --flag set
                    carry_flag_actual <= flag_c;
                    zero_flag_actual <= flag_z;
                --elsif(instruction = 7) then
                elsif(instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "10" ) then
                    ctrl(7 downto 6) <= "01";
                    --flag set
                    zero_flag_actual <= flag_z;
                end if;
                rd_bar <= '1';
                wr_bar <= '1';

                

                --next state
                nextstate <= 7;


            elsif state = 7 then
                -- control bits
                ctrl(18 downto 17) <= "10";
                ctrl(46 downto 45) <= "00";
                ctrl(44 downto 43) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                -- next state
                nextstate <= 0;


            elsif state = 8 then
                --control bits
                ctrl(41 downto 40) <= "01";
                ctrl(42) <= '1';
                ctrl(11 downto 10) <= "00";
                ctrl(48 downto 47) <= "00";
                ctrl(20 downto 19) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --next state
                nextstate <= 9;


            elsif state = 9 then
                --control bits
                ctrl(2 downto 0) <= "001";
                ctrl(5 downto 3) <= "001";
                ctrl(9 downto 8) <= "01";
                ctrl(14 downto 12) <= "000";
                ctrl(23 downto 21) <= "000";
                ctrl(16 downto 15) <= "000";
                -- 3 add, 8 nand
                --if (instruction = 3) then 
                if( instruction(15 downto 12) = "0000" and instruction(1 downto 0) = "01" ) then
                    ctrl(7 downto 6) <= "00";
                     --flag set
                    carry_flag_actual <= flag_c;
                    zero_flag_actual <= flag_z;
                --elsif(instruction = 8) then
                elsif( instruction(15 downto 12) = "0010" and instruction(1 downto 0) = "01" ) then
                    ctrl(7 downto 8) <= "01";
                     --flag set
                    zero_flag_actual <= flag_z;
                end if;
                rd_bar <= '1';
                wr_bar <= '1';

               

                --next state
                nextstate <= 10;


            elsif state = 10 then
                -- control bits
                ctrl(18 downto 17) <= "10";
                ctrl(46 downto 45) <= "00";
                ctrl(44 downto 43) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                -- next state
                nextstate <= 0;


            elsif state = 11 then
                --control bits
                ctrl(2 downto 0) <= "001";
                ctrl(14 downto 12) <= "000";
                ctrl(23 downto 21) <= "001";
                ctrl(5 downto 3) <= "010";
                ctrl(9 downto 8) <= "001";
                ctrl(16 downto 15) <= "000";
                ctrl(7 downto 6) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --flag set
                carry_flag_actual <= flag_c;
                zero_flag_actual <= flag_z;

                --next state
                nextstate <= 4;


            elsif state = 12 then
                --control bits
                ctrl(20 downto 19) <= "01";
                ctrl(41 downto 40) <= "01";
                ctrl(48 downto 47) <= "00";
                ctrl(11 downto 10) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --next_state
                nextstate <= 13;


            elsif state = 13 then
                --control bits
                ctrl(2 downto 0) <= "001";
                ctrl(14 downto 12) <= "000";
                ctrl(23 downto 21) <= "010";
                ctrl(32 downto 31) <= "00";
                ctrl(33) <= '0'; 
                ctrl(5 downto 3) <= "011";
                ctrl(9 downto 8) <= "001";
                ctrl(16 downto 15) <= "000";
                ctrl(7 downto 6) <= "000";
                rd_bar <= '1';
                wr_bar <= '1';

                --flag set
                carry_flag_actual <= flag_c;
                zero_flag_actual <= flag_z;

                --next state
                nextstate <= 0;


            elsif state = 14 then
                --control bits
                ctrl(18 downto 17) <= "10";
                ctrl(46 downto 45) <= "00";
                ctrl(44 downto 43) <= "10";
                rd_bar <= '1';
                wr_bar <= '1';

                -- next state
                nextstate <= 15;
            

            elsif state = 15 then
                -- control bits
                ctrl(42) <= '1';
                ctrl(20 downto 19) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --next_state
                nextstate <= 0;


            elsif state = 16 then
                --control bits
                ctrl(23 downto 21) <= "011";
                ctrl(29) <= '0';
                ctrl(30) <= '1';
                ctrl(46 downto 45) <= "01";
                ctrl(44 downto 43) <= "01";
                rd_bar <= '1';
                wr_bar <= '1';
        
		         
					  if(instruction(15 downto 12) = "0100" and instruction = "0101") then
                    nextstate <= 17;
                --elsif(instruction = 11) then
                else
                    nextstate <= 0;
                end if;
            
					
					
               


            elsif state = 17 then
                --control bits
                ctrl(42) <= '0';
                ctrl(20 downto 19) <= "00";
                ctrl(11 downto 10) <= "01";
                rd_bar <= '1';
                wr_bar <= '1';

                  if(instruction(15 downto 12) = "0100") then
                    nextstate <= 18;
                --elsif(instruction = 11) then
                elsif(instruction(15 downto 12) = "0101") then
                    nextstate <= 20;
						else
				         nextstate <=0;		
                end if;
            
                

            elsif state = 18 then
                --control bits
                ctrl(14 downto 12) <= "001";
                ctrl(32 downto 21) <= "01";
                ctrl(33) <= '1';
                ctrl(2 downto 0) <= "010";
                ctrl(23 downto 21) <= "000";
                ctrl(5 downto 3) <= "001";
                ctrl(9 downto 8) <= "01";
                ctrl(16 downto 15) <= "00";
                ctrl(7 downto 6) <= "00";   
                rd_bar <= '1';
                wr_bar <= '1';

                 nextstate <= 19;
            

            elsif state = 19 then
                --control bits
                ctrl(18 downto 17) <= "01";
                ctrl(26 downto 24) <= "001";
                ctrl(28) <= '1';
                ctrl(16 downto 15) <= "01";
                rd_bar <= '0';
                wr_bar <= '1';

                --flag set
                if pre_t3 = "0000000000000000" then
                    zero_flag_actual <= "0000000000000001";
                else 
                    zero_flag_actual <= "0000000000000000";
                end if;


                --next_state
                nextstate <= 0;


            elsif state = 20 then
                --control bits
                ctrl(18 downto 17) <= "10";
                ctrl(46 downto 45) <= "00";
                ctrl(44 downto 43) <= "01";
                rd_bar <= '1';
                wr_bar <= '1';

                --next state
                nextstate <= 21;


            elsif state = 21 then
                --control bits
                ctrl(41 downto 40) <= "01";
                ctrl(48 downto 47) <= "00";
                ctrl(11 downto 10) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --nextstate
                nextstate <= 0;

            
            elsif state = 22 then
                --control bits
                ctrl(14 downto 12) <= "010";
                ctrl(27) <= '0';
                ctrl(18 downto 17) <= "01";
                ctrl(26 downto 24) <= "001";
                rd_bar <= '1';
                wr_bar <= '0';

                --next state
                nextstate <= 0;

            elsif state = 28 then
                --control bits
                ctrl(36 downto 35) <= "01";
                ctrl(2 downto 0) <= "000";
                ctrl(32 downto 31) <= "10";
                ctrl(33) <= '0';
                ctrl(5 downto 3) <= "011";
                ctrl(9 downto 8) <= "00";
                ctrl(7 downto 6) <= "00";
                ctrl(34) <= '1';
                rd_bar <= '1';
                wr_bar <= '1';

                if(instruction = "1000" or instruction = "1001")then
					    nextstate <= 28 ;
					else
			          nextstate <= 0;
					 end if;	 

            elsif state = 29 then
                --control bits
                ctrl(36 downto 35) <= "10";
                ctrl(46 downto 45) <= "10";
                ctrl(44 downto 43) <= "01";
                rd_bar <= '1';
                wr_bar <= '1';

                --nextstate
                  nextstate <= 0;
            elsif state = 30 then
                --control bits
                ctrl(36 downto 35) <= "01";
                ctrl(2 downto 0) <= "000";
                ctrl(32 downto 31) <= "10";
                ctrl(33) <= '0';
                ctrl(5 downto 3) <= "011";
                ctrl(9 downto 8) <= "00";
                ctrl(34) <= '1';
                ctrl(7 downto 6) <= "00";
                rd_bar <= '1';
                wr_bar <= '1';

                --next state
                nextstate <= 0;

            
           

            

            end if;
    end process;

end architecture;



            



            




            
                    

                


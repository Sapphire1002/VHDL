library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpga_pl1 is
    port(
        reset: in std_logic;
        clk: in std_logic;
        en: in std_logic;

        pl1: in std_logic;
        data: inout std_logic;
        led: out std_logic_vector(7 downto 0);

        clk_out: out std_logic;
        reset_out: out std_logic

    );
end entity;

architecture behavioral of fpga_pl1 is
    signal freq: std_logic_vector(25 downto 0);
    signal freq_clk: std_logic;
    
    signal pos: std_logic_vector(15 downto 0);
    signal play_state is (s0, s1, s2);
    signal ball_state: play_state; 

    signal trans_state is (ball_pos);
    signal io_state: trans_state; 

    signal serve: std_logic;
    signal pl2: std_logic;

begin
    freq_clk <= freq(21);
    clk_out <= freq_clk;
    reset_out <= reset;
    led <= pos(7 downto 0);

    freq_div: process (clk, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
    end process;
   
    trans_data: process(clk, reset, io_state, pl2, pos, serve)
    begin
        if reset = '1' then
            data <= 'Z';
            io_state <= ball_pos;
        
        elsif clk 'event and clk = '1' then
            case io_state is
                when ball_pos =>
                    if serve = '0' then
                        if pos(7) = '1' then
                            data <= '1';
                        else
                            data <= 'Z';
                            pl2 <= data;
                        end if;
                    
                    elsif serve = '1' then
                        if pos(8) = '1' then
                            data <= '0';
                        else
                            data <= 'Z';
                            pl2 <= data;
                        end if;
                    end if;
            end case;
        end if;
    end process;

    FSM: process (freq_clk, reset, state, pl2, pos, serve)
    begin
        if reset = '1' then
            state <= s0;
            serve <= '0';

        elsif freq_clk 'event and freq_clk = '1' then
            case ball_state is
                when s0 =>
                   if serve = '0' then
                        pos <= "0000000000000001";
                        if pl1 = '1' then
                            state <= s1;
                        else
                            state <= s0;
                        end if;
                    
                    elsif serve = '1' then
                        pos <= "1000000000000000";
                        if pl2 = '1' then
                            state <= s2;
                        else
                            state <= s0;
                        end if;
                    end if;
                
                when s1 => 
                    if pl2 = '1' and pos(15) = '0' then
                        serve <= '0';
                        state <= s0;
                    
                    elsif pl2 = '0' and pos(15) = '1' then
                        serve <= '0';
                        state <= s0;
                    
                    elsif pl2 = '1' and pos(15) = '1' then
                        state <= s2;
                    
                    else
                        pos <= pos(14 downto 0) & pos(15);
                        state <= s1;
                    end if;
                
                when s2 =>
                    if pl1 = '1' and pos(0) = '0' then
                        serve <= '1';
                        state <= s0;
                    
                    elsif pl1 = '0' and pos(0) = '1' then
                        serve <= '1';
                        state <= s0;
                    
                    elsif pl1 = '1' and pos(0) = '1' then
                        state <= s1;
                    
                    else
                        pos <= pos(15 downto 1) & pos(0);
                        state <= s2;
                    end if;
                
                when others =>
                    null;
            end case;
        end if;
    end process;

end behavioral;

	
-- -------- actual circuit --------
    -- led_out: process (clk, reset, get)
    -- begin
    --     if (reset = '1') then
    --         led <= "00000000";
			
    --     elsif (clk 'event and clk = '1') then
    --         case get is
    --             when "0001" => 
    --                 led <= "10000000";
					
    --             when "0010" => 
    --                 led <= "01000000";
					
    --             when "0011" => 
    --                 led <= "00100000";
					
    --             when "0100" => 
    --                 led <= "00010000";
					
    --             when "0101" => 
    --                 led <= "00001000";
					
    --             when "0110" => 
    --                 led <= "00000100";
					
    --             when "0111" => 
    --                 led <= "00000010";
					
    --             when "1000" => 
    --                 led <= "00000001";
					
    --             when others => 
    --                 led <= "00000000";
    --         end case;
    --     end if;
    -- end process;

    -- end seven-segement display screen
    -- PL1_ssd(common: positive)
    -- pl1: process (clk_div, reset, PL1_score) 
    -- begin
    --     if (reset = '1') then
    --         PL1_ssd <= "0000001";
			
    --     elsif (clk_div 'event and clk_div = '1') then
    --         case PL1_score is
    --             when "0000" =>
    --                 PL1_ssd <= "0000001";
					
    --             when "0001" =>
    --                 PL1_ssd <= "1001111";
					
    --             when "0010" =>
    --                 PL1_ssd <= "0010010";
					
    --             when "0011" =>
    --                 PL1_ssd <= "0000110";
					
    --             when "0100" =>
    --                 PL1_ssd <= "1001100";
					
    --             when "0101" => 
    --                 PL1_ssd <= "0100100";
					
    --             when "0110" =>
    --                 PL1_ssd <= "0100000";
					
    --             when "0111" =>
    --                 PL1_ssd <= "0001111";
					
    --             when "1000" =>
    --                 PL1_ssd <= "0000000";
					
    --             when "1001" =>
    --                 PL1_ssd <= "0000100";
					
    --             when others => 
    --                 null;
    --         end case;
    --     end if;
    -- end process;

    -- PL2_ssd(common: positive)
    -- pl2: process (clk_div, reset, PL2_score) 
    -- begin
    --     if (reset = '1') then
    --         PL2_ssd <= "0000001";
			
    --     elsif (clk_div 'event and clk_div = '1') then
    --         case PL2_score is
    --             when "0000" =>
    --                 PL2_ssd <= "0000001";
					
    --             when "0001" =>
    --                 PL2_ssd <= "1001111";
					
    --             when "0010" =>
    --                 PL2_ssd <= "0010010";
					
    --             when "0011" =>
    --                 PL2_ssd <= "0000110";
					
    --             when "0100" =>
    --                 PL2_ssd <= "1001100";
					
    --             when "0101" => 
    --                 PL2_ssd <= "0100100";
					
    --             when "0110" =>
    --                 PL2_ssd <= "0100000";
					
    --             when "0111" =>
    --                 PL2_ssd <= "0001111";
					
    --             when "1000" =>
    --                 PL2_ssd <= "0000000";
					
    --             when "1001" =>
    --                 PL2_ssd <= "0000100";
					
    --             when others => 
    --                 null;
    --         end case;
    --     end if;
    -- end process;

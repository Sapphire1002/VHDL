library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

-- btn1: PL1, btn2: PL2
-- PL1_ssd, PL2_ssd: PL1 score/PL2 score seven-segement display
entity pingpong_LED is
    port(
        clk, reset: in std_logic;
        btn1, btn2: in std_logic;
        PL1_ssd, PL2_ssd: out std_logic_vector(6 downto 0);
        led: out std_logic_vector(7 downto 0)
    );
end entity;
   
architecture Behavioral of pingpong_LED is
    -- clock divider
    signal freq: std_logic_vector(25 downto 0);
    signal clk_div: std_logic;

    -- Mealy state
    type type_state is (s0, s1, s2);
    signal state: type_state;
	
    -- ctrl right to serve
    signal serve: std_logic;
	
    -- ball move
    signal cnt: std_logic_vector(3 downto 0);
	
    -- count score
    signal PL1_score: std_logic_vector(3 downto 0);
    signal PL2_score: std_logic_vector(3 downto 0);

    -- LFSR generation numbers
    signal temp: std_logic;
    signal Qt: std_logic_vector(2 downto 0);
    signal move: std_logic_vector(2 downto 0);

begin
    clk_div <= freq(23);

    freq_div: process (clk, reset, freq)
    begin
	if reset = '1' then
            freq <= (others => '0');
	elsif clk 'event and clk = '1' then
            freq <= freq + '1';
	end if;
    end process;

    LFSR_random: process (clk_div, reset, Qt, temp)
    begin
        if reset = '1' then
            Qt <= "001";

        elsif clk_div 'event and clk_div = '1' then
            temp <= Qt(2) xor Qt(1);
            Qt(2) <= Qt(1);
            Qt(1) <= Qt(0);
            Qt(0) <= temp;

        end if;
        move <= Qt;
    end process;

    -- preset: 
    -- LED number from 1 to 8; cnt from 0 to 9;
    -- serve: right to serve; 0/1: PL1/PL2 serve
    -- state (3 states)
    -- reset -> s0
    -- s0: PL1, PL2 before serving 
    -- s1: LED right move, PL2 catch the ball
    -- s2: LED left move, PL1 catch the ball
	
    MealyFSM: process (clk_div, reset, state, serve, cnt, move, PL1_score, PL2_score)
    begin
        if reset = '1' then
            state <= s0;
            serve <= '0';
            PL1_score <= "0000";
            PL2_score <= "0000";
		
        elsif clk_div 'event and clk_div = '1' then
            case state is
                when s0 =>
                    if serve = '0' then
                        cnt <= "0001";
                        if btn1 = '1' then
                    	    state <= s1;
                        else
                    	    state <= s0;
                        end if;
					
                    elsif serve = '1' then
                        cnt <= "1000";
                        if btn2 = '1' then
                            state <= s2;
                        else
                            state <= s0;
                        end if;
                    end if;
				
            when s1 =>
                -- press too early
                if btn2 = '1' and cnt < "1000" then
                    serve <= '0';
                    PL1_score <= PL1_score + '1';
                    state <= s0;
				
                -- press too late
                elsif cnt >= "1001" then
                    serve <= '0';
                    PL1_score <= PL1_score + '1';
                    state <= s0;
				
                -- catch the ball
                elsif btn2 = '1' and cnt = "1000" then
                    state <= s2;
                
                -- ball move
                else
                    if cnt + move > "1000" then
                        cnt <= cnt + '1';
                    else
                        cnt <= cnt + move;
                    end if;
                    state <= s1;
                end if;
			
            when s2 =>
                -- press too early
                if btn1 = '1' and cnt > "0001" then
                    serve <= '1';
                    PL2_score <= PL2_score + '1';
                    state <= s0;
				
		 -- press too late
                elsif cnt <= "0000" then
                    serve <= '1';
                    PL2_score <= PL2_score + '1';
                    state <= s0;
				
		        -- catch the ball
                elsif btn1 = '1' and cnt = "0001" then
                    state <= s1;
                
                -- ball move
                else
                    if cnt > move then
                        cnt <= cnt - move;
                    else
                        cnt <= cnt - '1';
                    end if;
                    state <= s2;
                end if;
	
            when others => 
                null;

	        end case;
	    end if;
    end process;
	
-------- actual circuit --------
    led_out: process (clk_div, reset, cnt)
    begin
        if (reset = '1') then
            led <= "00000000";
			
        elsif (clk_div 'event and clk_div = '1') then
            case cnt is
                when "0001" => 
                    led <= "10000000";
					
                when "0010" => 
                    led <= "01000000";
					
                when "0011" => 
                    led <= "00100000";
					
                when "0100" => 
                    led <= "00010000";
					
                when "0101" => 
                    led <= "00001000";
					
                when "0110" => 
                    led <= "00000100";
					
                when "0111" => 
                    led <= "00000010";
					
                when "1000" => 
                    led <= "00000001";
					
                when others => 
                    led <= "00000000";
            end case;
        end if;
    end process;

    -- end seven-segement display screen
    -- PL1_ssd(common: positive)
    pl1: process (clk_div, reset, PL1_score) 
    begin
        if (reset = '1') then
            PL1_ssd <= "0000001";
			
        elsif (clk_div 'event and clk_div = '1') then
            case PL1_score is
                when "0000" =>
                    PL1_ssd <= "0000001";
					
                when "0001" =>
                    PL1_ssd <= "1001111";
					
                when "0010" =>
                    PL1_ssd <= "0010010";
					
                when "0011" =>
                    PL1_ssd <= "0000110";
					
                when "0100" =>
                    PL1_ssd <= "1001100";
					
                when "0101" => 
                    PL1_ssd <= "0100100";
					
                when "0110" =>
                    PL1_ssd <= "0100000";
					
                when "0111" =>
                    PL1_ssd <= "0001111";
					
                when "1000" =>
                    PL1_ssd <= "0000000";
					
                when "1001" =>
                    PL1_ssd <= "0000100";
					
                when others => 
                    null;
            end case;
        end if;
    end process;

    -- PL2_ssd(common: positive)
    pl2: process (clk_div, reset, PL2_score) 
    begin
        if (reset = '1') then
            PL2_ssd <= "0000001";
			
        elsif (clk_div 'event and clk_div = '1') then
            case PL2_score is
                when "0000" =>
                    PL2_ssd <= "0000001";
					
                when "0001" =>
                    PL2_ssd <= "1001111";
					
                when "0010" =>
                    PL2_ssd <= "0010010";
					
                when "0011" =>
                    PL2_ssd <= "0000110";
					
                when "0100" =>
                    PL2_ssd <= "1001100";
					
                when "0101" => 
                    PL2_ssd <= "0100100";
					
                when "0110" =>
                    PL2_ssd <= "0100000";
					
                when "0111" =>
                    PL2_ssd <= "0001111";
					
                when "1000" =>
                    PL2_ssd <= "0000000";
					
                when "1001" =>
                    PL2_ssd <= "0000100";
					
                when others => 
                    null;
            end case;
        end if;
    end process;
end Behavioral;

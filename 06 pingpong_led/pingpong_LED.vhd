library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

-- btn1: PL1, btn2: PL2
-- sw(4 bits): set winning conditions 
-- PL1_ssd, PL2_ssd: PL1 score/PL2 score seven-segement display
entity pingpong_LED is
    port(
        clk, reset: in std_logic;
        btn1, btn2: in std_logic;
        sw: in std_logic_vector(3 downto 0);
        PL1_ssd, PL2_ssd: out std_logic_vector(6 downto 0);
        led: out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of pingpong_LED is
    -- clock divider
    signal freq: std_logic_vector(25 downto 0);
    signal clk_div: std_logic;

    -- mealy machine 
    signal state: std_logic_vector(2 downto 0);
    signal next_state: std_logic_vector(2 downto 0);

    -- ball position(0 to 9)
    signal cnt: std_logic_vector(3 downto 0);

    -- count score
    signal PL1_score: std_logic_vector(3 downto 0);
    signal PL2_score: std_logic_vector(3 downto 0);

    -- win condition
    signal win_condi: std_logic_vector(3 downto 0);

    -- game over state
    signal gameover: std_logic;

begin
    clk_div <= freq(23);
    win_condi <= sw;

    freq_div: process (clk, reset, freq)
    begin
        if (reset = '1') then
            freq <= (others => '0');
        elsif (clk 'event and clk = '1') then
            freq <= freq + '1';
        end if;
    end process;

    -- preset: 
    -- LED number from 1 to 8; cnt from 0 to 9;
    -- PL1 serves first
    -- state(3 bits, 8 states): 
    -- 000: PL1 before serving, 001: PL2 before serving
    -- 010: LED right move, 011: LED left move
    -- 100: PL1 catch the ball, 101: PL2 catch the ball
    -- 110: PL1 current score/Win, 111: PL2 current score/Win

    Mealy: process (clk_div, reset, state, next_state)
    begin
        if (reset = '1') then
            state <= "000";
        elsif (clk_div 'event and clk_div = '1') then
            state <= next_state;
        end if;
    end process;

    FSM: process (clk_div, state, next_state, PL1_score, PL2_score, cnt, btn1, btn2, gameover)
    begin
        case state is
            when "000" =>
                if (btn1 = '1') then
                    next_state <= "010";
                else
                    next_state <= "000";
                end if;

            when "001" =>   
                if (btn2 = '1') then
                    next_state <= "011";
                else
                    next_state <= "001";
                end if;

            when "010" =>
                if (cnt < "1000") then
                    if (btn2 = '0') then
                        next_state <= "010";
                    else
                        next_state <= "110";
                    end if;
                else
                    next_state <= "101";
                end if;

            when "011" =>
                if (cnt > "0001") then
                    if (btn1 = '0') then
                        next_state <= "011";
                    else
                        next_state <= "111";
                    end if;
                else
                    next_state <= "100";
                end if;

            when "100" =>
                if (btn1 = '1' and cnt = "0001") then
                    next_state <= "010";
                else
                    next_state <= "111";
                end if;

            when "101" =>
                if (btn2 = '1' and cnt = "1000") then
                    next_state <= "011";
                else
                    next_state <= "110";
                end if;

            when "110" =>
                if (PL1_score = win_condi) then
                    gameover <= '0';
                else
                    next_state <= "000";
                end if;

            when "111" =>
                if (PL2_score = win_condi) then
                    gameover <= '1';
                else
                    next_state <= "001";
                end if;

            when others =>
                next_state <= "000";
        end case;
    end process;

    -- 000: PL1 before serving
    serve_pl1: process (clk_div, reset, state, cnt)
    begin
        if (reset = '1') then
            cnt <= "0001";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "000") then
                cnt <= "0001";
            end if;
        end if;
    end process;

    -- 001: PL2 before serving
    serve_pl2: process (clk_div, reset, state, cnt)
    begin
        if (reset = '1') then
            cnt <= "0001";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "001") then
                cnt <= "1000";
            end if;
        end if;
    end process;

    -- 010: LED right move
    Right_move: process (clk_div, reset, state, cnt)
    begin
        if (reset = '1') then
            cnt <= "0001";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "010") then
                cnt <= cnt + '1';
            end if;
        end if;
    end process;

    -- 011: LED left move
    Left_move: process (clk_div, reset, state, cnt)
    begin
        if (reset = '1') then
            cnt <= "0001";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "011") then
                cnt <= cnt - '1';
            end if;
        end if;
    end process;

    -- 110: count PL1 current score
    count_pl1: process (clk_div, reset, state, PL1_score)
    begin
        if (reset = '1') then
            PL1_score <= "0000";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "110") then
                PL1_score <= PL1_score + '1';
            end if;
        end if;
    end process;

    -- 111: count PL1 current score
    count_pl2: process (clk_div, reset, state, PL2_score)
    begin
        if (reset = '1') then
            PL2_score <= "0000";
        elsif (clk_div 'event and clk_div = '1') then
            if (state = "111") then
                PL2_score <= PL2_score + '1';
            end if;
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
    -- PL1_ssd(common: cntitive)
    pl1: process (clk_div, reset, PL1_score, gameover) 
    begin
        if (reset = '1') then
            PL1_ssd <= "0000001";
        elsif (clk_div 'event and clk_div = '1') then
            -- if (gameover = '0') then
            --     PL1_ssd <= "1111111";
            -- end if;
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

    -- PL2_ssd(common: cntitive)
    pl2: process (clk_div, reset, PL2_score, gameover) 
    begin
        if (reset = '1') then
            PL2_ssd <= "0000001";
        elsif (clk_div 'event and clk_div = '1') then
            -- if (gameover = '1') then
            --     PL2_ssd <= "1111111";
            -- end if;
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
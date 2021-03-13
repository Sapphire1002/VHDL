library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpga_pl1 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        pl1: in std_logic;
        data: inout std_logic;
        led: out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of fpga_pl1 is
    -- clk divider
    signal freq: std_logic_vector(25 downto 0);
    signal freq_clk: std_logic;
    
    -- FSM state
    type play_state is (s0, s1, s2);
    signal ball_state: play_state;

    -- led output
    signal pos: std_logic_vector(7 downto 0);

    -- current ball position
    signal count_right: integer;
    signal count_left: integer;
    
    -- send & receive value
    -- ena -> 0: output, 1: input 
    signal serve: std_logic;
    signal pl2: std_logic;
    signal ena: std_logic;
    
begin
    freq_clk <= freq(23);
    led <= pos(7 downto 0);

    freq_div: process (clk, reset, freq)
    begin
        if reset = '0' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
    end process;

    ctrl_counter_right: process (freq_clk, reset, count_right, ball_state)
    begin
        if reset = '0' then
            count_right <= 1;

        elsif freq_clk 'event and freq_clk = '1' then
            if ball_state = s1 then
                count_right <= count_right + 1;
            else
                count_right <= 1;
            end if;
        end if;
    end process;

    ctrl_counter_left: process (freq_clk, reset, count_left, ball_state)
    begin
        if reset = '0' then
            count_left <= 18;

        elsif freq_clk 'event and freq_clk = '1' then
            if ball_state = s2 then
                count_left <= count_left - 1;
            else
                count_left <= 18;
            end if;
        end if;
    end process;

    in_out_data: process (freq_clk, reset, pos, serve, pl2, ena)
    begin
        if reset = '0' then
            data <= 'Z';
            pl2 <= '0';

        elsif freq_clk 'event and freq_clk = '1' then
            if ena = '0' then  -- output
                if serve = '0' and pl1 = '1' then
                    data <= '1';
                else
                    data <= '0';
                end if;

            elsif ena = '1' then  -- input
                if serve = '0' and data = '1' then
                    pl2 <= '1';
                    data <= 'Z';
                else
                    pl2 <= '0';
                    data <= 'Z';
                end if;
            end if;
        end if;
    end process;

    FSM: process (freq_clk, reset, ball_state, pl1, pl2, pos, serve, count_right, count_left, ena)
    begin
        if reset = '0' then
            ena <= '0';
            serve <= '0';
            ball_state <= s0;
            pos <= (others => '0');

        elsif freq_clk 'event and freq_clk = '1' then
            case ball_state is
                when s0 =>
                -- serve -> 0: pl1 serving, 1: pl2 serving
                   if serve = '0' then
                        pos <= "00000001";
                        ena <= '0';

                        if pl1 = '1' then
                            ball_state <= s1;
                        else
                            ball_state <= s0;
                        end if;

                    elsif serve = '1' then
                        null;
                    end if;

                when s1 => 
                    -- pl2 catch the ball
                    if pl2 = '1' and count_right = 18 then
                        ball_state <= s2;

                    -- ball move
                    else
                        pos <= pos(6 downto 0) & '0';
                        ena <= '1';
                        ball_state <= s1;
                    end if;
                
                when s2 =>
                    -- set initial pos
                    if count_left = 12 and pos(7) = '0' then 
                        pos <= "10000000";
                        ena <= '0';
                        ball_state <= s2;

                    -- pl1 catch the ball
                    elsif pl1 = '1' and count_left = 4 then
                        ena <= '1';
                        ball_state <= s1;
                    
                    -- ball move
                    else
                        pos <= '0' & pos(7 downto 1);
                        ena <= '0';
                        ball_state <= s2;
                    end if;

                when others =>
                    null;
            end case;
        end if;
    end process;
end behavioral;

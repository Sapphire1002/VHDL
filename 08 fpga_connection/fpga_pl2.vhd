library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpga_pl2 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        pl2: in std_logic;
        data: inout std_logic;
        led: out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of fpga_pl2 is
    -- clk divider
    signal freq: std_logic_vector(25 downto 0);
    signal freq_clk: std_logic;

    -- FSM state
    type play_state is (s0, s1, s2);
    signal ball_state: play_state; 

    -- led output
    signal pos: std_logic_vector(7 downto 0);

    -- current ball position
    -- 0 to 9 counter, 1 to 8 ball pos
    signal count: integer;

    -- send & receive value
    -- ena -> 0: output, 1: input 
    signal serve: std_logic;
    signal pl1: std_logic;
    signal ena: std_logic;
    
begin
    led <= pos(7 downto 0);
    freq_clk <= freq(23);

    freq_div: process (clk, reset, freq)
    begin
        if reset = '0' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
    end process;

    in_out_data: process (freq_clk, reset, pos, serve, count, pl1, ena)
    begin
        if reset = '0' then
            data <= 'Z';
            pl1 <= '0';

        elsif freq_clk 'event and freq_clk = '1' then
            if ena = '0' then  -- output
                if serve = '0' and pl2 = '1' then
                    data <= '1';
                else
                    data <= '0';
                end if;

            elsif ena = '1' then  -- input
                if serve = '0' and data = '1' then
                    pl1 <= '1';
                    data <= 'Z';
                else
                    pl1 <= '0';
                    data <= 'Z';
                end if;

            end if;
        end if;
    end process;

    FSM: process (freq_clk, reset, ball_state, pl1, pos, serve, count, ena)
    begin
        if reset = '0' then
            ena <= '1';
            serve <= '0';
            count <= 1;
            ball_state <= s0;
            pos <= (others => '0');

        elsif freq_clk 'event and freq_clk = '1' then
            case ball_state is
                when s0 =>
                   if serve = '0' then
                        pos <= (others => '0');
                        count <= 1;
                        ena <= '1';

                        if pl1 = '1' then
                            ball_state <= s1;
                        else
                            ball_state <= s0;
                        end if;
                
                    elsif serve = '1' then
                        pos <= "10000000";
                        count <= 16;
                        ena <= '0';

                    end if;

                when s1 =>
                    -- set initial pos
                    if count = 9 and pos(0) = '0' then
                        pos <= "00000001";
                        ena <= '0';
                        ball_state <= s1;  

                    -- pl2 catch the ball
                    elsif count = 16 and pl2 = '1' then          
                        ball_state <= s2;  -- left move

                    -- pl2 press to early
                    elsif count < 16 and pl2 = '1' then
                        serve <= '0';
                        ball_state <= s0;

                    -- pl2 press to late
                    elsif count > 16 then
                        serve <= '0';
                        ball_state <= s0;
                    
                    -- ball move
                    else
                        pos <= pos(6 downto 0) & '0';
                        count <= count + 1;
                        ena <= '0';
                        ball_state <= s1;
                    end if;
                
                when s2 =>
                    -- pl1 catch the ball
                    if pl1 = '1' and count = 1 then
                        ena <= '0';
                        ball_state <= s1;
                    
                    -- pl1 press to early
                    elsif pl1 = '1' and count > 1 then
                        serve <= '1';
                        ball_state <= s0;
                    
                    -- pl1 press to late
                    elsif count < 1 then
                        serve <= '1';
                        ball_state <= s0;

                    -- ball move
                    else
                        pos <= '0' & pos(7 downto 1);
                        count <= count - 1;
                        ena <= '1';
                        ball_state <= s2;
                    end if;

                when others =>
                    null;
            end case;
        end if;
    end process;
end behavioral;
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
    signal count: integer;

    -- send & receive value
    -- en: 0: input, 1: output
    signal serve: std_logic;
    signal pl1: std_logic;
    signal en: std_logic;

begin
    -- led <= pos(7 downto 0);
    freq_clk <= freq(22);

    freq_div: process (clk, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
    end process;

    trans_data: process(clk, reset, pl1, pos, serve, count)
    begin
        if reset = '0' then
            data <= 'Z';
            led <= (others => '0');       
        
        elsif clk 'event and clk = '1' then
            if serve = '0' then
                if data = '1' then
                    data <= 'Z';
                    pl1 <= '1';      
                end if;
            end if;
        end if;
    end process;

    FSM: process (freq_clk, reset, ball_state, pl2, pos, serve, count)
    begin
        if reset = '0' then
            serve <= '0';
            count <= 0;
            ball_state <= s0;
            pos <= (others => '0');

        elsif freq_clk 'event and freq_clk = '1' then
            case ball_state is
                when s0 =>
                   if serve = '0' then
                        count <= 0;
                        pos(0) <= pl1;
                        if pos(0) = '1' then
                            ball_state <= s1;
                        else
                            ball_state <= s0;
                        end if;
                    end if;
                
                when s1 => 
                    pos <= pos(6 downto 0) & '0';
                    count <= count + 1;
                    ball_state <= s1;
                
                when s2 =>
                    pos <= '0' & pos(7 downto 1);
                    count <= count - 1;
                    ball_state <= s2;
                
                when others =>
                    null;
            end case;
        end if;
    end process;
end behavioral;
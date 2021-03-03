library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity player_other is
    port(
        clk_100MHz_in: in std_logic;
        reset_in: in std_logic;
        sw_start: in std_logic;
        pl2: in std_logic;
        sda: inout std_logic;
        ledout: out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of player_other is
    -- clk divider
    signal freq: std_logic_vector(25 downto 0);
    signal freq_clk: std_logic;

    -- control start
    signal start: std_logic;

    -- sda_rw: control read or write
    -- 0: read 1: write
    -- stop: control the timing of receiving data
    -- 0: enable 1: disable
    signal sda_rw: std_logic;
    signal stop: std_logic;

    -- send and receive value
    signal bit_state: std_logic;
    signal bit_count: integer;
    signal ball_count: integer;
    -- signal send_reg: std_logic_vector(7 downto 0);
    signal receive_reg: std_logic_vector(7 downto 0);

    -- control serving
    -- 0: pl1 serving 1: pl2 serving
    signal serve: std_logic;

    -- game state
    -- state: 
    -- s0 -> wait serving
    -- s1 -> left move
    -- s2 -> right move
    signal pos: std_logic_vector(7 downto 0);
    type ball_state is (s0, s1, s2);
    signal state: ball_state;

begin
    -- clk divider OK
    freq_clk <= freq(23);
    freq_div: process (clk_100MHz_in, reset_in, freq)
    begin
        if reset_in = '1' then
            freq <= (others => '0');
        elsif clk_100MHz_in 'event and clk_100MHz_in = '1' then
            freq <= freq + '1';
        end if;
    end process;

    -- control start OK
    ctrl_start: process (clk_100MHz_in, reset_in, sw_start, start)
    begin
        if reset_in = '1' then
            start <= '0';
        elsif sw_start = '1' then
            start <= '1';
        else
            start <= '0';
        end if;
    end process;

    -- data read/write
    data_rw: process (clk_100MHz_in, reset_in, sda_rw, sda, receive_reg)
    begin
        if reset_in = '1' then
            sda <= 'Z';
            receive_reg <= (others => '0');

        elsif clk_100MHz_in 'event and clk_100MHz_in = '1' then
            if sda_rw = '0' and stop = '0' then
                sda <= 'Z';
                receive_reg(bit_count) <= sda;
            end if;
        end if;
    end process;

    -- control the timing of sending and receiving data
    bit_counter: process (clk_100MHz_in, reset_in, bit_count, sda_rw)
    begin
        if reset_in = '1' then
            bit_count <= 0;

        elsif clk_100MHz_in 'event and clk_100MHz_in = '1' then
            if sda_rw = '0' and stop = '0' then
                if bit_count < 8 then
                    bit_count <= bit_count + 1;
                else
                    bit_count <= 0;
                end if;
            end if;
        end if;
    end process; 

    -- control stop
    ctrl_stop: process (clk_100MHz_in, reset_in, bit_count, sda_rw, stop, ball_count)
    begin
        if reset_in = '1' then
            stop <= '0';

        elsif clk_100MHz_in 'event and clk_100MHz_in = '1' then
            if sda_rw = '0' and bit_count = 0 and receive_reg(ball_count) = '1' then
                stop <= '1';
            else
                stop <= '0';
            end if;
        
        end if;
    end process;

    -- operator
    FSM: process (freq_clk, reset_in, serve, start, sda_rw, ball_count)
    begin
        if reset_in = '1' then
            serve <= '0';
            state <= s0;
            sda_rw <= '0';
            ball_count <= 0;

        elsif freq_clk 'event and freq_clk = '1' and start = '1' and reset_in = '0' then
            case state is
                when s0 =>
                    if serve = '0' then
                        sda_rw <= '0';
                        ball_count <= 0;
                        
                        if receive_reg(7) = '1' then
                            state <= s1;
                        else
                            state <= s0;
                        end if;
                    end if;
                    
                when s1 =>
                    pos <= receive_reg(7 downto 0);
                    ball_count <= ball_count + 1;
                    state <= s1;
                    
                when s2 =>
                    null;
                when others =>
                    null;
            end case;
        end if;
    end process;

    -- control led out
    led_out: process(freq_clk, reset_in, sda_rw)
    begin
        if reset_in = '1' then
            ledout <= (others => '0');
        elsif freq_clk 'event and freq_clk = '1' and reset_in = '0' then
            if sda_rw = '0' and start = '1' then
                ledout <= pos;
            else
                ledout <= "11001100";
            end if;
        end if;
    end process;

end behavioral ; -- behavioral
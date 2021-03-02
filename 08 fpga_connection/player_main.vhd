library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity i2c_myself is
    port(
        clk_100MHz: in std_logic;
        reset: in std_logic;
        sw_start: in std_logic;
        pl1: in std_logic;
        sda: inout std_logic;
        ledout: out std_logic_vector(7 downto 0);

        scl_out: out std_logic;
        reset_out: out std_logic
    );
end entity;

architecture behavioral of i2c_myself is
    -- clk divider
    signal freq: std_logic_vector(25 downto 0);
    signal freq_clk: std_logic;

    -- control start
    signal start: std_logic;

    -- control read or write
    -- 0: read 1: write
    signal sda_rw: std_logic;

    -- send and receive value
    signal count: integer;
    signal send_reg: std_logic_vector(7 downto 0);
    signal receive_reg: std_logic_vector(7 downto 0);

    -- control serving
    -- 0: pl1 serving 1: pl2 serving
    signal serve: std_logic;

    -- game state
    signal pos: std_logic_vector(7 downto 0);
    type ball_state is (s0, s1, s2);
    signal state: ball_state;

begin
    -- send clock and reset signal 
    scl_out <= clk_100MHz;
    reset_out <= reset;

    -- clk divider
    freq_clk <= freq(22);
    freq_div: process (clk_100MHz, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk_100MHz 'event and clk_100MHz = '1' then
            freq <= freq + '1';
        end if;
    end process;

    -- control start
    ctrl_start: process (clk_100MHz, reset, sw_start, start)
    begin
        if reset = '1' then
            start <= '0';
        elsif sw_start = '1' then
            start <= '1';
        else
            start <= '0';
        end if;
    end process;

    -- data read/write
    data_rw: process (clk_100MHz, reset, sda_rw, sda, receive_reg, send_reg)
    begin
        if reset = '1' then
            sda <= 'Z';

        elsif clk_100MHz 'event and clk_100MHz = '1' then
            if sda_rw = '1' then
                send_reg <= pos;
                sda <= send_reg(count);
                
            elsif sda_rw = '0' then
                sda <= 'Z';
                receive_reg(count) <= sda;
            end if;
        end if;
    end process;

    -- control the timing of sending and receiving data
    counter: process (clk_100MHz, reset, count, sda_rw)
    begin
        if reset = '1' then
            count <= 0;

        elsif clk_100MHz 'event and clk_100MHz = '1' then
            if sda_rw = '1' then
                if count < 8 then
                    count <= count + 1;
                else
                    count <= 0;
                end if;

            elsif sda_rw = '0' then
                if count >= 0 then
                    count <= count - 1;
                else
                    count <= 7;
                end if;
            end if;
        end if;
    end process; 

    -- operator
    FSM: process (freq_clk, reset, pos, serve, start, sda_rw)
    begin
        if reset = '1' then
            pos <= (others => '0');
            serve <= '0';
            state <= s0;
            sda_rw <= 'Z';

        elsif freq_clk 'event and freq_clk = '1' and start = '1' then
            case state is
                when s0 =>
                    if serve = '0' then
                        pos <= "00000001";
                        sda_rw <= '1';
                        if pl1 = '1' then
                            state <= s1;
                        else
                            state <= s0;
                        end if;
                    end if;
                    
                when s1 =>
                    pos <= pos(6 downto 0) & '0';
                    
                when s2 =>
                    null;
                when others =>
                    null;
            end case;
        end if;
    end process;

    -- control led out
    led_out: process(freq_clk, reset, sda_rw)
    begin
        if reset = '1' then
            ledout <= "01010101";
        elsif freq_clk 'event and freq_clk = '1' then
            if sda_rw = '1' then
                ledout <= pos;
            elsif sda_rw = '0' then
                ledout <= receive_reg;
            else
                ledout <= "11110000";
            end if;
        end if;
    end process;

end behavioral ; -- behavioral
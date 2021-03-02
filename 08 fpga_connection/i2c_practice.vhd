library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity i2c_practice is 
    port(
        reset: in std_logic;
        scl: in std_logic;
        sda: inout std_logic;
        dout: out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of i2c_practice is
    signal dout_reg: std_logic_vector(7 downto 0);
    signal state: std_logic_vector(1 downto 0);  -- "00" iddle state
    signal shift_reg: std_logic_vector(8 downto 0);
    signal sda_in, start, start_rst, stop, active, ack: std_logic;
begin
    -- start condition detection method 1
    process (sda_in, start_rst)
    begin
        if start_rst = '1' then
            start <= '0';
        elsif sda_in 'event and sda_in = '0' then
            start <= scl;
        end if;
    end process;

    process (scl, start, stop)
    begin
        if scl 'event and scl = '0' then
            start_rst <= start;
        end if;
    end process;

    -- start condition detection method 2
    process (reset, scl, sda_in)
    begin
        if reset = '0' then
            start <= '0';
        elsif scl = '1' and sda_in = '0' and sda_in 'event then
            start <= '1';
        end if;
    end process;

    -- stop condition detection
    process (reset, scl, sda_in, start)
    begin
        if reset = '0' or scl = '0' or start = '1' then
            stop <= '0';
        elsif scl = '1' and sda_in 'event and sda_in = '1' then
            stop <= '1';
        end if;
    end process;

    -- active communication signal 
    process (reset, stop, start)
    begin
        if reset = '0' or stop = '1' then
            active <= '0';
        elsif start 'event and start = '0' then
            active <= '1';
        end if;
    end process;

    -- RX data shifter 
    process (reset, active, ack, scl, sda_in)
    begin
        if reset = '0' or active = '0' then
            shift_reg <= "000000001";
        elsif scl 'event and scl = '1' then
            if ack = '1' then
                shift_reg <= "000000001";
            else
                shift_reg <= shift_reg(7 downto 0) & sda_in;
            end if;
        end if;
    end process;

    -- i2c data read
    process (reset, state, ack, shift_reg)
    begin
        if reset = '0' then
            dout_reg <= (others => '0');
        elsif state = "11" and ack 'event and ack = '1' then
            dout_reg <= shift_reg(7 downto 0);
        end if;
    end process;

    -- ack
    process (reset, scl, shift_reg, state, active)
    begin
        if reset = '0' or active = '0' then
            ack <= '0';
            state <= "00";
        elsif scl 'event scl = '0' then
            if shift_reg(8) = '1' and state /= "11" then
                state <= state + '1';
                case state is
                    when "00" =>
                        if shift_reg(7 downto 0) = DADDR & WR then
                            ack <= '1';
                        end if;
                    
                    when "01" => 
                        if shift_reg(7 downto 0) = ADDR then
                            ack <= '1';
                        end if;
                    
                    when "10" =>
                        ack <= '1';
                    when others => 
                        state <= "11";
                end case;
            else
                ack <= '0';
            end if;
    end process;

    -- ack responce
    sda_in <= sda;
    sda <= '0' when ack = '1' else 'Z';

    -- result
    dout <= dout_reg;

end behavioral; 
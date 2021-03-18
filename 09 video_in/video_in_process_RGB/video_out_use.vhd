library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity video_out_use is
    port(
        reset: in std_logic;  -- reset switch  
        mode_sw: in std_logic;  -- mode switch  
        clk_100MHz: in std_logic; -- FPGA internal clk

        -- video_clk: in std_logic; -- clk divider??
        video_sda: inout std_logic;  -- data transmission
        video_scl: inout std_logic;  -- data clk transmission
        -- video_data_i2c: in std_logic_vector(7 downto 0);  -- need to send the value to video_out.vhd. i2c??


        r: out std_logic_vector(7 downto 0);
        g: out std_logic_vector(7 downto 0);
        b: out std_logic_vector(7 downto 0);
        -- rgb_out: out std_logic_vector(7 downto 0);
        led: out std_logic -- what is it do?
        -- hsync: out std_logic;
        -- vsync: out std_logic
    );
end entity;

architecture behavioral of video_out_use is
    component video_out
        port(
            reset: in std_logic;
            mode_sw: in std_logic;
            video_clk: in std_logic;
            video_sda: inout std_logic;
            video_scl: inout std_logic;
            video_data_i2c: in std_logic_vector(7 downto 0);
    
            rgb_out: out std_logic_vector(7 downto 0);
            led1: out std_logic;
            hsync: out std_logic;
            vsync: out std_logic
        );
    end component;

    -- temporarily
    -- receive from video_out.vhd
    signal rgb_receive: std_logic_vector(7 downto 0); -- grayscale
    signal hsync: std_logic;
    signal vsync: std_logic;
    signal led1: std_logic;

    -- output to video_out.vhd
    signal video_clk: std_logic;
    signal video_data_i2c: std_logic_vector(7 downto 0);

begin
    port_map: video_out
    port Map(
        reset => reset,

        mode_sw => mode_sw,

        video_clk => video_clk,
        video_sda => video_sda,
        video_scl => video_scl,
        video_data_i2c => video_data_i2c,

        vsync => vsync,
        hsync => hsync,
        led1 => led1,
        rgb_out => rgb_receive
    );

    -- temporarily
    led <= led1;
    video_clk <= freq(0);  -- screen scan time: 50MHz

    clk_div: process (clk_100MHz, reset, freq)
    begin
        if reset = '0' then
            freq <= (others => '0');
        elsif clk_100MHz 'event and clk_100MHz = '1' then
            freq <= freq + '1';
        end if;
    end process;

    video_output: process (whick clk, reset, *anysignal)
    begin
        if reset = '0' then
            null;
        elsif (which clk) 'event and (which clk) = '1' then
            null;
        end if;
    end process;

    display: process(video_clk, reset, rgb_receive, *anysignal)
    begin
        if reset = '0' then
            r <= (others => '0');
            g <= (others => '0');
            b <= (others => '0');

        elsif video_clk 'event and video_clk = '1' then
            -- screen scanner: hsync, vsync ??
            if mode_sw = '1' then
                r <= rgb_receive;
                g <= rgb_receive;
                b <= rgb_receive;
            else
                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');
            end if;
        end if;
    end process;

end behavioral;
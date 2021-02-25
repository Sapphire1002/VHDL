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
    
    -- send pos 
    signal pos: std_logic_vector(7 downto 0);
    type play_state is (s0, s1, s2);
    signal ball_state: play_state; 

    signal count: integer;
    signal serve: std_logic;
    signal pl2: std_logic;

begin
    freq_clk <= freq(22);
    led <= pos(7 downto 0);

    freq_div: process (clk, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
    end process;
   
    trans_data: process(clk, reset, pl2, pos, serve, count)
    begin
        if reset = '1' then
            null;
        
        elsif clk 'event and clk = '1' then
            if serve = '0' then
                if count = 8 then
                    data <= '1'; 
                else
                    pl2 <= data;
                end if;

            elsif serve = '1' then
                if count /= 8 then
                    data <= pl1; 
                else
                    pl2 <= data;
                end if;
            end if;
        end if;
    end process;

    FSM: process (freq_clk, reset, ball_state, pl2, pos, serve, count)
    begin
        if reset = '1' then
            ball_state <= s0;
            serve <= '0';
            count <= 0;

        elsif freq_clk 'event and freq_clk = '1' then
            case ball_state is
                when s0 =>
                   if serve = '0' then
                        pos <= "00000001";
                        count <= 0;

                        if pl1 = '1' then
                            ball_state <= s1;
                        else
                            ball_state <= s0;
                        end if;
                    
                    elsif serve = '1' then
                        pos <= "00000000";
                        count <= 7;

                        if pl2 = '1' then
                            ball_state <= s2;
                        else
                            ball_state <= s0;
                        end if;
                    end if;
                
                when s1 => 
                    -- if pl2 = '1' and pos(7) = '0' then
                    --     serve <= '0';
                    --     ball_state <= s0;
                    
                    -- elsif pl2 = '0' and pos(7) = '1' then
                    --     serve <= '0';
                    --     ball_state <= s0;
                    
                    -- elsif pl2 = '1' and pos(7) = '1' then
                    --     ball_state <= s2;
                    
                    -- else
                        pos <= pos(6 downto 0) & '0';
                        count <= count + 1;
                        ball_state <= s1;
                    -- end if;
                
                when s2 =>
                    -- if pl1 = '1' and pos(0) = '0' then
                    --     serve <= '1';
                    --     ball_state <= s0;
                    
                    -- elsif pl1 = '0' and pos(0) = '1' then
                    --     serve <= '1';
                    --     ball_state <= s0;
                    
                    -- elsif pl1 = '1' and pos(0) = '1' then
                    --     ball_state <= s1;
                    
                    -- else
                        pos <= pos(7 downto 1) & '0';
                        count <= count - 1;
                        ball_state <= s2;
                    -- end if;
                
                when others =>
                    null;
            end case;
        end if;
    end process;

end behavioral;

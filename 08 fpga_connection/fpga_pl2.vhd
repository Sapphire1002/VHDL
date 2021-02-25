library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fpga_pl2 is
    port(
        clk_in: in std_logic;
        reset_in: in std_logic;

        pl2: in std_logic;
        data: inout std_logic;
        led: out std_logic_vector(7 downto 0)

    );
end entity;
-- receive pos & send pl2 btn value
-- receive pl1 btn value ?


architecture behavioral of fpga_pl2 is
    signal pos: std_logic_vector(15 downto 0);
    signal trans_state is (s0, s1, s2);
    signal io_state: trans_state;

    signal play_state is (s0, s1, s2);
    signal ball_state: play_state; 
    signal serve: std_logic;

begin
    led <= pos(15 downto 7);

    receive: process(clk_in, reset_in)
    begin
        if reset_in = '1' then
            state <= s0;
            serve <= '0';

        elsif clk_in 'event and clk_in = '1' then
            case ball_state is
                when s0 =>
                   if serve = '0' then
                        pos <= "0000000000000001";
                        if pl1 = '1' then
                            state <= s1;
                        else
                            state <= s0;
                        end if;
                    
                    elsif serve = '1' then
                        pos <= "1000000000000000";
                        if pl2 = '1' then
                            state <= s2;
                        else
                            state <= s0;
                        end if;
                    end if;
                
                when s1 => 
                    if pl2 = '1' and pos(15) = '0' then
                        serve <= '0';
                        state <= s0;
                    
                    elsif pl2 = '0' and pos(15) = '1' then
                        serve <= '0';
                        state <= s0;
                    
                    elsif pl2 = '1' and pos(15) = '1' then
                        state <= s2;
                    
                    else
                        pos <= pos(14 downto 0) & pos(15);
                        state <= s1;
                    end if;
                
                when s2 =>
                    if pl1 = '1' and pos(0) = '0' then
                        serve <= '1';
                        state <= s0;
                    
                    elsif pl1 = '0' and pos(0) = '1' then
                        serve <= '1';
                        state <= s0;
                    
                    elsif pl1 = '1' and pos(0) = '1' then
                        state <= s1;
                    
                    else
                        pos <= pos(15 downto 1) & pos(0);
                        state <= s2;
                    end if;
                
                when others =>
                    null;
            end case;
        end if;
    end process;
end behavioral;
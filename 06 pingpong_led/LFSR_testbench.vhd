library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity LFSR_testbench is
end entity;

architecture bench of LFSR_testbench is
    component LFSR_practice
        port(
            clk, reset: in std_logic;
            Q: out std_logic_vector(2 downto 0);
            check: out std_logic
        );
    end component;

    signal clk1: std_logic;
    signal rst1: std_logic;
    signal Q1: std_logic_vector(2 downto 0);
    signal check1: std_logic;

begin
    mapping: LFSR_practice port map(
        clk => clk1,
        reset => rst1,
        Q => Q1,
        check => check1
    );

    clock: process
    begin
        clk1 <= '0';
        wait for 50ns;
        clk1 <= '1';
        wait for 50ns;
    end process;

    reset: process
    begin
        rst1 <= '0';
        wait for 1000ns;
        rst1 <= '1';
        wait for 10ns;
    end process;

end bench;
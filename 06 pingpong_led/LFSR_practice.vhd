library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity LFSR_practice is
    port(
        clk, reset: in std_logic;
        Q: out std_logic_vector(2 downto 0);
        check: out std_logic
    );
end entity;

architecture Behavioral of LFSR_practice is
    
    signal temp: std_logic := '0';
    signal Qt: std_logic_vector(2 downto 0) := "001";

begin
    check <= Qt(2);
    Q <= Qt;
    process(clk, reset, Qt, temp)
    begin 
        if reset = '1' then
            Qt <= "001";
        elsif clk 'event and clk = '1' then
            temp <= Qt(2) xor Qt(1);
            Qt(2) <= Qt(1);
            Qt(1) <= Qt(0);
            Qt(0) <= temp;
        end if;
    end process;
end Behavioral;
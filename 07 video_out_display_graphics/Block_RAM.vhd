LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity Block_RAM is
    Port ( 
        clk_100Mhz : IN STD_LOGIC;
        reset_n	:	IN	STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 downto 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end Block_RAM;


architecture Behavioral of Block_RAM is
signal addra: std_logic_vector(7 downto 0);

signal ena : std_logic;

component BRAM_test is
	port(
	    clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
end component BRAM_test; 

begin

PROCESS(clk_100Mhz, reset_n) 
	BEGIN
		IF(reset_n = '1') THEN
            addra <= "00000000";
            ena <= '1';
		elsif(clk_100Mhz'EVENT AND clk_100Mhz = '1') THEN
            
		end if;
	End PROCESS;

u0:BRAM_test
    port map(      
        clka => clk_100Mhz,     
        ena => ena,
        wea => wea,
        addra => addra,
        dina => dina,
        douta => douta
    );

end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga_display_picture is 
    port(
        clk, reset: in std_logic;
        wea: in std_logic;
        dina: in std_logic_vector(7 downto 0);
        douta: out std_logic_vector(7 downto 0);
        h_sync, v_sync: out std_logic
    );
end entity;

architecture behavioral of vga_display_picture is
    --define timing
    constant HD: integer := 800;
    constant HF: integer := 56;
    constant HB: integer := 64;
    constant HS: integer := 120;
    constant HT: integer := HD + HF + HB + HS;

    constant VD: integer := 600;
    constant VF: integer := 37;
    constant VB: integer := 23;
    constant VS: integer := 6;
    constant VT: integer := VD + VF + VB + VS;

    -- clk divider
    signal freq: std_logic_vector(21 downto 0);
    signal clk_div: std_logic;
    signal clk_freq: std_logic;

    -- scan
    signal h_pol: std_logic := '0';
    signal v_pol: std_logic := '0';

    -- Block RAM
    signal addra: std_logic_vector(7 downto 0);
    signal ena: std_logic;

    component BRAM is
        port(
            clka: in std_logic;
            ena: in std_logic;
            wea: in std_logic_vector(0 downto 0);
            addra: in std_logic_vector(7 downto 0);
            dina: in std_logic_vector(7 downto 0);
            douta: out std_logic_vector(7 downto 0)
        );
    end component;

begin
    clk_divider: process (clk, reset, freq)
    begin
        if reset = '1' then
            clk_div <= '0';
        elsif clk 'event and clk = '1' then
            clk_div <= not clk_div;
        end if;
    end process;

    scanner: process (clk_div, reset)
        -- horizontal/vertical counter
        variable h_count: integer range 0 to HT - 1 := 0;
        variable v_count: integer range 0 to VT - 1 := 0;
        
    begin
        if reset = '1' then
            h_sync <= not h_pol;
            v_sync <= not v_pol;
            h_count := 0;
            v_count := 0;
        
        elsif clk_div 'event and clk_div = '1' then
            -- counter
            if h_count < HT - 1 then
                h_count := h_count + 1;
            else
                h_count := 0;
                if v_count < VT - 1 then
                    v_count := v_count + 1;
                else
                    v_count := 0;
                end if;
            end if;

            -- horizontal sync
            if h_count < HD + HF or h_count >= HD + HF + HS then
                h_sync <= not h_pol;
            else
                h_sync <= h_pol;
            end if;

            -- veritial sync
            if v_count < VD + VF or v_count >= VD + VF + VS then
                v_sync <= not v_pol;
            else
                v_sync <= v_pol;
            end if;

        end if;
    end process;

end behavioral;
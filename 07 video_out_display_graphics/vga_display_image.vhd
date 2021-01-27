library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga_display_image is 
    generic(
        wid: integer := 3;
        depth: integer := 16384;
        addr: integer := 14
    );
    port(
        clk, reset: in std_logic;
        h_sync, v_sync: out std_logic;
        r, g, b: out std_logic
    );
end entity;

architecture behavioral of vga_display_image is
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

    -- scan
    signal h_pol: std_logic := '0';
    signal v_pol: std_logic := '0';
    
    -- horizontal/vertical counter
    signal h_count: integer range 0 to HT - 1 := 0;
    signal v_count: integer range 0 to VT - 1 := 0;

    -- ROM
    signal addra: std_logic_vector(addr-1 downto 0);
    signal douta: std_logic_vector(wid-1 downto 0);

    component ROM is
        port(
            clka: in std_logic;
            ena: in std_logic;
            addra: in std_logic_vector(addr-1 downto 0);
            douta: out std_logic_vector(wid-1 downto 0)
        );
    end component;

begin

    clk_divider: process (clk, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
        clk_div <= freq(0);
    end process;

    uut: ROM
    port map(
        clka => clk_div,
        ena => '1',
        addra => addra,
        douta => douta
    );

    scanner: process (clk_div, reset)    
    begin
        if reset = '1' then
            h_sync <= not h_pol;
            v_sync <= not v_pol;
            h_count := 0;
            v_count := 0;
            addra <= (others => '0');
        
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
            
            -- display image
            if h_count > 400 and h_count <= 528 and v_count > 250 and v_count <= 378 then
                addra <= addra + '1';
                r <= douta(0);
                g <= douta(1);
                b <= douta(2);
            elsif conv_integer(addra) + 1 >= depth then
                addra <= (others => '0');
            end if;
        end if;
    end process;
end behavioral;
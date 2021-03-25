library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga is
    generic (
        horizontal_resolution : integer := 800 ;
        horizontal_Front_porch: integer :=  56 ;
        horizontal_Sync_pulse : integer := 120 ;
        horizontal_Back_porch : integer := 64 ;
        h_sync_Polarity         :std_logic:= '1' ;
        vertical_resolution   : integer := 600 ;
        vertical_Front_porch  : integer :=  37 ;
        vertical_Sync_pulse   : integer :=   6 ;
        vertical_Back_porch   : integer :=  23 ;
        v_sync_Polarity         :std_logic:= '1' 
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        video_start_en : in std_logic;
        vga_hs_cnt : out integer;
        vga_vs_cnt : out integer;
        hsync : out std_logic;
        vsync : out std_logic
    );

end vga;

architecture Behavioral of vga is

signal freq: std_logic;
signal vga_hs_cnt_s : integer;
signal vga_vs_cnt_s : integer;

begin

--�����T������~��----
vga_hs_cnt <= vga_hs_cnt_s;
vga_vs_cnt <= vga_vs_cnt_s;
------------------

freq_div: process (clk, rst, freq)
begin
    if rst = '0' then
        freq <= '0';
    elsif clk 'event and clk = '1' then
        freq <= not freq;
    end if;
end process;

--vga h �p��
h_cnt : process(freq ,rst, vga_hs_cnt_s ,video_start_en)
begin
    if rst = '0' then
         vga_hs_cnt_s <= 0;
    elsif video_start_en = '1' then 
         if rising_edge(freq) then
             if vga_hs_cnt_s < (horizontal_resolution + horizontal_Front_porch + horizontal_Sync_pulse + horizontal_Back_porch) then
                 vga_hs_cnt_s <= vga_hs_cnt_s + 1;
             else
                 vga_hs_cnt_s <= 0;
             end if;
         end if;
    else
        vga_hs_cnt_s <= 0;
    end if;
end process;
--vga v �p��
v_cnt : process(freq , rst , vga_hs_cnt_s ,vga_vs_cnt_s,video_start_en)
begin
    if rst = '0' then
         vga_vs_cnt_s <= 0;
    elsif video_start_en = '1' then 
         if rising_edge(freq) then
              if vga_hs_cnt_s = (horizontal_resolution + horizontal_Front_porch + horizontal_Sync_pulse + horizontal_Back_porch) then
                  if vga_vs_cnt_s < (vertical_resolution + vertical_Front_porch + vertical_Sync_pulse + vertical_Back_porch) then
                        vga_vs_cnt_s <= vga_vs_cnt_s + 1;
                  else
                        vga_vs_cnt_s <= 0;
                  end if;
              end if;
         end if;
    else
        vga_vs_cnt_s <= 0;
    end if;
end process;

-- h sync
h_sync : process(freq , vga_hs_cnt_s,rst,video_start_en)
begin
if rst = '0' then
    hsync <= '1';
else
    if freq'event and freq = '1' then
        if video_start_en = '1' then
            if vga_hs_cnt_s >= (horizontal_resolution + horizontal_Front_porch) and vga_hs_cnt_s < (horizontal_resolution + horizontal_Front_porch + horizontal_Sync_pulse) then
                hsync <=     h_sync_Polarity;
            else
                hsync <= not h_sync_Polarity;
            end if;
        end if;
    end if;
end if;
end process;

-- v sync
v_sync : process(freq ,rst,vga_vs_cnt_s,video_start_en)
begin
if rst = '0' then
    vsync <= '1';
else
    if freq'event and freq = '1' then
        if video_start_en = '1' then
            if vga_vs_cnt_s >= (vertical_resolution + vertical_Front_porch) and vga_vs_cnt_s < (vertical_resolution + vertical_Front_porch + vertical_Sync_pulse) then
               vsync <=     v_sync_Polarity;
            else       
               vsync <= not v_sync_Polarity;
            end if;
        end if;
    end if;
end if;
end process;

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga_display_picture is 
    generic(
        wid: integer := 8;
        depth: integer := 5000;
        addr: integer := 13
    );
    port(
        clk, reset: in std_logic;
        start: in std_logic;
        h_sync, v_sync: out std_logic;
        left_up, left_down, right_up, right_down: in std_logic;
        r, g, b: out std_logic
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
    signal clk_ball: std_logic;

    -- scan
    signal h_pol: std_logic := '0';
    signal v_pol: std_logic := '0';

    -- ROM
    signal addra: std_logic_vector(addr-1 downto 0);
    signal douta: std_logic_vector(wid-1 downto 0);
    signal ena: std_logic;

    -- ball size
    constant radius: integer := 50;

    -- left/right board horizontal
    constant left_x1: integer := 30;
    constant left_x2: integer := 40;
    constant right_x1: integer := 760;
    constant right_x2: integer := 770;
    constant board_length: integer := 200;
    constant mid: integer := 100;
    constant hori: integer := 10;
    
    -- send value
    signal ball_ox: std_logic_vector(9 downto 0);
    signal ball_oy: std_logic_vector(9 downto 0);
    signal sides: std_logic_vector(1 downto 0) := "00";
    signal board_left: std_logic_vector(9 downto 0);
    signal board_right: std_logic_vector(9 downto 0);

    component ROM is
        port(
            clka: in std_logic;
            ena: in std_logic;
            addra: in std_logic_vector(addr-1 downto 0);
            douta: out std_logic_vector(wid-1 downto 0)
        );
    end component;

begin

    uut: ROM
    port map(
        clka => clk,
        ena => ena,
        addra => addra,
        douta => douta
    );

    clk_divider: process (clk, reset, freq)
    begin
        if reset = '1' then
            freq <= (others => '0');
        elsif clk 'event and clk = '1' then
            freq <= freq + '1';
        end if;
        clk_div <= freq(0);
        clk_ball <= freq(19);
    end process;

    scanner: process (clk_div, reset)
        -- horizontal/vertical counter
        variable h_count: integer range 0 to HT - 1 := 0;
        variable v_count: integer range 0 to VT - 1 := 0;

        -- receive ball coordinate
        variable ox, oy: integer;
        -- point to center distance
        variable rx, ry: integer;

        -- receive board coordinate
        variable left, right: integer;
        
    begin
        if reset = '1' then
            h_sync <= not h_pol;
            v_sync <= not v_pol;
            h_count := 0;
            v_count := 0;
            addra <= (others => '0');
            ena <= '1';
        
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
            
            ox := conv_integer(ball_ox);
            oy := conv_integer(ball_oy);
            rx :=  h_count - ox;
            ry :=  v_count - oy;
            left := conv_integer(board_left);
            right := conv_integer(board_right);

            -- display left board
            if (h_count > left_x1 and h_count <= left_x2 and  v_count > left and  v_count <= left + board_length) then
                r <= '0';
                g <= '1';
                b <= '0';
            -- display right board
            elsif (h_count > right_x1 and h_count <= right_x2 and  v_count > right and  v_count <= right + board_length) then
                r <= '0';
                g <= '0';
                b <= '1';
            -- display ball
            elsif (rx * rx + ry * ry <= radius * radius) then
                if (sides(0) = '1') then
                    r <= '1';
                    g <= '0';
                    b <= '0';
                else
                    r <= '1';
                    g <= '1';
                    b <= '0';
                end if;
            else
                r <= '0';
                g <= '0';
                b <= '0';
            end if;
        end if;
    end process;

    process (clk_ball, reset, start, left_up, left_down, right_up, right_down)
        -- ball initial coordinate
        variable ball_x: integer := 400;
        variable ball_y: integer := 300;
        -- state: 0 stop, 1 upper left, 2 lower left, 3 upper right, 4 lower right, 5 left to right, 6 right to left
        variable ball_state: integer := 0;
        variable ball_side: integer := 0;
        -- ball contact range
        variable y1, y2: integer;

        -- left/right board vertical
        variable left_y1: integer := 225;
        variable right_y1: integer := 225;
        -- state: 0 stop, 1 upper, 2 down
        variable left_state: integer := 0;
        variable right_state: integer := 0;

    begin
        if (reset = '1') then
            ball_x := 400;
            ball_y := 300;
            ball_state := 3;
            ball_side := 0;
            y1 := 0;
            y2 := 0;

            left_y1 := 225;
            right_y1 := 225;
            left_state := 0;
            right_state := 0;
        
        elsif (clk_ball 'event and clk_ball = '1') then
            -- Determine if the ball hits the boundary or the board
            if (ball_y + radius > 599) then
                ball_state := ball_state - 1;
            elsif (ball_y - radius <= 0) then
                ball_state := ball_state + 1;
            end if;

            y1 := ball_y - radius;
            y2 := ball_y + radius;

            -- use circle center point
            -- left board 3 conditions
            if (ball_x - radius = left_x2 and ball_y > left_y1 + mid - hori and ball_y <= left_y1 + mid + hori) then
                ball_state := 5;
            elsif (ball_x - radius = left_x2 and y2 > left_y1 and y1 <= left_y1 + mid) then
                ball_state := 3;
            elsif (ball_x - radius = left_x2 and y2 > left_y1 + mid and y1 <= left_y1 + board_length) then
                ball_state := 4;
            -- right board 3 conditions
            elsif (ball_x + radius = right_x1 and ball_y > right_y1 + mid - hori and ball_y <= right_y1 + mid + hori) then
                ball_state := 6;
            elsif (ball_x + radius = right_x1 and y2 > right_y1 and y1 <= right_y1 + mid) then
                ball_state := 1;
            elsif (ball_x + radius = right_x1 and y2 > right_y1 + mid and y1 <= right_y1 + board_length) then
                ball_state := 2;
            -- the ball hits the boundary of one side(left and right)
            elsif (ball_x - radius = 0 or ball_x + radius = 800) then
                ball_state := 0;
                ball_side := 1;
            end if;
            
            -- ball move
            if (ball_state = 1) then
                ball_x := ball_x - 1;
                ball_y := ball_y - 1;
            elsif (ball_state = 2) then
                ball_x := ball_x - 1;
                ball_y := ball_y + 1;
            elsif (ball_state = 3) then
                ball_x := ball_x + 1;
                ball_y := ball_y - 1;
            elsif (ball_state = 4) then
                ball_x := ball_x + 1;
                ball_y := ball_y + 1;
            elsif (ball_state = 5) then
                ball_x := ball_x + 1;
            elsif (ball_state = 6) then
                ball_x := ball_x - 1;
            end if;

            -- Determine whether the board exceeds the boundary
            if (left_up = '1') then
                if (left_y1 <= 1) then
                    left_state := 0;
                else
                    left_state := 1;
                end if;
            elsif (left_down = '1') then
                if (left_y1 + board_length >= 599) then
                    left_state := 0;
                else
                    left_state := 2;
                end if;
            else
                left_state := 0;
            end if;

            if (right_up = '1') then
                if (right_y1 <= 1) then
                    right_state := 0;
                else
                    right_state := 1;
                end if;
            elsif (right_down = '1') then
                if (right_y1 + board_length >= 599) then
                    right_state := 0;
                else
                    right_state := 2;
                end if;
            else
                right_state := 0;
            end if;

            -- board move
            if (left_state = 1) then
                left_y1 := left_y1 + 2;
            elsif (left_state = 2) then
                left_y1 := left_y1 - 2;
            end if;

            if (right_state = 1) then
                right_y1 := right_y1 + 2;
            elsif (right_state = 2) then
                right_y1 := right_y1 - 2;
            end if;

        end if;
        
        sides <= conv_std_logic_vector(ball_side, 2);
        ball_ox <= conv_std_logic_vector(ball_x, 10);
        ball_oy <= conv_std_logic_vector(ball_y, 10);
        board_left <= conv_std_logic_vector(left_y1, 10);
        board_right <= conv_std_logic_vector(right_y1, 10);

    end process;

end behavioral;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga_image_pingpong is 
    generic(
        wid: integer := 3;
        depth: integer := 16384;
        addr: integer := 14
    );
    port(
        clk, reset: in std_logic;
        start: in std_logic;
        left_up, left_down: in std_logic;
        right_up, right_down: in std_logic;
        h_sync, v_sync: out std_logic;
        r, g, b: out std_logic
    );
end entity;

architecture behavioral of vga_image_pingpong is
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

    -- image size
    constant length: integer := 128;
    constant height: integer := 128;
    
    -- board size
    constant board_width: integer := 10;
    constant board_length: integer := 200;

    -- image upper left corner coordinates
    signal image_left_x: integer;
    signal image_right_y: integer;

    -- board upper left corner coordinates
    constant board_left_x: integer := 30;
    constant board_right_x: integer := 740;

    -- board upper right corner coordinates
    signal board_left_y: integer := 100;
    signal board_right_y: integer := 100;

    -- play clk
    signal clk_ball: std_logic;

    -- clk divider
    signal freq: std_logic_vector(25 downto 0);
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

    -- reg
    -- signal img_b: std_logic_vector(depth-1 downto 0);
    -- signal img_g: std_logic_vector(depth-1 downto 0);
    -- signal img_r: std_logic_vector(depth-1 downto 0);
    -- signal pos: integer;

    -- FSM state
    type type_states is (s0, up_left, down_left, up_right, down_right);
    signal ball_state: type_states;
    

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
        clk_ball <= freq(20);
    end process;

    uut: ROM
    port map(
        clka => clk_div,
        ena => '1',
        addra => addra,
        douta => douta
    );

    -- read_value: process (clk_div, reset, img_r, img_b, img_b)
    -- begin
    --     if reset = '1' then
    --         addra <= (others => '0');
    --         img_r <= (others => '0');
    --         img_g <= (others => '0');
    --         img_b <= (others => '0');
        
    --     elsif clk_div 'event and clk_div = '1' then
    --         addra <= addra + '1';
    --         img_r(conv_integer(addra)) <= douta(0);
    --         img_g(conv_integer(addra)) <= douta(1);
    --         img_b(conv_integer(addra)) <= douta(2);

    --     end if;
    -- end process;


    scanner: process (clk_div, reset)
    begin
        if reset = '1' then
            h_sync <= not h_pol;
            v_sync <= not v_pol;
            h_count <= 0;
            v_count <= 0;
--            pos <= 0;
        
        elsif clk_div 'event and clk_div = '1' then
            -- counter
            if h_count < HT - 1 then
                h_count <= h_count + 1;
            else
                h_count <= 0;
                if v_count < VT - 1 then
                    v_count <= v_count + 1;
                else
                    v_count <= 0;
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
            
            -- display leftboard
            if h_count > board_left_x and h_count <= board_left_x + board_width and v_count > board_left_y and v_count <= board_left_y + board_length then
                r <= '0';
                g <= '1';
                b <= '0';

            -- display rightboard
            elsif h_count > board_right_x and h_count <= board_right_x + board_width and v_count > board_right_y and v_count <= board_right_y + board_length then
                r <= '0';
                g <= '0';
                b <= '1';

            -- display image
            elsif h_count >= image_left_x and h_count < image_left_x + length and v_count >= image_right_y and v_count < image_right_y + height then
                addra <= addra + '1';
                r <= douta(0);
                g <= douta(1);
                b <= douta(2);
                -- if pos >= depth then
                --     pos <= 0;
                -- end if;

                -- r <= img_r(pos);
                -- g <= img_g(pos);
                -- b <= img_g(pos);
                -- pos <= pos + 1;

            elsif conv_integer(addra) + 1 >= depth then
                addra <= (others => '0');

            else
                r <= '0';
                g <= '0';
                b <= '0';
            end if;
        end if;
    end process;

    -- conditional rewrite
    -- ctrl ball move
    -- reset -> s0
    -- up_left, down_left, up_right, down_right(4 states)
    FSM: process (clk_ball, reset, ball_state, image_left_x, image_right_y, board_left_y, board_right_y)
    begin
        if reset = '1' then
            ball_state <= s0;
            image_left_x <= 336;
            image_right_y <= 236;

        elsif clk_ball 'event and clk_ball = '1' then
            case ball_state is
                when s0 =>
                    if start = '1' then
                        ball_state <= up_left;
                    else
                        ball_state <= s0;
                    end if;
                
                when up_left =>
                    if image_right_y <= 0  then
                        ball_state <= down_left;
                    
                    elsif image_left_x <= 40 and  (image_right_y + height >= board_left_y or image_right_y + height <= board_left_y + 100) then 
                        ball_state <= up_right;

                    elsif image_left_x <= 40 and  (image_right_y <= board_left_y + board_length or image_right_y < board_left_y + 200) then
                        ball_state <= down_right;

                    elsif image_left_x <= 0 then
                        image_left_x <= 336;
                        image_right_y <= 208;
                        ball_state <= s0;

                    else
                        image_left_x <= image_left_x - 1;
                        image_right_y <= image_right_y - 1;
                        ball_state <= up_left;
                    end if;
                
                when down_left =>
                    if image_right_y + height >= 599 then
                        ball_state <= up_left;
                    
                    elsif image_left_x <= 40 and  (image_right_y + height >= board_left_y or image_right_y <= board_left_y + 100) then 
                        ball_state <= up_right;

                    elsif image_left_x <= 40 and  (image_right_y + height <= board_left_y + board_length or image_right_y < board_left_y + 200) then
                        ball_state <= down_right;

                    elsif image_left_x <= 0 then
                        image_left_x <= 336;
                        image_right_y <= 208;
                        ball_state <= s0;

                    else
                        image_left_x <= image_left_x - 1;
                        image_right_y <= image_right_y + 1;
                        ball_state <= down_left;
                    end if;
                
                when up_right =>
                    if image_right_y <= 0 then
                        ball_state <= down_right;

                    elsif image_left_x + length >= 740 and (image_right_y + height >= board_right_y + 100 or image_right_y <= board_right_y + 100) then 
                        ball_state <= up_left;

                    elsif image_left_x + length >= 740 and (image_right_y <= board_right_y + board_length or image_right_y + height < board_right_y + 200) then
                        ball_state <= down_left;

                    elsif image_left_x + length >= 799 then
                        image_left_x <= 336;
                        image_right_y <= 208;
                        ball_state <= s0;

                    else
                        image_left_x <= image_left_x + 1;
                        image_right_y <= image_right_y - 1;
                        ball_state <= up_right;
                    end if;

                when down_right =>
                    if image_right_y + 128 >= 599 then
                        ball_state <= up_right;
                    
                    elsif image_left_x + length >= 760 and (image_right_y + height >= board_right_y + 100 or image_right_y <= board_right_y + 100) then 
                        ball_state <= up_left;

                    elsif image_left_x + length >= 760 and (image_right_y <= board_right_y + board_length or image_right_y + height < board_right_y + 200) then
                        ball_state <= down_left;

                    elsif image_left_x + 128 >= 799 then
                        image_left_x <= 336;
                        image_right_y <= 208;
                        ball_state <= s0;

                    else
                        image_left_x <= image_left_x + 1;
                        image_right_y <= image_right_y + 1;
                        ball_state <= down_right;
                    end if;
            end case;
        end if;
    end process;

    board_ctrl: process (clk_ball, reset, board_left_y, board_right_y, left_up, left_down, right_up, right_down)
    begin
        if reset = '1' then
            board_left_y <= 100;
            board_right_y <= 100;
        
        elsif clk_ball 'event and clk_ball = '1' then
            if left_up = '1' then
                if board_left_y >= 10 then
                    board_left_y <= board_left_y - 1;
                else
                    board_left_y <= board_left_y;
                end if;
            end if;

            if left_down = '1' then
                if board_left_y < 590 then
                    board_left_y <= board_left_y + 1;
                else
                    board_left_y <= board_left_y;
                end if;
            end if;

            if right_up = '1' then
                if board_left_y >= 10 then
                    board_right_y <= board_right_y - 1;
                else
                    board_right_y <= board_right_y;
                end if;
            end if;

            if right_down = '1' then
                if board_left_y < 590 then
                    board_right_y <= board_right_y + 1;
                else
                    board_right_y <= board_right_y;
                end if;
            end if;

        end if;
    end process;

end behavioral;
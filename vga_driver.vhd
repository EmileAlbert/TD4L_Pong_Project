library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_driver is
  port(
  rst      : in 	std_logic;
  clk25    : in   std_logic;
  hsync    : out  std_logic;
  vsync    : out  std_logic;
  red      : out  std_logic_vector(3 downto 0);
  green    : out  std_logic_vector(3 downto 0);
  blue     : out  std_logic_vector(3 downto 0);
  xpos     : out  unsigned(9 downto 0);
  ypos     : out  unsigned(9 downto 0);
  pixval   : in   std_logic_vector(2 downto 0)
  );
end vga_driver;

architecture Behavioral of vga_driver is
  signal x : unsigned(9 downto 0) := (others => '0');
  signal y : unsigned(9 downto 0) := (others => '0');

  -- http://www.epanorama.net/faq/vga2rgb/calc.html
  -- x - horizontal; all values in 'pixel display time'
  constant visible_x : integer := 640;
  constant x_fp      : integer := 16; -- front porch
  constant x_pl      : integer := 96; -- pulse length
  constant x_bp      : integer := 48; -- back porch

  -- y - vertical; all values in 'line display time'
  constant visible_y : integer := 480;
  constant y_fp      : integer := 10;
  constant y_pl      : integer := 2;
  constant y_bp      : integer := 29;

  begin

  --process
  --sweeping the screen.
	sweeping : process(rst, clk25)
	begin
		if rst = '1' then
			hsync <= '1';
			vsync <= '1';
			x     <= (others => '0');
			y     <= (others => '0');
		elsif rising_edge(clk25) then
			-- calculate next (x,y) - horizontal scaning
			if x = to_unsigned(visible_x + x_fp + x_pl + x_bp, 10) then
				x <= (others => '0');
				if y = to_unsigned(visible_y + y_fp + y_pl + y_bp, 10) then
					y <= (others => '0');
				else
					y <= y + 1;
				end if;
			else
				x <= x + 1;
			end if;
			-- hsync control
			if x >= to_unsigned(visible_x + x_fp - 1, 10) and x < to_unsigned(visible_x + x_fp + x_pl, 10) then
				hsync <= '0';
			else
				hsync <= '1';
			end if;
			-- vsync control
			if y >= to_unsigned(visible_y + y_fp - 1, 10) and y < to_unsigned(visible_y + y_fp + y_pl, 10) then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
		end if;
	end process;

  display : process(rst, clk25)
  begin
		if rst = '1' then
      red   <= (others => '0');
			green <= (others => '0');
			blue  <= (others => '0');
		elsif rising_edge(clk25) then
				if x < to_unsigned(visible_x, 10) and y < to_unsigned(visible_y+60, 10) then
              xpos <= x;
              ypos <= y - y_fp;
              --Color of the pixel on 12bits given by a pixval
							red(3) 		  <= pixval(2);
							green(3)		<= pixval(1);
							blue(3)		  <= pixval(0);
				else
          blue  <= (others => '0');
					green <= (others => '0');
					red   <= (others => '0');
				end if;
			end if;
	end process;
end architecture;

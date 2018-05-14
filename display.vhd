library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Display is
	port(
	 rst         : in  std_logic;
	 clk25       : in  std_logic;
    xpos        : in  unsigned(9 downto 0);
    ypos     	 : in  unsigned(9 downto 0);
	 xballcenter : in  unsigned(9 downto 0);
	 yballcenter : in  unsigned(9 downto 0);
	 ypos1       : in  unsigned(9 downto 0);
	 ypos2       : in  unsigned(9 downto 0);
    pixval      : out std_logic_vector(2 downto 0)
	);
end entity Display;

architecture Behavioral of Display is
  constant visible_x : integer := 640;
  constant visible_y : integer := 480;
  type row_t    is array(0 to (visible_x)-1) of std_logic_vector(2 downto 0);
  type matrix_t is array(0 to (visible_y)-1) of row_t;
  signal matrix   : matrix_t;
  signal temp_row : row_t;
  signal x : unsigned(9 downto 0) := (others => '0');
  signal y : unsigned(9 downto 0) := (others => '0');
begin



  Sweeping : process(rst, clk25)
	constant ballradius 	: integer := 10;
	constant shipwidth 	: unsigned(9 downto 0) := to_unsigned(20,10);
	constant shipheight 	: unsigned(9 downto 0) := to_unsigned(80,10);
	constant ship1xpos	: unsigned(9 downto 0) := to_unsigned(40,10);
	constant ship2xpos	: unsigned(9 downto 0) := to_unsigned(600,10);
	begin
		if rst = '1' then
			x     <= (others => '0');
			y     <= (others => '0');
		elsif rising_edge(clk25) then
			if x = to_unsigned(visible_x, 10) then
				x <= (others => '0');
				if y = to_unsigned(visible_y, 10) then
					y <= (others => '0');
				else
					y <= y + 1;
				end if;
			else
				x <= x + 1;
			end if;
			--To the driver
			--Ball
			
			if (2*to_integer(yballcenter)*to_integer(y)-to_integer(y)*to_integer(y) + 2*to_integer(xballcenter)*to_integer(x)-to_integer(x)*to_integer(x)) > (to_integer(xballcenter)*to_integer(xballcenter)+to_integer(yballcenter)*to_integer(yballcenter)- ballradius*ballradius) then
				matrix(to_integer(y))(to_integer(x)) <= "111";
			--Left	
			elsif (x > (ship1xpos - shipwidth) and x < ship1xpos) then 
				if (y > ypos1 and y < (ypos1 + shipheight)) then 
					matrix(to_integer(y))(to_integer(x)) <= "111";
				else
					matrix(to_integer(y))(to_integer(x)) <= "000";
				end if;
			--Right	
			elsif (x > ship2xpos and x < (ship2xpos+shipwidth)) then 
				if (y > ypos2 and y < (ypos2 + shipheight)) then 
					matrix(to_integer(y))(to_integer(x)) <= "111";
				else
					matrix(to_integer(y))(to_integer(x)) <= "000";
				end if;
			else 
				matrix(to_integer(y))(to_integer(x)) <= "000";
			end if;
			
			pixval <= matrix(to_integer(ypos))(to_integer(xpos));
		end if;
	end process;


end Behavioral;

-- Game
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity game is 
	port(
	clk              : in std_logic;
	clkgame          : in std_logic;
   xballcenter      : out  unsigned(9 downto 0);
	yballcenter      : out  unsigned(9 downto 0);
	ypos1            : out  unsigned(9 downto 0);
	ypos2            : out  unsigned(9 downto 0);
	Up_btn_Left      : in  std_logic;
	Down_btn_Left    : in  std_logic;
	Up_btn_Right     : in  std_logic;
	Down_btn_Right   : in  std_logic
	);
End entity game;

Architecture Behavioral OF game is 
	signal xball     : unsigned(9 downto 0) := to_unsigned(320,10);
	signal yball     : unsigned(9 downto 0) := to_unsigned(240,10);
	signal y1        : unsigned(9 downto 0) := to_unsigned(80,10);
	signal y2        : unsigned(9 downto 0) := to_unsigned(80,10);
	signal yMaxUp   : unsigned(9 downto 0) := to_unsigned(10,10);
	signal yMaxDown : unsigned(9 downto 0) := to_unsigned(380,10);

	
	begin
	moveLeftRacket : process(clk, clkgame)
		begin
		if clk = '1' then
		if rising_edge(clkgame) then
			if y1 > yMaxUp then
				if	y1 < yMaxDown then
					-- Move Up
					if Up_btn_Left = '0' then
						y1 <= y1 + 1;
					-- Move Down
					elsif Down_btn_Left = '0' then
						y1 <= y1 - 1;
					end if;
				else 
					y1 <= to_unsigned(379,10);
				end if;
			else 
				y1 <= to_unsigned(11,10);
			end if;
		end if;
		ypos1 <= y1; 
		end if ;
	end process;
	
	moveRightRacket : process(clk, clkgame)
		begin
		if clk = '1' then
		if rising_edge(clkgame) then
			if y2 > yMaxUp then
				if	y2 < yMaxDown then
					-- Move Up
					if Up_btn_Right = '0' then
						y2 <= y2 + 1;
					-- Move Down
					elsif Down_btn_Right = '0' then
						y2 <= y2 - 1;
					end if;
				else 
					y2 <= to_unsigned(379,10);
				end if;
			else 
				y2 <= to_unsigned(11,10);
			end if;
		end if;
		ypos2 <= y2;
		end if ;
	end process;
	
	
	moveBall : process(clk, clkgame)
		begin
		if clk = '1' then
			xballcenter <= xball;
			yballcenter <= yball;
		end if ;
	end process ;

 
End Architecture;


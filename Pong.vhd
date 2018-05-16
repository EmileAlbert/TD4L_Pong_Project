library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Pong is
	port(
		rst           : in  std_logic;
		clk           : in  std_logic;
		hsync         : out std_logic;
		vsync         : out std_logic;
		red           : out std_logic_vector(3 downto 0);
		green         : out std_logic_vector(3 downto 0);
		blue          : out std_logic_vector(3 downto 0);
		Up_btn_Left   : in  std_logic;
	   Down_btn_Left : in  std_logic;
		Up_btn_Right  : in  std_logic;
	   Down_btn_Right: in  std_logic;
		rst_game		  : in std_logic;
		play 			  : in std_logic
		--HEX0R,HEX1R,HEX2R,HEX3R,HEX4R,HEX5R : out std_logic_vector(7 downto 0 );
		--HEX0L,HEX1L,HEX2L,HEX3L,HEX4L,HEX5L : out std_logic_vector(7 downto 0 )
		);
end entity Pong;

architecture Behavioral of Pong is
	signal xpos 		 : unsigned(9 downto 0);
	signal ypos		    : unsigned(9 downto 0);
	signal pixval 	    : std_logic_vector(2 downto 0);
	signal clk25 	    : std_logic;
	signal clkgame     : std_logic;
	signal xballcenter : unsigned(9 downto 0);
	signal yballcenter : unsigned(9 downto 0); 
	signal ypos1       : unsigned(9 downto 0); 
	signal ypos2       : unsigned(9 downto 0); 
	

-- component declaration
component vga_driver is
		port(
  		rst      : in 	 std_logic;
  		clk25    : in   std_logic;
  		hsync    : out  std_logic;
  		vsync    : out  std_logic;
  		red      : out  std_logic_vector(3 downto 0);
  		green    : out  std_logic_vector(3 downto 0);
  		blue     : out  std_logic_vector(3 downto 0);
  		xpos		: out  unsigned(9 downto 0);
  		ypos     : out  unsigned(9 downto 0);
  		pixval   : in   std_logic_vector(2 downto 0)
  		);
end component;

component Display is
	port(
	 rst      : in  std_logic;
	 clk25    : in  std_logic;
    xpos     : in  unsigned(9 downto 0);
    ypos     : in  unsigned(9 downto 0);
	 xballcenter : in  unsigned(9 downto 0);
	 yballcenter : in  unsigned(9 downto 0);
	 ypos1 : in  unsigned(9 downto 0);
	 ypos2 : in  unsigned(9 downto 0);
    pixval   : out std_logic_vector(2 downto 0)
	);
end component;
	
component divider is
  generic(div_by : natural := 16);      -- must be dividable by 2 !
  port(clk_in  : in    std_logic;
       rst     : in    std_logic;
       clk_out : inout std_logic);
end component;

component game is
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
	Down_btn_Right   : in  std_logic;
	rst_game			  : in  std_logic;
	play 				  : in std_logic
	--score_right : out std_logic_vector(3 downto 0) := "0000";
	--score_left : out std_logic_vector(3 downto 0) := "0000"
);
end component;
	
--component SeptSeg is 
	
--port( HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out std_logic_vector(7 downto 0 );
--		SCORE : in std_logic_vector(3 downto 0)
--			);

--end component;


begin

-- process
	-- generate 25MHz clock
	clkdivby2 : process(clk)
	begin
		if rising_edge(clk) then
			clk25 <= not clk25;
		end if;
	end process;

	-- component
	pongmove : game PORT MAP(clk,clkgame,xballcenter,yballcenter,ypos1,ypos2, Up_btn_Left,Down_btn_Left, Up_btn_Right, Down_btn_Right, rst_game,play);
	clk1 : divider generic map(200000) port map(clk, rst, clkgame);
	driver : vga_driver PORT MAP(rst,clk25,hsync,vsync,red,green,blue,xpos,ypos,pixval);
	screendata : Display PORT MAP(rst,clk25,xpos,ypos,xballcenter,yballcenter,ypos1,ypos2,pixval);
	--scoreR : SeptSeg PORT MAP(HEX0 => HEX0R, HEX1 => HEX1R, HEX2 => HEX2R, HEX3 => HEX3R, HEX4 => HEX4R, HEX5 => HEX5R, SCORE => score_right);
	--scoreL : SeptSeg PORT MAP(HEX0 => HEX0L, HEX1 => HEX1L, HEX2 => HEX2L, HEX3 => HEX3L, HEX4 => HEX4L, HEX5 => HEX5L, SCORE => score_left);
	
end Behavioral;

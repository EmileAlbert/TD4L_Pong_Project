-- Game
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity game is 
	port(
	clk : in std_logic;
	clkgame : in std_logic;
	xballcenter : out  unsigned(9 downto 0);
	yballcenter : out  unsigned(9 downto 0);
	ypos1 : out  unsigned(9 downto 0);
	ypos2 : out  unsigned(9 downto 0);
	Up_btn_Left      : in  std_logic;
	Down_btn_Left    : in  std_logic;
	Up_btn_Right     : in  std_logic;
	Down_btn_Right   : in  std_logic; 
	rst_game			  : in  std_logic;
	play 				  : in std_logic
	);
End entity game;

Architecture Behavioral OF game is 
	signal xball_next : unsigned(9 downto 0) := to_unsigned(320,10);
	signal yball_next : unsigned(9 downto 0) := to_unsigned(200,10);
	
	signal xball_speed : integer := 1;
	signal yball_speed : integer := 1;
	
	signal xball_dir : integer := 1; -- 1 go right and 0 go left 
	signal yball_dir : integer := 1; -- 1 go up and 0 go down
		
	signal y1 : unsigned(9 downto 0) := to_unsigned(200,10);
	signal y2 : unsigned(9 downto 0) := to_unsigned(200,10);
	
	signal yMaxUp   : unsigned(9 downto 0) := to_unsigned(10,10);
	signal yMaxDown : unsigned(9 downto 0) := to_unsigned(380,10);
	
	signal rst_game_soft : std_logic := '1';
	
	
	
	begin
					
	xball_move_proc : process(clkgame)
	begin
		if clk = '1' then
			if rst_game = '0' then
				xball_next <= to_unsigned(320,10);
				
			
			elsif rst_game_soft = '0' then
				xball_next <= to_unsigned(320,10);		
			
			elsif rising_edge(clkgame) then
				
				--rst_game_soft <= '1';
				
				-- right direction
				if xball_dir = 1 then 
					xball_next <= xball_next + xball_speed;
					
				-- left direction		
				elsif xball_dir = 0 then
					xball_next <= xball_next - xball_speed;
				
				end if;
				
				xballcenter<= xball_next;				
			
			end if;
		end if;

	end process;	
	
	
	
	
	yball_move_proc : process(clkgame)
	begin
	
		if clk = '1' then
			if rst_game = '0' then
				yball_next <= to_unsigned(200,10);
			
			elsif rst_game_soft = '0' then
				yball_next <= to_unsigned(200,10);
			
					
			elsif rising_edge(clkgame) then
				
				-- right direction
				if yball_dir = 1 then 
					yball_next <= yball_next - yball_speed;
					
			   -- left direction		
				elsif yball_dir = 0 then
					yball_next <= yball_next + yball_speed;
				
				end if;
				
				yballcenter<= yball_next;				
			
			end if;
		end if;
	
	end process;
	
	
	
	
	xball_collision_racket : process(clkgame)
	
	constant ball_radius  : integer := 10;
	constant racket_width : integer := 20;
	
	begin 
		
		if xball_next = to_unsigned(570,10) then
			if rst_game = '0' then
				
				yball_speed <= 1;
		
			elsif (y2-10) < yball_next and yball_next < (y2 + 90) then
				
				if yball_next < (y2-10 + 30) or yball_next > (y2 + 50) then 
					yball_speed <= 2;			
				
				else 
					yball_speed <= 1;	
				
				end if;
				
				xball_dir <= 0;
				
			end if;
			
	
		elsif xball_next = to_unsigned(50,10) then 	
		
			if (y1) < yball_next and yball_next < (y1 + 80) then
				
				if yball_next < (y1 + 30) or yball_next > (y1 + 50) then 
					yball_speed <= 2;			
				
				else 
					yball_speed <= 1;	
				
				end if;
			
			xball_dir <= 1;
	
	
			end if;
		
		elsif xball_next = to_unsigned(650,10) then
			xball_dir <= 0 ;
			
		elsif xball_next = to_unsigned(0,10) then
			xball_dir <= 1 ;	

		end if;
			
	end process; 
	
	
	yball_collision_wall : process(clkgame)
	begin 
	
		if yball_next < to_unsigned(20,10) then  
			yball_dir <= 0;
					
		elsif yball_next > to_unsigned(460,10) then
			yball_dir <= 1;
			
		end if;

	end process;
			
	
	
	
	moveLeftRacket : process(clk, clkgame)
		begin
		if clk = '1' then
			
			-- Bug if uncommented
			-- if rst_game = '0' then
				--y1 <= to_unsigned(200,10);
		
			--elsif falling_edge(rst_game_soft) then
				--y1 <= to_unsigned(200,10);	
			
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
	
	
	
	-- To move the right racket
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


End Architecture;


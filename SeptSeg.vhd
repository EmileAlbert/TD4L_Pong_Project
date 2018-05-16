--Library IEEE;
--use IEEE.std_logic_1164.all;

--entity SeptSeg is 
	
--	port( HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out std_logic_vector(7 downto 0 );
--			SCORE : in std_logic_vector(3 downto 0)
--			);

--end entity SeptSeg;
			
--architecture bhv of SeptSeg is 

--	begin
	
--	process (SW)
--BEGIN

--case  SCORE(3 downto 0) is
	--	when "0000"=> HEX0 <="11000000";  -- '0'
	-- when "0001"=> HEX0 <="11111001";  -- '1'
	--	when "0010"=> HEX0 <="10100100";  -- '2'
--		when "0011"=> HEX0 <="10110000";  -- '3'
--		when "0100"=> HEX0 <="10011001";  -- '4' 
--		when "0101"=> HEX0 <="10010010";  -- '5'
--		when "0110"=> HEX0 <="10000010";  -- '6'
--		when "0111"=> HEX0 <="11111000";  -- '7'
--		when "1000"=> HEX0 <="10000000";  -- '8'
--		when "1001"=> HEX0 <="10011000";  -- '9'
--		when "1010"=> HEX0 <="10001000";  -- 'A'
--		when "1011"=> HEX0 <="10000011";  -- 'B'
--		when "1100"=> HEX0 <="11000110";  -- 'C'
--		when "1101"=> HEX0 <="10100001";  -- 'D'
--		when "1110"=> HEX0 <="10000110";  -- 'E'
--		when "1111"=> HEX0 <="10001110";  -- 'F'
--		 --nothing is displayed when a number more than F is given as input. 
--		when others=> HEX0 <="11111111"; 
--end case;
--
--end process;
--	
--end architecture bhv;
--	
Library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Pong_TestBench is
END ENTITY;

ARCHITECTURE Behavioral of Pong_TestBench is

-- DUT - Device Under Test
COMPONENT Pong is
port(
  rst      : in  std_logic;
  clk      : in  std_logic;
  hsync    : out std_logic;
  vsync    : out std_logic;
  clkgame	: buffer std_logic;
  red      : out std_logic_vector(3 downto 0);
  green    : out std_logic_vector(3 downto 0);
  blue     : out std_logic_vector(3 downto 0)
);
END COMPONENT;

signal clk   : std_logic;
signal rst   : std_logic := '0';
signal hsync : std_logic;
signal vsync : std_logic;
signal red   : std_logic_vector(3 downto 0);
signal green : std_logic_vector(3 downto 0);
signal blue  : std_logic_vector(3 downto 0);
signal clkgame :  std_logic;
constant PERIODE: time := 20 ns;


begin

DUT : Pong port map(rst,clk,hsync,clkgame,vsync,red,green,blue);

stimuli_clk : Process
begin
	clk <= '1';
	Wait for PERIODE;
	clk <= '0';
	Wait for PERIODE;
end Process;


end architecture;

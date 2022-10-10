----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:38 05/27/2022 
-- Design Name: 
-- Module Name:    topdesign - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topdesign is
	port(EppAstb: in std_logic;        -- Address strobe
      EppDstb: in std_logic;        -- Data strobe
      EppWr  : in std_logic;        -- Port write signal
      EppDB  : inout std_logic_vector(7 downto 0); -- port data bus
      EppWait: out std_logic;        -- Port wait signal
		clk: in std_logic;
		Hsync: out std_logic;
		Vsync: out std_logic;
		vgaRed: out std_logic_vector(2 downto 0); 
		vgaGreen: out std_logic_vector(2 downto 0);
		vgaBlue: out std_logic_vector(1 downto 0)
	);
end topdesign;

architecture Behavioral of topdesign is

   component IOExpansion is
    Port (
-- Epp-like bus signals
      EppAstb: in std_logic;        -- Address strobe
      EppDstb: in std_logic;        -- Data strobe
      EppWr  : in std_logic;        -- Port write signal
      EppDB  : inout std_logic_vector(7 downto 0); -- port data bus
      EppWait: out std_logic;        -- Port wait signal
-- user extended signals 
      Led  : in std_logic_vector(7 downto 0);   -- 0x01     8 virtual LEDs on the PC I/O Ex GUI
      LBar : in std_logic_vector(23 downto 0);  -- 0x02..4  24 lights on the PC I/O Ex GUI light bar
      Sw   : out std_logic_vector(15 downto 0);  -- 0x05..6  16 switches, bottom row on the PC I/O Ex GUI
      Btn  : out std_logic_vector(15 downto 0);  -- 0x07..8  16 Buttons, bottom row on the PC I/O Ex GUI
      dwOut: out std_logic_vector(31 downto 0); -- 0x09..b  32 Bits user output
      dwIn : in std_logic_vector(31 downto 0)   -- 0x0d..10 32 Bits user input
         );
   end component;
	
	component buttoncontrol is
		 port(clk, buttonup, buttondown, buttonleft, buttonright, gameOver, gameWin: in STD_LOGIC;
				birdtop, birdleft: out integer);

	end component;
	
	
	component vgapixelcounter is

	port(
		clk, reset: in std_logic;
		HS, VS: out std_logic;
		pixelX, pixelY: out std_logic_vector(9 downto 0);
		pixelBlank: out std_logic);
	end component;
	
	component clockdivider is
		port(
		clock : in STD_LOGIC;
		slower_clock : out STD_LOGIC);
	end component;

	component clockdivider2 is
		port(
		clock : in STD_LOGIC;
		slower_clock : out STD_LOGIC);
	end component;

	component birdimage is
    Port ( 
	        pixelBlank: in std_logic;
			  birdTop, birdLeft: in unsigned(9 downto 0);
           pixelX: in std_logic_vector(9 downto 0);
           pixelY: in std_logic_vector(9 downto 0);
           rgb: out std_logic_vector(7 downto 0);
			  gameOver, gameWin: out std_logic);
   end component;

    
    -- VGA Signals
	signal pixelX, pixelY: std_logic_vector(9 downto 0);
	signal rgb: std_logic_vector(7 downto 0);
	signal rst: std_logic;
	signal HS: std_logic;
	signal VS: std_logic;
	signal HS_unnec, VS_unnec: std_logic;
	signal Hcounterout: integer;
	signal pixelBlank: STD_LOGIC;
	
	-- signals for Flappy Bird Graphics
    signal birdTop: unsigned(9 downto 0):= to_unsigned(200,10);
    signal birdLeft: unsigned(9 downto 0):= to_unsigned(100,10);
	 signal birdtappoint1: unsigned(9 downto 0);
	 signal birdleftpoint1: unsigned(9 downto 0);
	 signal gameOver_int, gameWin_int: std_logic;

    
    --signals for clock dividers
	 signal clkModified, clkModified2: std_logic;
    
	 
	 --signals for button
	 signal buttonup, buttondown, buttonleft, buttonright: std_logic;
	 signal birdleftpoint, birdtoppoint: integer;
	 signal EppAstb_int, EppDstb_int, EppWr_int, EppWait_int: std_logic;
	 signal EppDB_int: std_logic_vector(7 downto 0);
	 signal Led_int: std_logic_vector(7 downto 0);
	 signal LBar_int: std_logic_vector(23 downto 0);
	 signal Sw_int: std_logic_vector(15 downto 0);
	 signal dwOut_int: std_logic_vector(31 downto 0);
	 signal dwIn_int: std_logic_vector(31 downto 0);
    signal btn1: std_logic_vector(15 downto 0);
	 
	 
	 
begin


iobuttonItems: IOExpansion PORT MAP(EppAstb, EppDstb, EppWr, EppDB, 
												EppWait, Led=>Led_int, LBar=>LBar_int, Sw=>Sw_int, Btn=>btn1, dwOut=>dwOut_int, dwIn=>dwIn_int);

buttonController: buttoncontrol PORT MAP(clk=>clkModified2, buttonup=>btn1(15), buttondown=>btn1(14), buttonleft=>btn1(13), buttonright=>btn1(12), 
													 gameOver => gameOver_int, gameWin => gameWin_int, birdtop=>birdtoppoint, birdleft=>birdleftpoint);

vgaTimer: vgapixelcounter PORT MAP(clk=>clkModified, reset=>'0', HS=>HS, VS=>VS, pixelX=>pixelX, pixelY=>pixelY, pixelBlank=>pixelBlank);

clockDividervga: clockdivider PORT MAP(clock=>clk, slower_clock=>clkModified);
clockDividerbutton: clockdivider2 PORT MAP(clock=>clk, slower_clock=>clkModified2);


birdtappoint1 <= to_unsigned(birdtoppoint,10);
birdleftpoint1 <= to_unsigned(birdleftpoint,10);

drawingModule: birdimage PORT MAP( pixelBlank => pixelBlank, birdTop=> birdtappoint1, birdLeft=> birdleftpoint1,
                        pixelX=>pixelX, pixelY => pixelY, rgb=>rgb, gameOver => gameOver_int, gameWin => gameWin_int);

      
 
vgaRed <= rgb(7 downto 5);
vgaGreen <= rgb(4 downto 2);
vgaBlue <= rgb(1 downto 0);
Hsync <= HS;
Vsync <= VS;

     
end Behavioral;


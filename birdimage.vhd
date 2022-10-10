----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:28 05/27/2022 
-- Design Name: 
-- Module Name:    birdimage - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity birdimage is
    Port ( pixelBlank: in std_logic;
			  birdTop, birdLeft: in unsigned(9 downto 0);
           pixelX: in std_logic_vector(9 downto 0);
           pixelY: in std_logic_vector(9 downto 0);
           rgb: out std_logic_vector(7 downto 0);
			  gameOver, gameWin: out std_logic);
end birdimage;

architecture Behavioral of birdimage is

signal pixX, pixY: unsigned(9 downto 0);

signal groundActive: std_logic;
signal birdOutlineActive: std_logic;
signal birdLipsActive: std_logic;
signal birdWhiteActive: std_logic; 
signal birdYellowActive: std_logic; 
signal groundBorderActive: std_logic;
signal winWordActive: std_logic;
signal endboxActive: std_logic;
signal obstacle1Active, obstacle2Active: std_logic;
signal birdOutlineRgb: std_logic_vector(7 downto 0);
signal birdLipsRgb: std_logic_vector(7 downto 0); 
signal birdWhiteRgb: std_logic_vector(7 downto 0);
signal birdYellowRgb: std_logic_vector(7 downto 0); 
signal groundRgb: std_logic_vector(7 downto 0);
signal groundBorderRgb: std_logic_vector(7 downto 0);
signal obstacleRgb: std_logic_vector(7 downto 0); 
signal endboxRgb: std_logic_vector(7 downto 0);
signal skyRgb: std_logic_vector(7 downto 0);
signal gameWin1, gameOver1: std_logic;

begin


pixX <= unsigned(pixelX);
pixY <= unsigned(pixelY);
      



----bird drawing
      birdOutlineActive <= '1' when  
                  (gameWin1='0') and(((pixY=birdTop or pixY=birdTop+1) and (pixX>=birdLeft+12 and pixX<=birdLeft+23)) or  
                  ((pixY=birdTop+2 or pixY=birdTop+3) and ((pixX>=birdLeft+8 and pixX<=birdLeft+11) or pixX=birdLeft+18 or pixX=birdLeft+19 or pixX=birdLeft+24 or pixX=birdLeft+25)) or  
                  ((pixY=birdTop+4 or pixY=birdTop+5) and (pixX=birdLeft+6 or pixX=birdLeft+7 or pixX=birdLeft+16 or pixX=birdLeft+17 or pixX=birdLeft+26 or pixX=birdLeft+27)) or  
                  ((pixY=birdTop+6 or pixY=birdTop+7) and ((pixX>=birdLeft+2 and pixX<=birdLeft+9) or pixX=birdLeft+16 or pixX=birdLeft+17 or pixX=birdLeft+24 or pixX=birdLeft+25 or pixX=birdLeft+28 or pixX=birdLeft+29)) or  
                  ((pixY=birdTop+8 or pixY=birdTop+9) and (pixX=birdLeft or pixX=birdLeft+1 or pixX=birdLeft+10 or pixX=birdLeft+11 or pixX=birdLeft+16 or pixX=birdLeft+17 or pixX=birdLeft+24 or pixX=birdLeft+25 or pixX=birdLeft+28 or pixX=birdLeft+29)) or  
                  ((pixY=birdTop+10 or pixY=birdTop+11) and (pixX=birdLeft or pixX=birdLeft+1 or pixX=birdLeft+14 or pixX=birdLeft+15 or pixX=birdLeft+18 or pixX=birdLeft+19 or pixX=birdLeft+30 or pixX=birdLeft+31)) or  
                  ((pixY=birdTop+12 or pixY=birdTop+13) and (pixX=birdLeft or pixX=birdLeft+1 or pixX=birdLeft+12 or pixX=birdLeft+13 or pixX=birdLeft+18 or pixX=birdLeft+19 or pixX=birdLeft+28 or pixX=birdLeft+29)) or  
                  ((pixY=birdTop+14 or pixY=birdTop+15) and (pixX=birdLeft or pixX=birdLeft+1 or pixX=birdLeft+10 or pixX=birdLeft+11 or pixX=birdLeft+18 or pixX=birdLeft+19 or pixX=birdLeft+32 or pixX=birdLeft+33)) or  
                  ((pixY=birdTop+16 or pixY=birdTop+17) and ((pixX>=birdLeft+4 and pixX<=birdLeft+9)  or pixX=birdLeft+16 or pixX=birdLeft+17 or (pixX>=birdLeft+20 and pixX<=birdLeft+31))) or  
                  ((pixY=birdTop+18 or pixY=birdTop+19) and (pixX=birdLeft+4 or pixX=birdLeft+5 or pixX=birdLeft+18 or pixX=birdLeft+19 or pixX=birdLeft+30 or pixX=birdLeft+31)) or  
                  ((pixY=birdTop+20 or pixY=birdTop+21) and ((pixX>=birdLeft+6 and pixX<=birdLeft+9) or (pixX>=birdLeft+20 and pixX<=birdLeft+29))) or  
                  ((pixY=birdTop+22 or pixY=birdTop+23) and ((pixX>=birdLeft+10 and pixX<=birdLeft+19)))) 
                  else '0';
      
     
      birdWhiteActive <= '1' when
                  (gameWin1='0') and (((pixY=birdTop+2 or pixY=birdTop+3) and (pixX>=birdLeft+20 and pixX<=birdLeft+23)) or  
                  ((pixY=birdTop+4 or pixY=birdTop+5) and (pixX>=birdLeft+18 and pixX<=birdLeft+25)) or  
                  ((pixY=birdTop+6 or pixY=birdTop+7) and ((pixX>=birdLeft+18 and pixX<=birdLeft+23) or pixX=birdLeft+26 or pixX=birdLeft+27)) or  
                  ((pixY=birdTop+8 or pixY=birdTop+9) and ((pixX>=birdLeft+2 and pixX<=birdLeft+9) or (pixX>=birdLeft+18 and pixX<=birdLeft+23) or pixX=birdLeft+27 or pixX=birdLeft+28)) or  
                  ((pixY=birdTop+10 or pixY=birdTop+11) and ((pixX>=birdLeft+2 and pixX<=birdLeft+11) or (pixX>=birdLeft+20 and pixX<=birdLeft+27))) or  
                  ((pixY=birdTop+12 or pixY=birdTop+13) and ((pixX>=birdLeft+2 and pixX<=birdLeft+11))))  
                  else '0';
                  
      birdYellowActive <= '1' when
                  (gameWin1='0') and (((pixY=birdTop+2 or pixY=birdTop+3) and (pixX>=birdLeft+12 and pixX<=birdLeft+17)) or  
                  ((pixY=birdTop+4 or pixY=birdTop+5) and (pixX>=birdLeft+8 and pixX<=birdLeft+15)) or  
                  ((pixY=birdTop+6 or pixY=birdTop+7) and (pixX>=birdLeft+10 and pixX<=birdLeft+15)) or  
                  ((pixY=birdTop+8 or pixY=birdTop+9) and (pixX>=birdLeft+12 and pixX<=birdLeft+15)) or  
                  ((pixY=birdTop+10 or pixY=birdTop+11) and (pixX=birdLeft+14 or pixX=birdLeft+17)) or  
                  ((pixY=birdTop+12 or pixY=birdTop+13) and (pixX>=birdLeft+14 and pixX<=birdLeft+19)) or  
                  ((pixY=birdTop+14 or pixY=birdTop+15) and (pixX>=birdLeft+12 and pixX<=birdLeft+17)) or  
                  ((pixY=birdTop+16 or pixY=birdTop+17) and (pixX>=birdLeft+10 and pixX<=birdLeft+15)) or  
                  ((pixY=birdTop+18 or pixY=birdTop+19) and (pixX>=birdLeft+6 and pixX<=birdLeft+17)) or  
                  ((pixY=birdTop+20 or pixY=birdTop+21) and (pixX>=birdLeft+10 and pixX<=birdLeft+19))) 
                  else '0';
						
		birdLipsActive <= '1' when
                  (gameWin1='0') and (((pixY=birdTop+14 or pixY=birdTop+15) and (pixX>=birdLeft+20 and pixX<=birdLeft+31)) or 
                  ((pixY=birdTop+16 or pixY=birdTop+17) and (pixX=birdLeft+18 or pixX=birdLeft+19)) or  
                  ((pixY=birdTop+18 or pixY=birdTop+19) and (pixX>=birdLeft+20 and pixX<=birdLeft+29)))  
                  else '0';
		
      
		
		
----WIN message drawing
		
		winWordActive <= '1' when
				(gameWin1 = '1') and ((pixX>120 and pixX<150 and pixY>=120 and pixY<360) or
				 (pixX>=150 and pixX<180 and pixY>=280 and pixY<360) or
				 (pixX>=180 and pixX<210 and pixY>=120 and pixY<320) or
				 (pixX>=210 and pixX<240 and pixY>=280 and pixY<360) or
				 (pixX>=240 and pixX<270 and pixY>=120 and pixY<360) or
				 (pixX>=300 and pixX<340 and pixY>=120 and pixY<360) or
				 (pixX>=370 and pixX<400 and pixY>=120 and pixY<360) or
				 (pixX>=400 and pixX<430 and pixY>=120 and pixY<160) or
				 (pixX>=430 and pixX<460 and pixY>=120 and pixY<360) or
				 (pixX>=460 and pixX<490 and pixY>=320 and pixY<360) or
				 (pixX>=490 and pixX<520 and pixY>=120 and pixY<360)) 
				 else '0';
				
		
		
		
	birdOutlineRgb <= "00000000";  --black outline
   birdLipsRgb <= "11101100";  --orange lips
   birdWhiteRgb <= "11111111"; --white parts of the bird
   birdYellowRgb <= "11111110"; --yellowbody
	groundRgb <= "00010100";	--green ground
	groundBorderRgb <= "00001100";	--black border for the ground
	obstacleRgb <= "00010100";	-- green targets
	endboxRgb <= "11111111"; ---white
	skyRgb <= "00001111"; --bluesky

	groundBorderActive <= '1' when (gameWin1= '0' and pixY >= 420 and pixY < 425) 
								 else '0';
	obstacle1Active <= '1' when (gameWin1= '0' and ((pixY > 1 and pixY < 170)or(pixY > 210 and pixY < 420)) and pixX < 250  and pixX > 200) 
						    else '0';
	obstacle2Active <= '1' when (gameWin1= '0' and ((pixY > 1 and pixY < 220)or(pixY > 260 and pixY < 420)) and pixX < 500  and pixX > 450) 
						    else '0';
	endboxActive <= '1' when (gameWin1= '0' and pixY > 380 and pixY < 415 and pixX < 640  and pixX > 600) 
						 else '0';
	groundActive <= '1' when (gameWin1= '0' and pixY >= 428) 
						 else '0';
	
	
	
	--game on or off situation
	
	gameOver1 <= '1' when (((birdTop > 1 and birdTop < 170)or(birdTop > 185 and birdTop < 420)) and birdLeft < 250  and birdLeft > 165)or
								(((birdTop > 1 and birdTop < 220)or(birdTop > 235 and birdTop < 420)) and birdLeft < 500  and birdLeft > 415) 
						  else '0';
	gameWin1 <= '1' when birdTop>=381 and birdLeft>=601 
						 else '0';
	
	gameOver <= gameOver1;
	gameWin <= gameWin1;
	
	

    
    rgb <=     "00000000"    when pixelBlank = '1' else
               endboxRgb         when winWordActive='1' else
               groundBorderRgb     when groundBorderActive='1' else
               groundRgb         when groundActive='1' else
               birdOutlineRgb when birdOutlineActive='1' else
               birdLipsRgb     when birdLipsActive='1' else
               birdWhiteRgb     when birdWhiteActive='1' else
               birdYellowRgb     when birdYellowActive='1' else
					obstacleRgb         when obstacle1Active='1' or obstacle2Active='1'  else
					endboxRgb            when endboxActive='1' else
               skyRgb; 
     
end Behavioral;


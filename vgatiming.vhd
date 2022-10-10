----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:33:12 05/28/2022 
-- Design Name: 
-- Module Name:    vgatiming - Behavioral 
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

entity vgapixelcounter is

	port(
		clk, reset: in std_logic;
		HS, VS: out std_logic;
		pixelX, pixelY: out std_logic_vector(9 downto 0);
		pixelBlank: out std_logic);
end vgapixelcounter;

architecture behavioral of vgapixelcounter is
	signal hCounter: unsigned(9 downto 0);
	signal hCounterNext: unsigned(9 downto 0);
	signal vCounter: unsigned(9 downto 0);  
	signal vCounterNext: unsigned(9 downto 0);
begin

	process(clk, reset)
	begin
		if (reset='1') then
			hCounter <= (others=>'0');
			vCounter <= (others=>'0');
		elsif (clk'event and clk='1') then
			hCounter <= hCounterNext;
			vCounter <= vCounterNext;
		end if;
	end process;

	
	hCounterNext <= (others=>'0') when (hCounter = 799) else 
									  hCounter + 1;
											
	vCounterNext <= (others=>'0') when (vCounter = 520 and hCounter = 799) else
								   vCounter + 1 when (hCounter = 799) else
									vCounter;
											
	HS <= '0' when (hCounter >= 0 and hCounter < 96) else 
						 '1';
	VS <= '0' when (vCounter >= 0 and vCounter < 2) else 
						 '1';
						 
	pixelBlank <= '1' when (((hCounter >= 0 and hCounter < 144)or(hCounter >= 784 and hCounter < 800)) or 
							((vCounter >= 0 and vCounter < 31)or(vCounter >= 511 and vCounter < 521))) 
					 else '0';
	
	pixelX <= std_logic_vector(hCounter-144);
	pixelY <= std_logic_vector(vCounter-20);
											
	
	
	
end behavioral;


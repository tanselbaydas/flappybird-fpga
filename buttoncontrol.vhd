----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:33 05/31/2022 
-- Design Name: 
-- Module Name:    buttoncontrol - Behavioral 
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
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buttoncontrol is
 port(clk, buttonup, buttondown, buttonleft, buttonright, gameOver, gameWin: in STD_LOGIC;
      birdtop: out integer range 0 to 480;
		birdleft: out integer range 0 to 640);

end buttoncontrol;

architecture Behavioral of buttoncontrol is


signal speed: integer range 0 to 1000000;
signal birdtop_int: integer range 0 to 480;
signal birdleft_int: integer range 0 to 640;


begin

speed <= 2;

process(clk)
variable nextbirdtop: integer range 0 to 480 :=60;
variable nextbirdleft: integer range 0 to 640 :=60;
variable currentbirdtop: integer range 0 to 480 :=60;
variable currentbirdleft:  integer range 0 to 640 :=60;
begin
	if (clk'event and clk='1') then
			if (gameOver='1') then
				currentbirdtop := 50;
				currentbirdleft := 50;
				
			elsif buttonup = '1' then
				if currentbirdtop = 10 then
					currentbirdtop := currentbirdtop;
					nextbirdtop := 0;
				else
					nextbirdtop := nextbirdtop + 1;
					if nextbirdtop = speed then
						currentbirdtop := currentbirdtop -1;
						nextbirdtop := 0;
					else
						currentbirdtop := currentbirdtop;
					end if;
				end if;

			
			elsif buttondown = '1' then
				if currentbirdtop = 385 then
					currentbirdtop := currentbirdtop;
					nextbirdtop := 0;
				else
					nextbirdtop := nextbirdtop + 1;
					if nextbirdtop = speed then
						currentbirdtop := currentbirdtop +1;
						nextbirdtop := 0;
					else
						currentbirdtop := currentbirdtop;
					end if;
				end if;
			
			
			elsif buttonright = '1' then
				if currentbirdleft = 605 then
					currentbirdleft := currentbirdleft;
					nextbirdleft := 0;
				else
					nextbirdleft := nextbirdleft + 1;
					if nextbirdleft = speed then
						currentbirdleft := currentbirdleft +1;
						nextbirdleft := 0;
					else
						currentbirdleft := currentbirdleft;
					end if;
				end if;
			


			elsif buttonleft = '1' then
				if currentbirdleft = 10 then
					currentbirdleft := currentbirdleft;
					nextbirdleft := 0;
					
				else
					nextbirdleft := nextbirdleft + 1;
					if nextbirdleft = speed then
						currentbirdleft := currentbirdleft -1;
						nextbirdleft := 0;
					else
						currentbirdleft := currentbirdleft;
					end if;
				end if;
			
			else
				currentbirdleft := currentbirdleft;
		      currentbirdtop := currentbirdtop;
			end if;
	else
		currentbirdleft := currentbirdleft;
		currentbirdtop := currentbirdtop;	
	end if;
	
	birdtop_int <= currentbirdtop;
	birdleft_int <= currentbirdleft;
	

end process;

birdtop <= birdtop_int;
birdleft <= birdleft_int;


end Behavioral;


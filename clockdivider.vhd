----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:06 05/27/2022 
-- Design Name: 
-- Module Name:    clockdivider - Behavioral 
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

entity clockdivider is
port(
clock : in STD_LOGIC;
slower_clock : out STD_LOGIC);
end clockdivider;


architecture Behavioral of clockdivider is


signal COUNT : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal Q0, Q1, Q2, Q3: STD_LOGIC;

begin

process(clock)
begin
  if (clock'event and clock ='1') then
      COUNT <= COUNT+1;
  end if;
end process;


Q3  <= COUNT(3);
Q2  <= COUNT(2);
Q1  <= COUNT(1);
Q0  <= COUNT(0);


	
slower_clock <= Q1;
	
end Behavioral;


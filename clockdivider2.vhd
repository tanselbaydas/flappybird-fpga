----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:50:54 06/01/2022 
-- Design Name: 
-- Module Name:    clockdivider2 - Behavioral 
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

entity clockdivider2 is
port(
clock : in STD_LOGIC;
slower_clock : out STD_LOGIC);
end clockdivider2;


architecture Behavioral of clockdivider2 is


signal COUNT : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22 : STD_LOGIC;

begin

process(clock)
begin
  if (clock'event and clock ='1') then
      COUNT <= COUNT+1;
  end if;
end process;


Q22  <= COUNT(22);
Q21  <= COUNT(21);
Q20  <= COUNT(20);
Q19  <= COUNT(19);
Q18  <= COUNT(18);
Q17  <= COUNT(17);
Q16  <= COUNT(16);
Q15  <= COUNT(15);
Q14  <= COUNT(14);
Q13  <= COUNT(13);
Q12  <= COUNT(12);
Q11  <= COUNT(11);
Q10  <= COUNT(10);
Q9  <= COUNT(9);
Q8  <= COUNT(8);
Q7  <= COUNT(7);
Q6  <= COUNT(6);
Q5  <= COUNT(5);
Q4  <= COUNT(4);
Q3  <= COUNT(3);
Q2  <= COUNT(2);
Q1  <= COUNT(1);
Q0  <= COUNT(0);


	
slower_clock <= Q17;
	
end Behavioral;

----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    11:39:32 07/09/2014 
-- Design Name: 
-- Module Name:    beat - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Beat Generator
entity beat is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           bst : out STD_LOGIC_VECTOR(0 to 3));
end beat;

architecture Behavioral of beat is

   signal state : STD_LOGIC_VECTOR(0 to 3);
   
begin

   state <= "1000";

   -- Reset or generate beat
   process (clk, rst)
	begin
	
      if rst = '1' then
         state <= "1000";
      elsif clk'event and clk='1' then
         state <= state ROR 1;
      end if;
	
	end process;
	
   bst <= state;
   
end Behavioral;


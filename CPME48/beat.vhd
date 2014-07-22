----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    11:39:32 07/09/2014 
-- Design Name: 
-- Module Name:    beat - Behavioral 
-- Project Name:   CPME48
-- Target Devices: 
-- Tool versions: 
-- Description: beat.vhd is a 4-bit beat generator.
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Beat Generator
entity beat is
    Port ( clk   : in  STD_LOGIC;
           rst   : in  STD_LOGIC;
           reset : out STD_LOGIC;
           bst   : out STD_LOGIC_VECTOR(3 downto 0));
end beat;

architecture Behavioral of beat is

   signal state : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   
begin

   -- Reset or generate beat
   process (clk, rst)
	begin
	
      if rst = '1' then
         state <= "0000";
      elsif clk'event and clk='1' then
			if state = "0000" then
				state <= "1000";
			else
				state <= state(0) & state(3 downto 1);
			end if;
      end if;
      
	end process;
	
   bst <= state;
   reset <= rst;
   
end Behavioral;


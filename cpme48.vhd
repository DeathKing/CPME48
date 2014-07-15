----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:49 07/14/2014 
-- Design Name: 
-- Module Name:    cpme48 - Behavioral 
-- Project Name:   CPME48
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

entity cpme48 is
   Port (
      rst   : in    STD_LOGIC;
      clk   : in    STD_LOGIC;
      ABUS  : out   STD_LOGIC_VECTOR(15 downto 0);
      DBUS  : inout STD_LOGIC_VECTOR(15 downto 0);
      nMREQ : out   STD_LOGIC;
      nRD   : out   STD_LOGIC;
      nWR   : out   STD_LOGIC;
      IOAD  : out   STD_LOGIC_VECTOR(1 downto 0);
      IODB  : inout STD_LOGIC_VECTOR(7 downto 0);
      nPREQ : out   STD_LOGIC;
      nPRD  : out   STD_LOGIC;
      nPWR  : out   STD_LOGIC
   ); 

end cpme48;

architecture Behavioral of cpme48 is

begin


end Behavioral;


----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    15:13:38 07/09/2014 
-- Design Name: 
-- Module Name:    memctrl - Behavioral 
-- Project Name:   CPME48
-- Target Devices: 
-- Tool versions: 
-- Description: memctrl.vhd is memory control modular.
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

-- ABUS:  Address bus between memctrl and memory.
-- DBUS:  Data bus between memctrl and memory.
-- nMREQ: Memory selected.
-- nRD:   Memory read action.
-- nWR:   Memory write action.
-- nBHE:  Memory high byte access enable.
-- nLHE:  Memory low byte access enable.
entity memctrl is
    Port ( abus : out  STD_LOGIC_VECTOR (15 downto 0);
           dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           mar : in  STD_LOGIC_VECTOR (15 downto 0);
           mdr : in  STD_LOGIC_VECTOR (15 downto 0);
           bst : in  STD_LOGIC_VECTOR (3 downto 0);
           nMREQ : in  STD_LOGIC;
           nRD : in  STD_LOGIC;
           nWR : in  STD_LOGIC;
           nBHE : in  STD_LOGIC;
           nLHE : in  STD_LOGIC);
end memctrl;

architecture Behavioral of memctrl is

begin


end Behavioral;


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
    Port ( PC     : in    STD_LOGIC_VECTOR(15 downto 0);
           Addr   : in    STD_LOGIC_VECTOR(15 downto 0);
           Data   : in    STD_LOGIC_VECTOR(15 downto 0);
           ALUout : in    STD_LOGIC_VECTOR(7 downto 0);
           bst    : in    STD_LOGIC_VECTOR(3 downto 0);
           nfRD   : in    STD_LOGIC;
           niRD   : in    STD_LOGIC;
           niWR   : in    STD_LOGIC;
           IRnew  : out   STD_LOGIC_VECTOR(15 downto 0);
           Rtemp  : out   STD_LOGIC_VECTOR(7 downto 0);
           nRD    : out   STD_LOGIC;
           nWR    : out   STD_LOGIC;
           nBHE   : out   STD_LOGIC;
           nLHE   : out   STD_LOGIC;
           nMREQ  : out   STD_LOGIC;
           ABUS   : out   STD_LOGIC_VECTOR(15 downto 0);
           DBUS   : inout STD_LOGIC_VECTOR(15 downto 0));
end memctrl;

architecture Behavioral of memctrl is

begin

   process (bst)
   begin
      case bst is
         when "1000" => nMREQ <= '0'; nLHE <= '0'; nBHE <= '0';
         when "0100" => nMREQ <= '1'; nLHE <= '1'; nBHE <= '1';
         when "0010" => nMREQ <= '0'; nLHE <= '0'; nBHE <= '1';
         when "0001" => nMREQ <= '1'; nLHE <= '1'; nBHE <= '1';
      when others => NULL;
      end case;
      nRD <= nfRD and niRD;
      nWR <= niWR;
   end process;
   
   process (DBUS)
   begin
      case bst is
         when "1000" => IRnew <= DBUS;
         when "0100" => DBUS  <= "ZZZZZZZZ";
         when "0010" =>
            if nWR = '0' then
               DBUS(7 downto 0) <= ALUout(7 downto 0);
            elsif nRD = '0' then
               Rtemp(7 downto 0) <= DBUS(7 downto 0);
            end if;
         when "0001" => DBUS  <= "ZZZZZZZZ";
         when others => NULL;
      end case;
   end process;
   
   process (PC, ADDR)
   begin
      case bst is
         when "1000" => ABUS <= PC;
         when "0100" => ABUS <= "UUUUUUUU";
         when "0010" => ABUS <= ADDR;
         when "0001" => ABUS <= "UUUUUUUU";
         when others => NULL;
      end case;
   end process;

end Behavioral;


--------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    15:45:51 07/09/2014 
-- Design Name: 
-- Module Name:    memo - Behavioral 
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

entity memo is
    Port ( en : in STD_LOGIC;
			  IR : in STD_LOGIC_VECTOR(15 downto 0);
           Addr : in STD_LOGIC_VECTOR(15 downto 0);
			  Data : in STD_LOGIC_VECTOR(7 downto 0);
			  ALUout : in STD_LOGIC_VECTOR(7 downto 0);
			  Rtemp  : in STD_LOGIC_VECTOR(7 downto 0);
			  nWR : out STD_LOGIC;
			  nRD : out STD_LOGIC;
			  MAR : out STD_LOGIC_VECTOR(15 downto 0);
			  MDR : out STD_LOGIC_VECTOR(7 downto 0);
			  ACSout : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end memo;

architecture Behavioral of memo is

   -- Aliases 
	alias OP  : STD_LOGIC_VECTOR(4 downto 0) is IR(15 downto 11);
	alias AD1 : STD_LOGIC_VECTOR(2 downto 0) is IR(10 downto 8);
   alias AD2 : STD_LOGIC_VECTOR(2 downto 0) is IR(2 downto 0); -- Register to register
   alias AD  : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Others type
   alias X   : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Operands

	-- instructions table
   constant iNOP : STD_LOGIC_VECTOR := "00000";
	constant iJMP : STD_LOGIC_VECTOR := "00001";
	constant iJZ  : STD_LOGIC_VECTOR := "00010";
	constant iSUB : STD_LOGIC_VECTOR := "00100";
	constant iADD : STD_LOGIC_VECTOR := "00110";
	constant iMVI : STD_LOGIC_VECTOR := "01000";
	constant iMOV : STD_LOGIC_VECTOR := "01010";
	constant iSTA : STD_LOGIC_VECTOR := "01100";
	constant iLDA : STD_LOGIC_VECTOR := "01110";
	constant iOUT : STD_LOGIC_VECTOR := "10000";
	constant iIN  : STD_LOGIC_VECTOR := "10010";

begin

	process (en)
	begin
		if en'event and en = '1' then
			case op is
				when iJMP => MAR <= Addr;
				when iJZ  => MAR <= Addr;
				when iSub => ACSout <= ALUout;
				when iADD => ACSout <= ALUout;
				when iMVI => ACSout <= ALUout;
				when iMOV => ACSout <= ALUout;
				when iSTA => MAR <= Addr;
								 MDR <= ALUout;
								 nWR <= '0';
				when iLDA => MAR <= Addr;
								 nRD <= '0';
								 ACSout <= Rtemp;
				-- when iOUT => ;
				-- when iIN  => ;
				when others => NULL;
			end case;
		else
			nWR <= '1';
			nRD <= '1';
		end if;
	end process;
	
	process (Rtemp)
	begin
		ACSout <= Rtemp;
	end process;
	
end Behavioral;


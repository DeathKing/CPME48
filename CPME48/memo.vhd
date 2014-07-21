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
    Port ( en     : in    STD_LOGIC;
           rst    : in    STD_LOGIC;
			  IR     : in    STD_LOGIC_VECTOR(15 downto 0);
           Addr   : in    STD_LOGIC_VECTOR(15 downto 0);
			  ALUout : in    STD_LOGIC_VECTOR(7 downto 0);
			  Rtemp  : in    STD_LOGIC_VECTOR(7 downto 0);
			  nWR    : out   STD_LOGIC;
			  nRD    : out   STD_LOGIC;
           nPREQ  : out   STD_LOGIC;
           nPWR   : out   STD_LOGIC;
           nPRD   : out   STD_LOGIC;
			  MAR    : out   STD_LOGIC_VECTOR(15 downto 0);
			  MDR    : out   STD_LOGIC_VECTOR(7 downto 0);
           IOAD   : out   STD_LOGIC_VECTOR(2 downto 0);
           IOin   : in    STD_LOGIC_VECTOR(7 downto 0);
           IOout  : out   STD_LOGIC_VECTOR(7 downto 0);
			  ACSout : out   STD_LOGIC_VECTOR(7 downto 0));
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

   -- IR48*
   constant iAMOV : STD_LOGIC_VECTOR := "10001";
	constant iCMP  : STD_LOGIC_VECTOR := "10110";
	constant iJNE  : STD_LOGIC_VECTOR := "11100";
	constant iJE   : STD_LOGIC_VECTOR := "11010";
	constant iJFR  : STD_LOGIC_VECTOR := "10100";
	constant iJBR  : STD_LOGIC_VECTOR := "11101";
	constant iPUSH : STD_LOGIC_VECTOR := "11001";
	constant iPOP  : STD_LOGIC_VECTOR := "11110";
	constant iSPSH : STD_LOGIC_VECTOR := "11011";
	constant iSPOP : STD_LOGIC_VECTOR := "10011";
	constant iCALL : STD_LOGIC_VECTOR := "11000";
	constant iRET  : STD_LOGIC_VECTOR := "11111";
	constant iINC  : STD_LOGIC_VECTOR := "10101";
	constant iDEC  : STD_LOGIC_VECTOR := "10111";


begin

	process (ALUout, IOin, Addr, Rtemp, IOin, en, rst, IR, OP)
	begin
      if rst = '1' then
         ACSout <= "00000000";
			IOout <= "ZZZZZZZZ";
         nRD <= '1';
         nWR <= '1';
         nPRD <= '1';
         nPWR <= '1';
         nPREQ <= '1';
		else
			if en = '1' then
				case OP is
					when iJMP => MAR    <= Addr;   nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					when iJZ  => MAR    <= Addr;   nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iSUB => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iADD => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iMVI => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iMOV => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iJE  => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iDEC => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iINC => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					-- when iCMP => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
					when iPOP => MAR    <= Addr;   nRD <= '0'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
					             IOout  <= (others => 'Z'); ACSout <= Rtemp;
					when iSPOP=> MAR    <= Addr;   nRD <= '0'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
					             IOout  <= (others => 'Z'); ACSout <= Rtemp;
					when iPUSH=> MAR    <= Addr;   nRD <= '1'; nWR <= '0'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
									 MDR    <= ALUout; IOout <= (others => 'Z');
					when iSPSH=> MAR    <= Addr;   nRD <= '1'; nWR <= '0'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
									 MDR    <= ALUout; IOout <= (others => 'Z');
					when iSTA => MAR    <= Addr;   nRD <= '1'; nWR <= '0'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
                            MDR    <= ALUout; IOout <= (others => 'Z');
					when iAMOV=> MAR    <= Addr;   nRD <= '0'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
                            IOout <= (others => 'Z'); ACSout <= Rtemp;
					when iCALL=> MAR    <= Addr;   nRD <= '1'; nWR <= '0'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
									 MDR    <= ALUout; IOout <= (others => 'Z');
					when iRET => MAR    <= Addr;   nRD <= '0'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
                            IOout <= (others => 'Z'); ACSout <= Rtemp;
					when iLDA => MAR    <= Addr;   nRD <= '0'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1';
                            IOout <= (others => 'Z'); ACSout <= Rtemp;
					when iOUT => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '0'; nPREQ <= '0';
                            IOout <= ALUout; IOAD <= Ad2;
					when iIN  => ACSout <= IOin;   nRD <= '1'; nWR <= '1'; nPRD <= '0'; nPWR <= '1'; nPREQ <= '0';
                            IOout <= (others => 'Z'); IOAD <= Ad2;
					when others => ACSout <= ALUout; nRD <= '1'; nWR <= '1'; nPRD <= '1'; nPWR <= '1'; nPREQ <= '1'; IOout <= (others => 'Z');
				end case;
			end if;
			
			if en = '0' then
				-- reset all flags
				nWR <= '1';
				nRD <= '1';
				nPWR <= '1';
				nPRD <= '1';
				nPREQ <= '1';
				IOout <= "ZZZZZZZZ";
			end if;
      
		end if;
		
	end process;
	
end Behavioral;


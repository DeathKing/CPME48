----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    16:21:38 07/11/2014 
-- Design Name: 
-- Module Name:    wrback - Behavioral 
-- Project Name:   CPME48
-- Target Devices: 
-- Tool versions: 
-- Description: Write back unit.
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

entity wrback is
    Port ( en     : in   STD_LOGIC;
           ALUout : in   STD_LOGIC_VECTOR(7 downto 0);
           IR     : in   STD_LOGIC_VECTOR(15 downto 0);
           Addr   : in   STD_LOGIC_VECTOR(15 downto 0);
           PC     : in   STD_LOGIC_VECTOR(15 downto 0);
           CS     : in   STD_LOGIC_VECTOR(15 downto 0);
           SP     : in   STD_LOGIC_VECTOR(7 downto 0);
           Rsp    : out  STD_LOGIC_VECTOR(7 downto 0);
           Raddr  : out  STD_LOGIC_VECTOr(2 downto 0);
           Rdata  : out  STD_LOGIC_VECTOR(7 downto 0);
           PCnew  : out  STD_LOGIC_VECTOR(15 downto 0);
           PCupdate : out  STD_LOGIC;
           Rupdate  : out  STD_LOGIC);
end wrback;

architecture Behavioral of wrback is

   -- Aliases 
   alias OP  : STD_LOGIC_VECTOR(4 downto 0) is IR(15 downto 11);
   alias AD1 : STD_LOGIC_VECTOR(2 downto 0) is IR(10 downto 8);
   alias AD2 : STD_LOGIC_VECTOR(2 downto 0) is IR(2 downto 0); -- Register to register
   alias AD  : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Others type
   alias X   : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Operands

   -- Flag alias
   alias fZF : STD_LOGIC is ALUout(0);
   alias fOF : STD_LOGIC is ALUout(1);

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
  
  process (en, ALUout, Addr, CS)
  begin
    if en'event and en = '1' then
      Raddr <= Ad1;
      Rdata <= ALUout;
         case OP is
            when iJMP  => PCnew <= Addr; Rupdate <= '0';
            when iJZ   => if ALUout = 0 then
                              PCnew <= Addr;
                  else
                      PCnew <= PC + 1;
                  end if;
                  Rupdate <= '0';
            when iSUB  => PCnew <= PC + 1; Rupdate <= '1';
            when iADD  => PCnew <= PC + 1; Rupdate <= '1';
            when iMOV  => PCnew <= PC + 1; Rupdate <= '1';
            when iMVI  => PCnew <= PC + 1; Rupdate <= '1';
            when iLDA  => PCnew <= PC + 1; Rupdate <= '1';
            when iIN   => PCnew <= PC + 1; Rupdate <= '1';
            -- IR48*
            when iDEC  => PCnew <= PC + 1; Rupdate <= '1';
            when iINC  => PCnew <= PC + 1; Rupdate <= '1';
            when iAMOV => PCnew <= PC + 1; Rupdate <= '1';
            when iCMP  => PCnew <= PC + 1; Rupdate <= '1';
            when iJE   => if fZF = '1' then PCnew <= Addr;
                          else PCnew <= PC + 1;
                          end if;
                          Rupdate <= '0';
            when iJNE  => if fZf = '0' then PCnew <= Addr;
                          else PCnew <= PC + 1;
                          end if;
                          Rupdate <= '0';
            when iJFR  => PCnew <= Addr; Rupdate <= '0';
            when iJBR  => PCnew <= Addr; Rupdate <= '0';
            when iPOP  => PCnew <= PC + 1; Rsp <= SP - 1; Rupdate <= '1';
            when iSPOP => PCnew <= PC + 1; Rsp <= SP - 1; Rupdate <= '1';
            when iRET  => PCnew <= CS + ("00000000" & ALUout); Rsp <= SP - 1; Rupdate <= '1';
            when iCALL => PCnew <= CS + ("00000000" & X);      Rsp <= SP + 1; Rupdate <= '1';
            when iPUSH => PCnew <= PC + 1;                     Rsp <= SP + 1; Rupdate <= '1';
            when iSPSH => PCnew <= PC + 1;                     Rsp <= SP + 1; Rupdate <= '1';
            when others => PCnew <= PC + 1; Rupdate <= '0';
         end case;
         PCupdate <= '1';
    end if;
    
    if en = '0' then
        Rupdate <= '0';
        PCupdate <= '0';
    end if;
    
  end process;

end Behavioral;


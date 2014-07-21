----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:    15:18:23 07/09/2014 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name:   CPME48
-- Target Devices: 
-- Tool versions: 
-- Description: alu.vhd is calculate modular.
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

entity alu is
   Port ( en      : in  STD_LOGIC;
          rst     : in  STD_LOGIC;
          Rupdate : in  STD_LOGIC;
          Rdata   : in  STD_LOGIC_VECTOR(7 downto 0);
          Raddr   : in  STD_LOGIC_VECTOR(2 downto 0);
          IR      : in  STD_LOGIC_VECTOR(15 downto 0);
			 PC      : in  STD_LOGIC_VECTOR(15 downto 0);
			 SPnew   : in  STD_LOGIC_VECTOR(7  downto 0);
          Addr    : out STD_LOGIC_VECTOR(15 downto 0);
          CSout   : out STD_LOGIC_VECTOR(15 downto 0);
			 SPout   : out STD_LOGIC_VECTOR(7 downto 0);
			 Reg0    : out STD_LOGIC_VECTOR(7 downto 0);
			 Reg1    : out STD_LOGIC_VECTOR(7 downto 0);
			 --FLAGout : out STD_LOGIC_VECTOR(7 downto 0);
          ALUout  : out STD_LOGIC_VECTOR(7 downto 0));
end alu;

architecture Behavioral of alu is

   subtype registr is STD_LOGIC_VECTOR(7 downto 0);
   type    reg_group is array (0 to 7) of registr;
   
   signal Reg : reg_group := (others => "00000000");
   
   subtype ext_reg is STD_LOGIC_VECTOR(15 downto 0);
   
   signal CS : ext_reg := "0000000000000001";
   signal DS : ext_reg := "0000000100000000";
   signal SS : ext_reg := "0000001000000000";
   signal FLAG : registr := "00000000";
   
   alias fZF : STD_LOGIC is FLAG(0);
   alias fOF : STD_LOGIC is FLAG(1);
   
   -- New Register name in IR48*
   alias AX : registr is Reg(0);
   alias BX : registr is Reg(1);
   alias CX : registr is Reg(2);
   alias DX : registr is Reg(3);
   alias SI : registr is Reg(4);
   alias DI : registr is Reg(5);
   alias SP : registr is Reg(6);
   alias BP : registr is Reg(7);
   
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

   process (en, rst, op, IR, Rupdate, Rdata, Raddr, Reg)
   begin
		if rst = '1' then
			Reg(0) <= "00000000";
         Reg(1) <= "00000000";
         Reg(2) <= "00000000";
         Reg(3) <= "00000000";
         Reg(4) <= "00000000";
         Reg(5) <= "00000000";
         Reg(6) <= "00000000";
         Reg(7) <= "00000000";
         
         CS <= "0000000000000001";
         DS <= "0000000100000000";
         SS <= "0000001000000000";
         
         FLAG <= "00000000";
         
      elsif en = '1' then
         -- Addr   <= (others => 'Z');
         -- ALUout <= (others => 'Z');
			SPout <= SP;
         case op is
            -- update to IR48
            when iADD  => ALUout <= Reg(CONV_INTEGER(Ad1)) + Reg(CONV_INTEGER(Ad2));
            when iSUB  => ALUout <= Reg(CONV_INTEGER(Ad1)) - Reg(CONV_INTEGER(Ad2));
            when iMOV  => ALUout <= Reg(CONV_INTEGER(Ad2));
            when iMVI  => ALUout <= X;
            when iSTA  => ALUout <= Reg(CONV_INTEGER(Ad1));
                            Addr <= SS + ("00000000" & X);
            when iLDA  =>   Addr <= SS + ("00000000" & X);
            when iJZ   => ALUout <= Reg(CONV_INTEGER(Ad1));
				                Addr <= CS + ("00000000" & X);
            when iJMP  =>   Addr <= CS + ("00000000" & X);
            when iOUT  => ALUout <= Reg(CONV_INTEGER(Ad1));
            -- IR48*
				when iCMP  => ALUout <= Reg(CONV_INTEGER(Ad1)) - Reg(CONV_INTEGER(Ad2));
            when iJE   => ALUout <= FLAG;
                            Addr <= CS + ("00000000" & X);
            when iJNE  => ALUout <= FLAG;
                            Addr <= CS + ("00000000" & X);
            when iJFR  =>   Addr <= PC + ("00000000" & X);
            when iJBR  =>   Addr <= PC - ("00000000" & X);
            when iPUSH => ALUout <= Reg(CONV_INTEGER(Ad1));
                            Addr <= SS + ("00000000" & SP);
            when iSPSH =>   Addr <= SS + ("00000000" & SP);
                          if Ad1 = "000" then
                              ALUout <= PC(7 downto 0);
                          elsif Ad = "111" then
                              ALUout <= FLAG;
                          end if;
            when iPOP  =>   Addr <= SS - 1 + ("00000000" & SP);
            when iSPOP =>   Addr <= SS - 1 + ("00000000" & SP);
            when iAMOV =>   Addr <= SS - 2 + ("00000000" & (BP - X));
            when iDEC  => ALUout <= Reg(CONV_INTEGER(Ad1)) - 1;
            when iINC  => ALUout <= Reg(CONV_INTEGER(Ad1)) + 1;
            when iCALL => ALUout <= PC(7 downto 0) + 1;
                            Addr <= SS + ("00000000" & SP);
            when iRET  =>   Addr <= SS + ("00000000" & SP);
            when others => NULL;
         end case;
      elsif Rupdate = '1' then
         -- Register write
         case op is
				when iJZ   => NULL;
			   when iJE   => NULL;
				when iJNE  => NULL;
				when iJMP  => NULL;
            when iCMP  => FLAG <= not Rdata;
            when iSPSH => SP   <= SPnew;
            when iPUSH => SP   <= SPnew;
            when iPOP  => if Raddr = "110" then SP   <= SPnew;
								  else SP <= SPnew; Reg(CONV_INTEGER(Raddr)) <= Rdata;
								  end if;
            when iSPOP => SP   <= SPnew;
								  if Raddr = "111" then FLAG <= Rdata;
								  end if;
            when iRET  => SP   <= SPnew;
				when iCALL => SP   <= SPnew;
				when iMVI  => Reg(CONV_INTEGER(Ad1)) <= X;
				when iMOV  => Reg(CONV_INTEGER(Raddr)) <= Rdata;
            when others => Reg(CONV_INTEGER(Raddr)) <= Rdata;
         end case;
		end if;
   end process;
	
   -- For Inspect
	Reg0 <= AX;
	Reg1 <= FLAG;
   -- Share to wrback modular.
   CSout <= CS;
	
end Behavioral;


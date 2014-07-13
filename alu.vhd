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

entity alu is
   Port ( en : in STD_LOGIC;
          rst : in STD_LOGIC;
          Rupdate : in STD_LOGIC;
          Rdata : in STD_LOGIC_VECTOR(7 downto 0);
          Rtemp : in STD_LOGIC_VECTOR(7 downto 0);
          IR : in STD_LOGIC_VECTOR(15 downto 0);
          nRD : out STD_LOGIC;
          nWR : out STD_LOGIC;
          ALUout: out STD_LOGIC_VECTOR(7 downto 0));
end alu;

architecture Behavioral of alu is

   subtype registr is STD_LOGIC_VECTOR (7 downto 0);
   type    reg_group is array (0 to 7) of registr;
   
   signal Reg : reg_group ;
   
   -- Aliases 
	alias OP  : STD_LOGIC_VECTOR(4 downto 0) is IR(15 downto 11);
	alias AD1 : STD_LOGIC_VECTOR(2 downto 0) is IR(10 downto 8);
   alias AD2 : STD_LOGIC_VECTOR(2 downto 0) is IR(2 downto 2); -- Register to register
   alias AD  : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Others type
   alias X   : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Operands

	-- instructions table
	constant iJMP : STD_LOGIC_VECTOR := "00000";
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
            when iADD => ALUout <= Reg(Ad1) + Reg(Ad2);
            when iSUB => ALUout <= Reg(Ad1) - Reg(Ad2);
            when iMOV => ALUout <= Reg(Ad2);
            when iMVI => ALUout <= X;
            when iSTA => ALUout <= Reg(Ad1);
                           Addr <= Reg(7) & X;
                            nRW <= '0';
            when iLDA => ALUout <= (others => 'Z');
                           Addr <= Reg(7) & X;
                            nRD <= '0';
            when iJZ  => ALuout <= (others => 'z');
            when iJMP => ALUout <= (others => 'z');
            -- when _OUT
            -- when _IN
            when others => NULL;
         end case;
      elsif en'event and en = '0' then
         Rtemp <= (others => 'Z');
         nRD <= '1';
         nWR <= '1';
      end if;
   end process;
   
   process (Rupdate)
   begin
      if Rupdate'event and Rupdate = '1' and en = '1' then
         Reg(Raddr) <= Rdata;
      end if;
   end process;

   process (rst)
   begin
      if rst'event and rst = '1' then
         Reg(0) <= "00000000";
         Reg(1) <= "00000000";
         Reg(2) <= "00000000";
         Reg(3) <= "00000000";
         Reg(4) <= "00000000";
         Reg(5) <= "00000000";
         Reg(6) <= "00000000";
         Reg(7) <= "00000000";
      end if;
   end process;
   
end Behavioral;


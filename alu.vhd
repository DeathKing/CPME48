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
          Rupdate : in STD_LOGIC;
          Rdata : in STD_LOGIC_VECTOR(7 downto 0);
          Rtemp : in STD_LOGIC_VECTOR(7 downto 0);
          IR : in STD_LOGIC_VECTOR(15 downto 0);
          ALUout: out STD_LOGIC_VECTOR(7 downto 0));
end alu;

architecture Behavioral of alu is

   subtype _register is STD_LOGIC_VECTOR (7 downto 0);
   type    reg_group is array (0 to 7) of _register;
   
   signal Reg : reg_group ;
   
   -- Aliases 
	alias OP  : STD_LOGIC_VECTOR(4 downto 0) is IR(15 downto 12);
	alias AD1 : STD_LOGIC_VECTOR(2 downto 0) is IR(10 downto 8);
   alias AD2 : STD_LOGIC_VECTOR(2 downto 0) is IR(2 downto 2); -- Register to register
   alias AD  : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Others type
   alias X   : STD_LOGIC_VECTOR(7 downto 0) is IR(7 downto 0); -- Operands

	-- instructions table
	constant _JMP : STD_LOGIC_VECTOR := "00000";
	constant _JZ  : STD_LOGIC_VECTOR := "00010";
	constant _SUB : STD_LOGIC_VECTOR := "00100";
	constant _ADD : STD_LOGIC_VECTOR := "00110";
	constant _MVI : STD_LOGIC_VECTOR := "01000";
	constant _MOV : STD_LOGIC_VECTOR := "01010";
	constant _STA : STD_LOGIC_VECTOR := "01100";
	constant _LDA : STD_LOGIC_VECTOR := "01110";
	constant _OUT : STD_LOGIC_VECTOR := "10000";
	constant _IN  : STD_LOGIC_VECTOR := "10010";

begin

   process (en)
   begin
      if en'event and en = '1' then
         case op is
            when _ADD => ALUout <= Reg(Ad1(IR)) + Reg(Ad2(IR));
                           Addr <= Ad1(IR);
            when _SUB => ALUout <= Reg(Ad1(IR)) - Reg(Ad2(IR));
                           Addr <= Ad1(IR);
            when _MOV => ALUout <= Reg(Ad2(IR));
                           Addr <= Ad1(IR);
            when _MVI => ALUout <= X;
                           Addr <= Ad1(IR);
            when _STA => ALUout <= Reg(Ad1(IR));
                           Addr <= Reg(7) & X;
                            nRW <= '0';
            when _LDA => ALUout <= (others => 'Z');
                           Addr <= Reg(7) & X;
                            nRD <= '0';
            when _JZ  => ALuout <= (others => 'z');
                         PCnew  <= (Reg(Ad1(IR)) and Ad(IR)) or
                                   (not Reg(Ad1(IR)) and (PC + 1));
            when _JMP => ALUout <= ;
                          PCnew <= Ad(IR);
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

end Behavioral;


--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:59 07/13/2014
-- Design Name:   
-- Module Name:   E:/CPME48/test_memo.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memo
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_memo IS
END test_memo;
 
ARCHITECTURE behavior OF test_memo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memo
    PORT(
         en : IN  std_logic;
         IR : IN  std_logic_vector(15 downto 0);
         Addr : IN  std_logic_vector(15 downto 0);
         Data : IN  std_logic_vector(7 downto 0);
         ALUout : IN  std_logic_vector(7 downto 0);
         Rtemp : IN  std_logic_vector(7 downto 0);
         nWR : OUT  std_logic;
         nRD : OUT  std_logic;
         MAR : OUT  std_logic_vector(15 downto 0);
         MDR : OUT  std_logic_vector(7 downto 0);
         ACSout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal IR : std_logic_vector(15 downto 0) := (others => '0');
   signal Addr : std_logic_vector(15 downto 0) := (others => '0');
   signal Data : std_logic_vector(7 downto 0) := (others => '0');
   signal ALUout : std_logic_vector(7 downto 0) := (others => '0');
   signal Rtemp : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal nWR : std_logic;
   signal nRD : std_logic;
   signal MAR : std_logic_vector(15 downto 0);
   signal MDR : std_logic_vector(7 downto 0);
   signal ACSout : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace en below with 
   -- appropriate port name 
 
   constant en_period : time := 10 ns;

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

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memo PORT MAP (
          en => en,
          IR => IR,
          Addr => Addr,
          Data => Data,
          ALUout => ALUout,
          Rtemp => Rtemp,
          nWR => nWR,
          nRD => nRD,
          MAR => MAR,
          MDR => MDR,
          ACSout => ACSout
        );

   -- Clock process definitions
   en_process :process
   begin
		en <= '0';
		wait for en_period/2;
		en <= '1';
		wait for en_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		IR <= iSTA & "000" & "11111111";
		ALUout <= "11111111";
		Addr <= "0000000011111111";
		wait for en_period;
		
      IR <= iLDA & "000" & "11111111";
		Addr <= "0000000011111111";
		wait for 6 ns;
		Rtemp <= "00001111";
		wait for 4 ns;
		
		IR <= iJZ & "000" & "11111111";
		Addr <= "0000000011111111";
		wait for en_period;
		
		IR <= iAdd & "000" & "11111111";
		ALUout <= "11110000";
		Addr <= "0000000011111111";
		wait for en_period;
		
      wait;
   end process;

END;

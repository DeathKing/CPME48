--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:54:17 07/16/2014
-- Design Name:   
-- Module Name:   D:/Code/VHDL/CPME48/test_memo.vhd
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
         rst : IN std_logic;
         IR : IN  std_logic_vector(15 downto 0);
         Addr : IN  std_logic_vector(15 downto 0);
         ALUout : IN  std_logic_vector(7 downto 0);
         Rtemp : IN  std_logic_vector(7 downto 0);
         nWR : OUT  std_logic;
         nRD : OUT  std_logic;
         nPREQ : OUT  std_logic;
         nPWR : OUT  std_logic;
         nPRD : OUT  std_logic;
         MAR : OUT  std_logic_vector(15 downto 0);
         MDR : OUT  std_logic_vector(7 downto 0);
         IOAD : INOUT  std_logic_vector(2 downto 0);
         IODB : INOUT  std_logic_vector(7 downto 0);
         ACSout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal rst : std_logic := '0';
   signal IR : std_logic_vector(15 downto 0) := (others => '0');
   signal Addr : std_logic_vector(15 downto 0) := (others => '0');
   signal ALUout : std_logic_vector(7 downto 0) := (others => '0');
   signal Rtemp : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal IOAD : std_logic_vector(2 downto 0);
   signal IODB : std_logic_vector(7 downto 0);

 	--Outputs
   signal nWR : std_logic;
   signal nRD : std_logic;
   signal nPREQ : std_logic;
   signal nPWR : std_logic;
   signal nPRD : std_logic;
   signal MAR : std_logic_vector(15 downto 0);
   signal MDR : std_logic_vector(7 downto 0);
   signal ACSout : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace en below with 
   -- appropriate port name 
 
   constant en_period : time := 10 ns;

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
          rst => rst,
          IR => IR,
          Addr => Addr,
          ALUout => ALUout,
          Rtemp => Rtemp,
          nWR => nWR,
          nRD => nRD,
          nPREQ => nPREQ,
          nPWR => nPWR,
          nPRD => nPRD,
          MAR => MAR,
          MDR => MDR,
          IOAD => IOAD,
          IODB => IODB,
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
      -- reset modular
      wait for 1 ns;
      rst <= '1';
      wait for 2 ns;
      rst <= '0';
      wait for 1 ns;
      ---
      -- Test LDA R0,FF00H
      -- Suppose [FF00H] fetched back after 2 ns
      IR <= iLDA & "000" & "00000000";
      Addr <= "1111111100000000";
      wait for 2 ns;
      Rtemp <= "10101010";
      wait for 8 ns;
      -- Test STA R0,ABCDH
      -- Suppose R0 is 22H
      IR <= iSTA & "000" & "11001101";
      Addr <= "1010101111001101";
      ALUout <= "00100010";
      wait for en_period;
      -- Test IN R1,P2
      -- IN instruction need no addr
      IR <= iIN & "001" & "00000" & "001";
      wait for 2 ns;
      IODB <= "00110011";
      wait for en_period;
      -- Test OUT R1,P2
      -- Suppose R1 is F0H
      IODB <= "ZZZZZZZZ";
      IR <= iOUT & "001" & "00000" & "010";
      ALUout <= "11110000";
      wait for en_period;
      wait;
   end process;

END;

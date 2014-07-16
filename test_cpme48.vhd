--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:49:43 07/16/2014
-- Design Name:   
-- Module Name:   CPME48/test_cpme48.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpme48
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
 
ENTITY test_cpme48 IS
END test_cpme48;
 
ARCHITECTURE behavior OF test_cpme48 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpme48
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         ABUS : OUT  std_logic_vector(15 downto 0);
         DBUS : INOUT  std_logic_vector(15 downto 0);
			IR   : out   STD_LOGIC_VECTOR(15 downto 0);
         nMREQ : OUT  std_logic;
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nLHE : OUT  std_logic;
         IOAD : OUT  std_logic_vector(2 downto 0);
         IODB : INOUT  std_logic_vector(7 downto 0);
         nPREQ : OUT  std_logic;
         nPRD : OUT  std_logic;
         nPWR : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

	--BiDirs
   signal DBUS : std_logic_vector(15 downto 0);
   signal IODB : std_logic_vector(7 downto 0);

 	--Outputs
   signal ABUS : std_logic_vector(15 downto 0);
   signal nMREQ : std_logic;
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nLHE : std_logic;
   signal IOAD : std_logic_vector(2 downto 0);
   signal nPREQ : std_logic;
   signal nPRD : std_logic;
   signal nPWR : std_logic;
	signal IR   : STD_LOGIC_VECTOR(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
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
   uut: cpme48 PORT MAP (
          rst => rst,
          clk => clk,
          ABUS => ABUS,
          DBUS => DBUS,
			 IR   => IR,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nLHE => nLHE,
          IOAD => IOAD,
          IODB => IODB,
          nPREQ => nPREQ,
          nPRD => nPRD,
          nPWR => nPWR
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      IODB <= "ZZZZZZZZ";
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		rst <= '1';
		wait for 1 ns;
		rst <= '0';
		wait for 4 ns;
		---
		DBUS <= iMVI & "000" & "11110000";
		wait for clk_period * 4;
		---
		DBUS <= iMVI & "001" & "00001111";
		wait for clk_period * 4;
		---
		DBUS <= iADD & "000" & "00000" & "001";
		wait for clk_period * 4;
		---
		DBUS <= iSTA & "000" & "00000000";
		wait for clk_period * 2;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for clk_period * 2;
		---
		DBUS <= iOUT & "000" & "00000" & "000";
		wait for clk_period * 4;
		---
		DBUS <= iIN & "011" & "00000" & "000";
		wait for clk_period;
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		IODB <= "11111111";
		wait for clk_period * 3;
   end process;

END;

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:44:18 07/13/2014
-- Design Name:   
-- Module Name:   D:/Code/VHDL/CPME48/test_alu.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY test_alu IS
END test_alu;
 
ARCHITECTURE behavior OF test_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         en : IN  std_logic;
         rst : IN  std_logic;
         Rupdate : IN  std_logic;
         Rdata : IN  std_logic_vector(7 downto 0);
         Raddr : IN  std_logic_vector(2 downto 0);
         IR : IN  std_logic_vector(15 downto 0);
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         ALUout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal rst : std_logic := '0';
   signal Rupdate : std_logic := '0';
   signal Rdata : std_logic_vector(7 downto 0) := (others => '0');
   signal Raddr : std_logic_vector(2 downto 0) := (others => '0');
   signal IR : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal ALUout : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace en below with 
   -- appropriate port name 
 
   constant en_period : time := 10 ns;
   
   -- instruction tables
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
   uut: alu PORT MAP (
          en => en,
          rst => rst,
          Rupdate => Rupdate,
          Rdata => Rdata,
          Raddr => Raddr,
          IR => IR,
          nRD => nRD,
          nWR => nWR,
          ALUout => ALUout
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
      -- hold reset state for 100 ns.
      wait for en_period/2;
      rst <= '1';
      wait for en_period/2;
      ---
      rst <= '0';
      Rupdate <= '1';
      Raddr <= "000";
      Rdata <= "10101010";
      wait for en_period/2;
      Rupdate <= '0';
      wait for en_period/2;
      ---
      Rupdate <= '1';
      Raddr <= "001";
      Rdata <= "01010101";
      wait for en_period/2;
      Rupdate <= '0';
      wait for en_period/2;
      ---
      IR <= iADD & "000" & "00000" & "001";
      -- insert stimulus here 

      wait;
   end process;

END;

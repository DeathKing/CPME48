--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:12 07/13/2014
-- Design Name:   
-- Module Name:   E:/CPME48/test_wrback.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: wrback
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
 
ENTITY test_wrback IS
END test_wrback;
 
ARCHITECTURE behavior OF test_wrback IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT wrback
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
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal ALUout : std_logic_vector(7 downto 0) := (others => '0');
   signal IR : std_logic_vector(15 downto 0) := (others => '0');
   signal Addr : std_logic_vector(15 downto 0) := (others => '0');
   signal PC : std_logic_vector(15 downto 0) := (others => '0');
   signal CS : std_logic_vector(15 downto 0) := (others => '0');
   
 	--Outputs
   signal Rsp   : std_logic_vector(7 downto 0);
   signal Raddr : std_logic_vector(2 downto 0);
   signal Rdata : std_logic_vector(7 downto 0);
   signal PCnew : std_logic_vector(15 downto 0);
   signal PCupdate : std_logic;
   signal Rupdate : std_logic;
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
   uut: wrback PORT MAP (
          en => en,
          ALUout => ALUout,
          IR => IR,
          Addr => Addr,
          PC => PC,
          CS => CS,
          SP => Rsp,
          Raddr => Raddr,
          Rdata => Rdata,
          PCnew => PCnew,
          PCupdate => PCupdate,
          Rupdate => Rupdate
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
		ALUout <= "11001100";
		PC <= "0000000000000000";
		Addr <= "0000000000000000";
		wait for en_period;
		---
		IR <= iADD & "000" & "00000" & "001";
		wait for en_period;
		---
		IR <= iSUB & "001" & "00000" & "000";
		wait for en_period;
		---
		IR <= iMOV & "001" & "00000" & "000";
		wait for en_period;
		---
		IR <= iMVI & "001" & "11111111";
		ALUout <= "11111111";
		wait for en_period;
		---
		IR <= iJMP & "001" & "00111100";
		ALUout <= "ZZZZZZZZ";
		Addr <= "0000000000111100";
		wait for en_period;
		---
		IR <= iJZ & "001" & "11000011";
		ALUout <= "ZZZZZZZZ";
		Addr <= "0000000011000011";
		wait for en_period;
		---
		IR <= iLDA & "001" & "11111111";
		ALUout <= "10101010";
		Addr <= "0000000011111111";
		wait for en_period;
		---
		IR <= iSTA & "001" & "11000011";
		ALUout <= "ZZZZZZZZ";
		Addr <= "0000000011000011";
		wait for en_period;
      wait;
   end process;

END;

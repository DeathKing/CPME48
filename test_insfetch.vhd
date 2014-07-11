----------------------------------------------------------------------------------
-- Company: Harbin Institute of Technology
-- Engineer: DeathKing<dk@hit.edu.cn>
-- 
-- Create Date:   13:17:26 07/11/2014
-- Design Name:   
-- Module Name:   CPME48/test_insfetch.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: insfetch
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
 
ENTITY test_insfetch IS
END test_insfetch;
 
ARCHITECTURE behavior OF test_insfetch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT insfetch
    PORT(
         en : IN  std_logic;
         IRnew : IN  std_logic_vector(15 downto 0);
         PCnew : IN  std_logic_vector(15 downto 0);
         PCupdate : IN  std_logic;
         PC : OUT  std_logic_vector(15 downto 0);
			IRinspect : OUT  std_logic_vector(15 downto 0);
         nRD : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal en : std_logic := '0';
   signal IRnew : std_logic_vector(15 downto 0) := (others => '0');
   signal PCnew : std_logic_vector(15 downto 0) := (others => '0');
   signal PCupdate : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(15 downto 0);
   signal nRD : std_logic;
	signal IRinspect : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: insfetch PORT MAP (
          en => en,
          IRnew => IRnew,
          PCnew => PCnew,
          PCupdate => PCupdate,
          PC => PC,
          nRD => nRD,
			 IRinspect => IRinspect
        );

   -- Clock process definitions
   clk_process :process
   begin
		en <= '0';
		wait for clk_period/2;
		en <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		wait for clk_period / 2;
      PCnew <= "0101000011110000";
      PCupdate <= '1';
		IRnew <= "1111111111111111";
		wait for 6 ns;
		IRnew <= "0010101010000000";
      --wait for clk_period;
		wait for 4 ns;
      PCupdate <= '0';
		-- wait for 3 ns;
		PCnew <= "1111111111111111";
		IRnew <= "0000000000000000";
      wait for clk_period;
      PCnew <= "0101000000000000";
		IRnew <= "1010101010101010";
      PCupdate <= '1';
      wait for clk_period;
      wait;
   end process;

END;

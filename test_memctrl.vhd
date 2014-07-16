--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:05:10 07/16/2014
-- Design Name:   
-- Module Name:   D:/Code/VHDL/CPME48/test_memctrl.vhd
-- Project Name:  CPME48
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memctrl
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
 
ENTITY test_memctrl IS
END test_memctrl;
 
ARCHITECTURE behavior OF test_memctrl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memctrl
    PORT(
         PC : IN  std_logic_vector(15 downto 0);
         Addr : IN  std_logic_vector(15 downto 0);
         Data : IN  std_logic_vector(15 downto 0);
         ALUout : IN  std_logic_vector(7 downto 0);
         bst : IN  std_logic_vector(3 downto 0);
         nfRD : IN  std_logic;
         niRD : IN  std_logic;
         niWR : IN  std_logic;
         IRnew : OUT  std_logic_vector(15 downto 0);
         Rtemp : OUT  std_logic_vector(7 downto 0);
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nLHE : OUT  std_logic;
         nMREQ : OUT  std_logic;
         ABUS : OUT  std_logic_vector(15 downto 0);
         DBUS : INOUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
    component beat
      Port ( clk   : in  STD_LOGIC;
             rst   : in  STD_LOGIC;
             reset : out STD_LOGIC;
             bst   : out STD_LOGIC_VECTOR(0 to 3));
    end component;

   --Inputs
   signal PC : std_logic_vector(15 downto 0) := (others => '0');
   signal Addr : std_logic_vector(15 downto 0) := (others => '0');
   signal Data : std_logic_vector(15 downto 0) := (others => '0');
   signal ALUout : std_logic_vector(7 downto 0) := (others => '0');
   signal bst : std_logic_vector(3 downto 0) := (others => '0');
   signal nfRD : std_logic := '0';
   signal niRD : std_logic := '0';
   signal niWR : std_logic := '0';
   
   signal clk  : std_logic := '0';
   signal rst  : std_logic := '0';
   signal wire_rst : std_logic;
   signal wire_bst : std_logic_vector(3 downto 0);

	--BiDirs
   signal DBUS : std_logic_vector(15 downto 0);

 	--Outputs
   signal IRnew : std_logic_vector(15 downto 0);
   signal Rtemp : std_logic_vector(7 downto 0);
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nLHE : std_logic;
   signal nMREQ : std_logic;
   signal ABUS : std_logic_vector(15 downto 0);
   
   
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memctrl PORT MAP (
          PC => PC,
          Addr => Addr,
          Data => Data,
          ALUout => ALUout,
          bst => wire_bst,
          nfRD => nfRD,
          niRD => niRD,
          niWR => niWR,
          IRnew => IRnew,
          Rtemp => Rtemp,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nLHE => nLHE,
          nMREQ => nMREQ,
          ABUS => ABUS,
          DBUS => DBUS
        );
        
    btgen: beat port map(
      clk   => clk,
      rst   => rst,
      reset => wire_rst,
      bst   => wire_bst
    );

   -- Clock process definitions
   clk_process: process
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

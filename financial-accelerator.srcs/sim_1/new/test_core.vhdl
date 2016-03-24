LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_core IS
END test_core;
 
ARCHITECTURE behavior OF test_core IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component core
       port (
            operand_A_ieee, operand_B_ieee : in std_logic_vector(31 downto 0);
            result_ieee : out std_logic_vector(31 downto 0);
            clk, rst : in std_logic );
    end component; 
 
--    COMPONENT top
--    PORT(
--         a : IN  std_logic_vector(23 downto 0);
--         b : IN  std_logic_vector(23 downto 0);
--         sum : OUT  std_logic_vector(23 downto 0);
--         clk : IN  std_logic;
--         rst : IN  std_logic
--        );
--    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: core 
        PORT MAP (
          operand_A_ieee => a,
          operand_B_ieee => b,
          result_ieee => sum,
          clk => clk,
          rst => rst
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
      wait for 5 ns;
      wait for 10 ns;
      wait for 100 ns;	

        rst <= '0';

        a <= "00111111100000000000000000000000"; -- 1.0 | 0x3f800000
        b <= "00111111100000000000000000000000"; -- 1.0 | 0x3f800000
        -- result 01000000000000000000000000000000 | 2.0 | 0x40000000
        wait for clk_period;	
        
        a <= "00111111110000000000000000000000"; -- 1.5 | 0x3fc00000
        b <= "00111111110000000000000000000000"; -- 1.5 | 0x3fc00000
        -- result 01000000010000000000000000000000 | 3.0 | 0x40400000
        wait for clk_period;	
        
        a <= "01000000000001100110011001100110"; -- 2.1 | 0x40066666
        b <= "01000000011001100110011001100110"; -- 3.6 | 0x40666666
        -- result 01000000101101100110011001100110 | 5.7 | 0x40b66666
        wait for clk_period;	
        
        a <= "00000000000000000000000000000000"; -- 0.0 | 0x00000000
        b <= "00000000000000000000000000000000"; -- 0.0 | 0x00000000
        -- result 00000000000000000000000000000000 | 0.0 | 0x00000000
        wait for clk_period;
        
        a <= "00111111110001011010101110011111"; -- 1.5443 | 0x3fc5ab9f
        b <= "01000001100100011011011001000110"; -- 18.214 | 0x4191b646
        -- result 01000001100111100001000100000000 | 19.7583 | 0x419e1100
        wait for clk_period;
        
        rst <= '1';
        wait for clk_period;

      -- insert stimulus here 

      wait;
   end process;

END;
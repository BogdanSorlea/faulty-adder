----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2016 09:31:45 PM
-- Design Name: 
-- Module Name: test_inputieee - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_inputieee is
end test_inputieee;

architecture Behavioral of test_inputieee is

    component InputIEEE_8_23_to_8_23
        port ( clk, rst : in std_logic;
              X : in  std_logic_vector(31 downto 0);
              R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;

    --Inputs
    signal X : std_logic_vector(31 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    
    --Outputs
    signal R : std_logic_vector(8+23+2 downto 0);
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: InputIEEE_8_23_to_8_23 
        port map (
            X => X,
            R => R,
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
    
        rst <= '1';
        -- hold reset state for 100 ns.
        wait for 5 ns;
        wait for 10 ns;
        wait for 100 ns;    
        
        rst <= '0';
        
        X <= (others => '0');
        wait for clk_period;
        
        X <= x"3f800000";
        wait for clk_period;
        
        X <= x"3f850000";
        wait for clk_period;
        
        X <= x"40000000";
        wait for clk_period;
        
        wait for clk_period * 20;
        
        rst <= '1';
        wait for clk_period;
    
        wait;
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2016 12:57:42 AM
-- Design Name: 
-- Module Name: test_fsm - Behavioral
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

entity test_fsm is
end test_fsm;

architecture Behavioral of test_fsm is

    -- Component Declaration for the Unit Under Test (UUT)
    component fsm
        Port (
            data_in : in std_logic_vector(31 downto 0);
            data_out : out std_logic_vector(31 downto 0);
            rd_en : out std_logic;
            in_fifo_empty : in std_logic;
            wr_en : out std_logic;
            out_fifo_full : in std_logic;
            clk, rst : in std_logic
        );
    end component;

    --Inputs
    signal data_in : std_logic_vector(31 downto 0) := (others => '0');
    signal in_fifo_empty : std_logic := '1';
    signal out_fifo_full : std_logic := '1';
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    
    --Outputs
    signal data_out : std_logic_vector(31 downto 0);
    signal rd_en : std_logic;
    signal wr_en : std_logic;
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: fsm 
        port map (
            data_in => data_in,
            data_out => data_out,
            rd_en => rd_en,
            in_fifo_empty => in_fifo_empty,
            wr_en => wr_en,
            out_fifo_full => out_fifo_full,
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
        
        --a <= "00111111100000000000000000000000"; -- 1.0 | 0x3f800000
        --b <= "00111111100000000000000000000000"; -- 1.0 | 0x3f800000
        -- result 01000000000000000000000000000000 | 2.0 | 0x40000000
        
        in_fifo_empty <= '0';
        out_fifo_full <= '0';
        data_in <= (others => '0');
        wait for clk_period;
        
        in_fifo_empty <= '0';
        out_fifo_full <= '0';
        data_in <= x"3f800000";
        wait for clk_period;
        
        in_fifo_empty <= '0';
        out_fifo_full <= '0';
        data_in <= x"3f800000";
        wait for clk_period;
        
        in_fifo_empty <= '0';
        out_fifo_full <= '0';
        data_in <= x"40000000";
        wait for clk_period;
        
        wait for clk_period * 20;
        
        rst <= '1';
        wait for clk_period;
    
        wait;
    end process;

end Behavioral;

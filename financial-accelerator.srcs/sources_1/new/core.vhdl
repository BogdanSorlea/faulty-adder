----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2016 08:31:18 PM
-- Design Name: 
-- Module Name: core - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity core is
    port (
        operand_A_ieee, operand_B_ieee : in std_logic_vector(31 downto 0);
        result_ieee : out std_logic_vector(31 downto 0);
        clk, rst : in std_logic
    );
end core;

architecture Behavioral of core is

    component adder
        port (
            A, B: in std_logic_vector(31 downto 0);
            R: out std_logic_vector(31 downto 0)
        );
    end component;

    component FPAdder_8_23_uid2
       port ( clk, rst : in std_logic;
              X : in  std_logic_vector(8+23+2 downto 0);
              Y : in  std_logic_vector(8+23+2 downto 0);
              R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;
    
    component InputIEEE_8_23_to_8_23
       port ( clk, rst : in std_logic;
              X : in  std_logic_vector(31 downto 0);
              R : out  std_logic_vector(8+23+2 downto 0)   );
    end component;
    
    component OutputIEEE_8_23_to_8_23 is
       port ( clk, rst : in std_logic;
              X : in  std_logic_vector(8+23+2 downto 0);
              R : out  std_logic_vector(31 downto 0)   );
    end component;
    
    signal operand_A, operand_B, adder_result : std_logic_vector(8+23+2 downto 0);

begin

    addition: adder port map (operand_A_ieee, operand_B_ieee, result_ieee);

--    ieee_to_flopoco_format_operand_A: InputIEEE_8_23_to_8_23
--        port map (
--            clk => clk,
--            rst => rst,
--            X => operand_A_ieee,
--            R => operand_A
--        );
        
--    ieee_to_flopoco_format_operand_B: InputIEEE_8_23_to_8_23
--        port map (
--            clk => clk,
--            rst => rst,
--            X => operand_B_ieee,
--            R => operand_B
--        );
        
--    FP_adder: FPAdder_8_23_uid2
--        port map (
--            clk => clk,
--            rst => rst,
--            X => operand_A,
--            Y => operand_B,
--            R => adder_result
--        );
    
--    flopoco_format_to_ieee_result: OutputIEEE_8_23_to_8_23
--        port map (
--            clk => clk,
--            rst => rst,
--            X => adder_result,
--            R => result_ieee
--        );

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2016 08:06:18 PM
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

entity fsm is
    Port (
        data_in : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0);
        rd_en : out std_logic;
        in_fifo_empty : in std_logic;
        wr_en : out std_logic;
        out_fifo_full : in std_logic;
        clk, rst : in std_logic
    );
end fsm;

architecture Behavioral of fsm is

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
    
    type state_type is ( start, readA, waitB, addAB );

    signal state, next_state: state_type;

    signal operand_A_ieee : std_logic_vector(31 downto 0);
    signal operand_A, operand_B, adder_result : std_logic_vector(8+23+2 downto 0);

begin

    ieee_to_flopoco_format_operand_A: InputIEEE_8_23_to_8_23
        port map (
            clk => clk,
            rst => rst,
            X => operand_A_ieee,
            R => operand_A
        );
        
    ieee_to_flopoco_format_operand_B: InputIEEE_8_23_to_8_23
        port map (
            clk => clk,
            rst => rst,
            X => data_in,
            R => operand_B
        );
        
    FP_adder: FPAdder_8_23_uid2
        port map (
            clk => clk,
            rst => rst,
            X => operand_A,
            Y => operand_B,
            R => adder_result
        );
    
    flopoco_format_to_ieee_result: OutputIEEE_8_23_to_8_23
        port map (
            clk => clk,
            rst => rst,
            X => adder_result,
            R => data_out
        );

    SL: process (clk, rst)
    begin
        if rising_edge(clk) then
            state <= next_state;
            if state = readA then
                operand_A_ieee <= data_in;
            end if;
        end if;
    end process;
    
    -- TODO: add rst signal as input to the state machine
    CL: process(state, in_fifo_empty)
    begin
        case (state) is
            when start =>
                if rst = '1' then
                    next_state <= start;
                    rd_en <= '0';
                else
                    if in_fifo_empty = '1' then
                        next_state <= start;
                        rd_en <= '0';
                    else
                        next_state <= readA;
                        rd_en <= '1';
                    end if;
                end if;
                wr_en <= '0';
            when readA =>
                if rst = '1' then
                    next_state <= start;
                    rd_en <= '0';
                else
                    if in_fifo_empty = '1' then
                        next_state <= waitB;
                        rd_en <= '0';
                    else
                        next_state <= addAB;
                        rd_en <= '1';
                    end if;
                end if;
                wr_en <= '0';
            when waitB =>
                if rst = '1' then
                    next_state <= start;
                    rd_en <= '0';
                else
                    if in_fifo_empty = '1' then
                        next_state <= waitB;
                        rd_en <= '0';
                    else
                        if out_fifo_full = '1' then
                            next_state <= waitB;
                            rd_en <= '0';
                        else
                            next_state <= addAB;
                            rd_en <= '1';
                        end if;
                    end if;
                end if;
                wr_en <= '0';
            when addAB =>
                if rst = '1' then
                    next_state <= start;
                    rd_en <= '0';
                    wr_en <= '0';
                else
                    if in_fifo_empty = '1' then
                        next_state <= start;
                        rd_en <= '0';
                    else
                        next_state <= readA;
                        rd_en <= '1';
                    end if;
                    wr_en <= '1';
                end if;   
        end case;
    end process;

-- simple integer sum:
--    data_out <= std_logic_vector(unsigned(operand_A_ieee) + unsigned(data_in)) ;
-- simple incrementing of each byte
--    data_out <= std_logic_vector(unsigned(data_in(31 downto 24)) + 1) & std_logic_vector(unsigned(data_in(23 downto 16)) + 1) & 
--                    std_logic_vector(unsigned(data_in(15 downto 8)) + 1) & std_logic_vector(unsigned(data_in(7 downto 0)) + 1);

end Behavioral;

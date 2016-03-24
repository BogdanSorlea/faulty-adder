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
    port (
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
    
    component core
       port (
            operand_A_ieee, operand_B_ieee : in std_logic_vector(31 downto 0);
            result_ieee : out std_logic_vector(31 downto 0);
            clk, rst : in std_logic 
       );
    end component;

    -- pipeline_depth and pipeline_wr_status are used (only) for pipelined cores to assert wr_en when needed
    -- ('1' added to the MSB of pipeline_wr_status when the second 32-bit operand is read and therefore the 
    -- core processing starts with valid data, so that it signals when a valid result reached the end of the core)
    --constant pipeline_depth : integer := 10;
    --signal pipeline_wr_status : std_logic_vector(pipeline_depth - 1 downto 0) := (others => '0');
    
    type state_type is ( start, readA, waitB, addAB );
    signal state, next_state: state_type;

    signal operand_A_ieee : std_logic_vector(31 downto 0) := (others => '0');
    signal result_ieee : std_logic_vector(31 downto 0);

begin

    core_inst: core
        port map (
            operand_A_ieee => operand_A_ieee,
            operand_B_ieee => data_in,
            result_ieee => data_out,
            clk => clk,
            rst => rst
        );

    -- The loopback test (remove core_inst above) works as expected - in the out FIFO the value read from the in FIFO is saved
    --data_out <= data_in;

    SL: process (clk, rst, state, next_state, data_in)--, pipeline_wr_status)
    begin
        if rising_edge(clk) then
            state <= next_state;
            if state = readA then
                operand_A_ieee <= data_in;
            end if;
            -- needed if pipelined core
            --if next_state = addAB then
                --pipeline_wr_status <= "1" & pipeline_wr_status(pipeline_depth-1 downto 1);
            --else
                --pipeline_wr_status <= "0" & pipeline_wr_status(pipeline_depth-1 downto 1);
            --end if;
        end if;
    end process;
    
    -- wr_en flag has beem moved out of the case/process below, for simplicity
    wr_en <= '1' when state = addAB else '0';
    --wr_en <= pipeline_wr_status(0);
    
    -- TODO: add rst signal as input to the state machine
    CL: process(rst, state, in_fifo_empty, out_fifo_full)
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
            when addAB => -- aka readB (read of B operator happens here)
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
            when others =>
                next_state <= start;
                rd_en <= '0';
        end case;
    end process;

end Behavioral;

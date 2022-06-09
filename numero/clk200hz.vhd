library ieee;
use ieee.std_logic_1164.all;

entity clk200Hz is
    Port (
        clk_in : in  std_logic;
        reset  : in  std_logic;
        clk_out: out std_logic
    );
end clk200Hz;

architecture Behavioral of clk200Hz is
    signal temporal: std_logic;
    signal counter : integer range 0 to 124999 := 0;
begin
    frequency_divider: process (reset, clk_in) begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk_in) then
            if (counter = 124999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temporal;
end Behavioral;
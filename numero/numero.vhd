library ieee;
use ieee.std_logic_1164.all;

entity DetNumero is
	port(
		clk: in std_logic;
		reset: in std_logic;
		numBin: in std_logic;
		salida: out std_logic
	);
end entity;

architecture mealy of DetNumero is
	type maquina is (q0,q1,q2,q3);
	signal estado : maquina;
	component clk200Hz
	port(
		clk_in : IN  std_logic;
		reset  : IN  std_logic;
		clk_out: OUT std_logic
	);
	end component;

	-- Inputs
	signal clk_in  : std_logic := '0';
	signal reset   : std_logic := '0';
	-- Outputs
	signal clk_out : std_logic;
	constant clk_in_t : time := 20 ns; 
	begin 
		-- Instance of unit under test.
		uut: clk200Hz port map (
			clk_in  => clk_in,
			reset   => reset,
			clk_out => clk_out
		);

		-- Clock definition.
		entrada_process :process
			begin
			clk_in <= '0';
			wait for clk_in_t / 2;
			clk_in <= '1';
			wait for clk_in_t / 2;
		end process;

		-- Processing.
		stimuli: process
		begin
			reset <= '1'; -- Initial conditions.
			wait for 100 ns;
			reset <= '0'; -- Down to work!
			wait;
		end process;
		

		process (clk,reset,numBin) begin
			if (reset = '1') then
				estado <= q0;
				salida <= '0';
			elsif rising_edge(clk) then
				case(estado) is
					when q0 => 
						if (numBin = '0') then estado <= q0; salida <= '0';
						else  estado <= q1; salida <= '0';
						end if;
					when q1 => 
						if (numBin = '0') then estado <= q2; salida <= '0';
						else  estado <= q0; salida <= '0';
						end if;
					when q2 => 
						if (numBin = '0') then estado <= q0; salida <= '0';
						else  estado <= q3; salida <= '0';
						end if;
					when q3 => 
						if (numBin = '0') then estado <= q0; salida <= '1';
						else  estado <= q0; salida <= '0';
						end if;
					when others => null;
				end case;
			end if;
		end process;
end architecture;

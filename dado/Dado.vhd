library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dado is
	port(
		clk: in std_logic;
		sw: in std_logic;
		salida: out std_logic_vector(5 downto 0)
	);
end dado;

architecture cara of dado is
	type estados is (q1,q2,q3,q4,q5,q6);
	signal estado: estados;
	signal control: std_logic_vector(5 downto 0);
	
	begin
	process (clk,reset) begin 
		if (reset = '1') then
			estado <= q1;
			control <= "001";
		elsif rising_edge(clk) then 
			case (estado) is
				when q1 =>
					estado <= q2;
					control <= "1001111";
				when q2 =>
					estado <= q3;
					control <= "0010010";
				when q3 =>
					estado <= q4;
					control <= "0000110";
				when q4 =>
					estado <= q5;
					control <= "1001100";
				when q5 =>
					estado <= q6;
					control <= "0100100";
				when q6 =>
					estado <= q1;
					control <= "0100000";
				when others => null;
			end case;
	 	end if;
	
	
	if (sw = '1') then
		salida <= control;
	end if;

	end process;
end cara;





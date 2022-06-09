library ieee;
use ieee.std_logic_1164 . all;
 
 entity hola is port(
 	clk: in std_logic;
 	letra: out std_logic_vector (6 downto 0);
	display: out std_logic_vector (1 downto 0) 
	);
 end hola;
 
 architecture estatico of hola is
  
	 
 	type estados is (q0,q1,q2,q3);
 	signal estado: estados;
	signal control: std_logic_vector(6 downto 0);
	
	begin
 
	process (estado,letra,clk) begin
		if rising_edge(clk) then 
			case estado is
				when q0 => 
						control <= "1001000";
						display <= "00";
						estado <= q1;	
	 			when q1 => 
						control <= "0000001"; 
				 		display <= "01";
				 		estado <= q2;
				when q2 => 
						control <= "1110001";	  
						display <= "10";
						estado <= q3; 
				when q3 => 
						control <= "0001000";	  
						display <= "11";
						estado <= q0; 
	 			end case;
		end if;
	letra <= control;
  end process;

 end estatico;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hola is
    Port ( clk : in  STD_LOGIC;
           display : out  STD_LOGIC_VECTOR (3 downto 0);
           letra : out  STD_LOGIC_VECTOR (6 downto 0));
end hola;

architecture marquesina of hola is
	-- Divisor 1
	constant max: INTEGER := 0; --100,000,000
	signal cont: INTEGER range 0 to max;
	signal clk2: STD_LOGIC := '0';
	
	--Divisor 2
	constant max1: INTEGER := 3;
	signal cont1: INTEGER range 0 to max1;
	signal clk3: STD_LOGIC := '0';

	-- Maquina principal
	type estadoP is (VVVV, VVVH, VVHO, VHOL, HOLA, OLAV, LAVV, AVVV);
	signal estado: estadoP := VVVV;
	
	-- Maquina secundaria
	type estadoH is (H, O, L, A);
	signal estadito: estadoH := H;
	
	-- Letras
	constant LV: std_logic_vector(6 downto 0) :="0000000"; -- Vacio
	constant LH: std_logic_vector(6 downto 0) :="0110111"; -- H
 	constant LO: std_logic_vector(6 downto 0) :="1111110"; -- O
 	constant LL: std_logic_vector(6 downto 0) :="0001110"; -- L
	constant LA: std_logic_vector(6 downto 0) :="1110111"; -- A
	
	-- Displays
	constant D1: std_logic_vector(3 downto 0) :="0111";
	constant D2: std_logic_vector(3 downto 0) :="1011";
	constant D3: std_logic_vector(3 downto 0) :="1101";
	constant D4: std_logic_vector(3 downto 0) :="1110";

begin
	divisor1: process(clk, cont, clk2)
	begin
		if (clk'event and clk='1') then
			if (cont < max) then
				cont <= cont + 1;
			else
				clk2 <= not (clk2);
				cont <= 0;
			end if;
		end if;
	end process divisor1;

	divisor2: process(clk2, cont1, clk3)
	begin
		if (clk2'event and clk2='1') then
			if (cont1 < max1) then
				cont1 <= cont1 + 1;
			else
				clk3 <= not (clk3);
				cont1 <= 0;
			end if;
		end if;
	end process divisor2;

	process(clk3, estado)
	begin
		if (rising_edge(clk3)) then
			case estado is
				when VVVV =>
					estado <= VVVH;
				when VVVH =>
					estado <= VVHO;
				when VVHO =>
					estado <= VHOL;
				when VHOL =>
					estado <= HOLA;
				when HOLA =>
					estado <= OLAV;
				when OLAV =>
					estado <= LAVV;
				when LAVV =>
					estado <= AVVV;
				when AVVV =>
					estado <= VVVV;
			end case;
		elsif (falling_edge(clk3)) then
			case estado is
				when VVVV =>
					estado <= VVVH;
				when VVVH =>
					estado <= VVHO;
				when VVHO =>
					estado <= VHOL;
				when VHOL =>
					estado <= HOLA;
				when HOLA =>
					estado <= OLAV;
				when OLAV =>
					estado <= LAVV;
				when LAVV =>
					estado <= AVVV;
				when AVVV =>
					estado <= VVVV;
			end case;
		end if;
	end process;
	process(clk2, estado, estadito)
	begin
		if (clk2'event and clk2='1') then
			case estadito is
				when H =>
					estadito <= O;
				when O =>
					estadito <= L;
				when L =>
					estadito <= A;
				when A =>
					estadito <= H;
			end case;
		end if;
	end process;
	process(estado, estadito)
	begin
		if (estado = VVVV) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LV;
				when O =>
					display <= D2;
					letra <= LV;
				when L =>
					display <= D3;
					letra <= LV;
				when A =>
					display <= D4;
					letra <= LV;
			end case;
		elsif (estado = VVVH) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LV;
				when O =>
					display <= D2;
					letra <= LV;
				when L =>
					display <= D3;
					letra <= LV;
				when A =>
					display <= D4;
					letra <= LH;
			end case;
		elsif (estado = VVHO) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LV;
				when O =>
					display <= D2;
					letra <= LV;
				when L =>
					display <= D3;
					letra <= LH;
				when A =>
					display <= D4;
					letra <= LO;
			end case;
		elsif (estado = VHOL) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LV;
				when O =>
					display <= D2;
					letra <= LH;
				when L =>
					display <= D3;
					letra <= LO;
				when A =>
					display <= D4;
					letra <= LL;
			end case;
		elsif (estado = HOLA) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LH;
				when O =>
					display <= D2;
					letra <= LO;
				when L =>
					display <= D3;
					letra <= LL;
				when A =>
					display <= D4;
					letra <= LA;
			end case;
			elsif (estado = OLAV) then
		case estadito is
				when H =>
					display <= D1;
					letra <= LO;
				when O =>
					display <= D2;
					letra <= LL;
				when L =>
					display <= D3;
					letra <= LA;
				when A =>
					display <= D4;
					letra <= LV;
			end case;
		elsif (estado = LAVV) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LL;
				when O =>
					display <= D2;
					letra <= LA;
				when L =>
					display <= D3;
					letra <= LV;
				when A =>
					display <= D4;
					letra <= LV;
			end case;
		elsif (estado = AVVV) then
			case estadito is
				when H =>
					display <= D1;
					letra <= LA;
				when O =>
					display <= D2;
					letra <= LV;
				when L =>
					display <= D3;
					letra <= LV;
				when A =>
					display <= D4;
					letra <= LV;
			end case;
		end if;

	end process;
end marquesina;



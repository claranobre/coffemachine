library ieee;
use ieee.std_logic_1164.all;

-- Comentarios em VHDL sao feitos com --
-- O circuito a seguir possui uma entrada de 4 bits chamada chaves
-- e uma saida de 7 bits chamada display
--
-- A funcao desse circuito eh receber um valor em binario de 4 bits
-- e mostrar o respectivo valor em hexadecimal num display de sete
-- segmentos
entity controle_display is
    port (
        chaves  : in std_logic_vector(3 downto 0);
        display : out std_logic_vector(6 downto 0)
    );
end controle_display;

architecture controle_display of controle_display is
    -- signals sao a analogia de fios e trilhas nos circuitos
    -- abaixo sao declarados quatro fios, cada um de 1 bit
    signal min0 : std_logic;
    signal min1 : std_logic;
    signal min2 : std_logic;
    signal min3 : std_logic;
	signal min4 : std_logic;
	signal min5 : std_logic;
	signal min6 : std_logic;
	signal min7 : std_logic;
	signal min8 : std_logic;
	signal min9 : std_logic;
	signal minA : std_logic;
	signal minB: std_logic;
	signal minC : std_logic;
	signal minD : std_logic;
	signal minE : std_logic;
	signal minF : std_logic;
	
	signal A : std_logic;
	signal nA : std_logic;
	signal B : std_logic;
	signal nB : std_logic;
	signal C : std_logic;
	signal nC : std_logic;
	signal D : std_logic;
	signal nD : std_logic;
begin

	 A <= chaves(3);
	 nA <= not chaves(3);
	 
	 B <= chaves(2);
	 nB <= not chaves(2);
	 
	 C <= chaves(1);
	 nC <= not chaves(1);
	 
	 D <= chaves(0);
	 nD <= not chaves(0);
	 
	display(0) <= (nc and ((na and ((nb and d) or (b and nd))) or (a and b and d))) or ((a and nb) and (c and d));
	 
	display(1) <= (nd and ((b and c) or (a and b))) or (d and ((a and c) or (na and b and nc)));

	display(2) <= ((a and b) and (c or nd)) or (na and nb and c and nd);

	display(3) <= (d and ((b and c) or (na and nb and nc))) or (nd and ((na and b and nc) or (a and nb and c)));

	display(4) <= (na and (d or (b and nc))) or (nb and nc and d);
	
	display(5) <= (na and ((c and d) or (nb and d) or (nb and c))) or (a and b and nc and d);
	
	display(6) <= (na and ((nb and nc) or (b and c and d))) or (a and b and nc and nd);
	
    -- A tabela verdade a seguir contem a logica
    -- para cada uma das posicoes do display. Ela pode te
    -- ajudar como base para a construcao do circuito
    --
    -- Cada traco/palito/bastao do display de sete segmentos
    -- segue a seguinte logica
    --     0 - acende bastao
    --     1 - apaga bastao
    --
    -- TABELA VERDADE
    -- chaves  |   display
    -- A B C D | 6 5 4 3 2 1 0 << abreviacao para chaves[3], chaves[2], display[5], etc
    -- 0 0 0 0 | 1 0 0 0 0 0 0    mostra 0 no display
    -- 0 0 0 1 | 1 1 1 1 0 0 1    mostra 1 no display
    -- 0 0 1 0 | 0 1 0 0 1 0 0    mostra 2 no display
    -- 0 0 1 1 | 0 1 1 0 0 0 0	  mostra 3 no display
    -- 0 1 0 0 | 0 0 1 1 0 0 1    mostra 4 no display
    -- 0 1 0 1 | 0 0 1 0 0 1 0    mostra 5 no display
    -- 0 1 1 0 | 0 0 0 0 0 1 0    mostra 6 no display
    -- 0 1 1 1 | 1 1 1 1 0 0 0    mostra 7 no display
	-- 1 0 0 0 | 0 0 0 0 0 0 0    mostra 8 no display
    -- 1 0 0 1 | 0 0 1 0 0 0 0    mostra 9 no display
    -- 1 0 1 0 | 0 0 0 1 0 0 0    mostra a no display
    -- 1 0 1 1 | 0 0 0 0 0 1 1    mostra b no display
    -- 1 1 0 0 | 1 0 0 0 1 1 0    mostra c no display
    -- 1 1 0 1 | 0 1 0 0 0 0 1    mostra d no display
    -- 1 1 1 0 | 0 0 0 0 1 1 0    mostra e no display
    -- 1 1 1 1 | 0 0 0 1 1 1 0    mostra f no display

end controle_display;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PO is 
    port (
        clock       : in std_logic;
        reset       : in std_logic;
	cafe_select : in std_logic;
        moeda1      : in std_logic;
	moeda2      : in std_logic;
	moeda3      : in std_logic;
        clr_moeda   : in std_logic;
        valor_cafe  : in std_logic_vector(11 downto 0);
        qtd_ok      : out std_logic;
        dar_troco   : out std_logic;
        valor_troco : out std_logic_vector(11 downto 0);
	tipo_cafe   : out std_logic_vector (1 downto 0);
	reserva     : out std_logic_vector(11 downto 0) --variavel para armazenar moedas para futuros trocos
		  
    );
end PO;

architecture PO of PO is
    signal cont_moedas : std_logic_vector(11 downto 0) := "000000000000";
    signal cafe_tipo   : std_logic_vector(1 downto 0) := "00";
begin
    process (cont_moedas, valor_cafe)
    begin
        if cont_moedas >= valor_cafe then
            qtd_ok <= '1';
        else
            qtd_ok <= '0';
        end if;

        if cont_moedas > valor_cafe then
            dar_troco   <= '1';
            valor_troco <= std_logic_vector(unsigned(cont_moedas) - unsigned(valor_cafe));
        else
            dar_troco   <= '0';
            valor_troco <= "000000000000";
        end if;
    end process;
	 
    tipo_cafe <= cafe_tipo;

	 process (cafe_select, cafe_tipo, reset, clock)
	 begin
        if reset = '1' then
            cafe_tipo <= "00";
		elsif clock'event and clock = '1' then
			if cafe_select = '1' then
				cafe_tipo <= std_logic_vector(unsigned(cafe_tipo) + "01");
			end if;
		end if;
	 end process;
    --regs
    process (clock, reset, clr_moeda)
    begin
        if reset = '1' or clr_moeda = '1' then
            cont_moedas <= "000000000000";
	    reserva <= "000000000000";	-- reserva sem moedas
        elsif clock'event and clock = '1' then
            if moeda1 = '1' then
                cont_moedas <= std_logic_vector(unsigned(cont_moedas) + "000000001010");
		reserva <= cont_moedas; -- receber quantidade de moedas de 10 cents
		elsif moeda2 = '1' then
			cont_moedas <= std_logic_vector(unsigned(cont_moedas) + "000000110010");
			reserva <= cont_moedas; -- receber quantidade de moedas de 50 cents
		elsif moeda3 = '1' then
			cont_moedas <= std_logic_vector(unsigned(cont_moedas) + "000001100100");
			reserva <= cont_moedas; -- receber quantidade de moedas de 1 real (representado por 100)
		else
			cont_moedas <= cont_moedas;
			reserva <= cont_moedas; -- receber valor do contador de moedas
            end if;
        end if;
    end process;
end PO;

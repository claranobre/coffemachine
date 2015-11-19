library ieee;
use ieee.std_logic_1164.all;

entity maq_cafe is
    port (
        clock        : in std_logic;
        reset        : in std_logic;
        cafe_select  : in std_logic;
        botaom1      : in std_logic;
        botaom2      : in std_logic;
        botaom3      : in std_logic;
		confirmar    : in std_logic;
        troco        : out std_logic;
        troco_valor  : out std_logic_vector(11 downto 0);
        led_verde    : out std_logic; -- Indica que o café foi servido
        led_vermelho : out std_logic;  -- Indica falta de dinheiro suficiente para a compra do café selecionado.
        cafe         : out std_logic_vector(1 downto 0) -- mostra o tipo de café para o usuário.
    );
end maq_cafe;

architecture maq_cafe of maq_cafe is
    signal qtd_ok      : std_logic;
    signal moeda1      : std_logic;
    signal moeda2      : std_logic;
    signal moeda3      : std_logic;
	signal tipo_cafe   : std_logic_vector(1 downto 0);
	signal seletor     : std_logic;
    signal clr_moeda   : std_logic;
    signal valor_cafe  : std_logic_vector(11 downto 0);
    signal valor_troco : std_logic_vector(11 downto 0);
    signal dar_troco   : std_logic;
begin
    i0 : entity work.PC
    port map (
        clock, reset, cafe_select, botaom1, botaom2, botaom3, confirmar, troco,
        troco_valor, led_verde, led_vermelho, cafe, qtd_ok, dar_troco, valor_troco, tipo_cafe, moeda1, moeda2, moeda3, clr_moeda, valor_cafe, seletor
    );

    i1 : entity work.PO
    port map (
        clock, reset, seletor, moeda1, moeda2, moeda3, clr_moeda, valor_cafe, qtd_ok, 
        dar_troco, valor_troco, tipo_cafe
    );

end maq_cafe;

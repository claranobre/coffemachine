library ieee;
use ieee.std_logic_1164.all;

entity maq_cafe_tb is
end maq_cafe_tb;


architecture maq_cafe_tb of maq_cafe_tb is
    signal clock       : std_logic;
    signal reset       : std_logic;
    signal cafe_select : std_logic;
    signal botaom1     : std_logic;
    signal botaom2     : std_logic;
    signal botaom3     : std_logic;
    signal confirmar   : std_logic;
    signal troco       : std_logic;
    signal troco_valor : std_logic_vector(11 downto 0);
    signal led_verde   : std_logic;
    signal led_vermelho: std_logic;
    signal cafe        : std_logic_vector(1 downto 0);
begin
    dut : entity work.maq_cafe
    port map (
        clock, reset, cafe_select, botaom1, botaom2, botaom3, confirmar, 
        troco, troco_valor, led_verde, led_vermelho, cafe
    );

    process
    begin
        clock <= '0';   
        wait for 10 ns;
        clock <= '1';
        wait for 10 ns;
    end process;

    process
    begin
        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '1';
        confirmar <= '0';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '1';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '1';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '1';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        reset <= '0';   
        cafe_select <= '0';
        botaom1 <= '0';
        botaom2 <= '0';
        botaom3 <= '0';
        confirmar <= '0';
        wait until clock'event and clock = '1';

        wait;
    end process;
end maq_cafe_tb;

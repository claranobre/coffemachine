library ieee;
use ieee.std_logic_1164.all;

entity PC is
    port (
        clock         : in std_logic;
        reset         : in std_logic;
	cafe_select   : in std_logic;
        botaom1       : in std_logic;
        botaom2       : in std_logic;
        botaom3       : in std_logic;
	confirmar     : in std_logic;
        troco         : out std_logic;
        troco_valor   : out std_logic_vector(11 downto 0);
        led_verde     : out std_logic;
        led_vermelho  : out std_logic;
        cafe          : out std_logic_vector(1 downto 0);
       
        -- vindas da PO
        qtd_ok      : in std_logic;
        dar_troco   : in std_logic;
        valor_troco : in std_logic_vector(11 downto 0);
	tipo_cafe   : in std_logic_vector(1 downto 0);
       
        -- saidas para PO
        moeda1     : out std_logic;
        moeda2     : out std_logic;
        moeda3     : out std_logic;
        clr_moeda  : out std_logic;
        valor_cafe : out std_logic_vector(11 downto 0);
	seletor    : out std_logic
    );
end PC;

architecture PC of PC is
    type state_t is (
        init, 
        espera, 
        inserir_moeda1,
	inserir_moeda2,
	inserir_moeda3,
        verificar_cafe1,
        verificar_cafe2,
        verificar_cafe3,
	verificar_cafe4,
        emitir_cafe1,
        emitir_cafe2,
        emitir_cafe3,
	emitir_cafe4
    );

    signal current_state : state_t;
    signal next_state    : state_t;
	
begin
    --registrador de estado da FSM
    process (clock, reset)
    begin
        if reset = '1' then
            current_state <= init;
        elsif clock'event and clock = '1' then
            current_state <= next_state;
        end if;
    end process;

    process (current_state, qtd_ok, tipo_cafe, cafe_select, confirmar, botaom1, botaom2, botaom3)
    begin
        case current_state is
        when init =>
        moeda1	    <= '0';
	moeda2      <= '0';
	moeda3      <= '0';
	clr_moeda   <= '1';
        troco       <= '0';
	seletor     <= '0';
        valor_cafe  <= "000000000000";
        troco_valor <= "000000000000";
        led_vermelho <= '0';
        led_verde <= '0';
        cafe <= tipo_cafe;
        next_state <= espera;

            when espera =>
                clr_moeda   <= '0';
                moeda1	    <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco    <= '0';
		seletor     <= '0';
                led_vermelho <= '0';
                led_verde <='0';
                troco_valor <= "000000000000";
                cafe <= tipo_cafe;
		
		if cafe_select = '1' then
			seletor <= '1';
		else 
			seletor <= '0';
		end if;


        	if botaom1 = '1' then -- inseriu 10 cents
                    	next_state <= inserir_moeda1;
                    	valor_cafe <= "000000000000";
		elsif botaom2 = '1' then -- inseriu 50 cents
                	next_state <= inserir_moeda2;
                 	valor_cafe <= "000000000000";
		elsif botaom3 = '1' then -- inseriu 1 real
			next_state <= inserir_moeda3;
			valor_cafe <= "000000000000";

		elsif tipo_cafe = "00" and confirmar = '1' then
                    	next_state <= verificar_cafe1;
                    	valor_cafe <= "000011001000";
                elsif tipo_cafe = "01" and confirmar = '1' then
                    	next_state <= verificar_cafe2;
                    	valor_cafe <= "000100101100";
                elsif tipo_cafe = "10" and confirmar = '1' then
                    	next_state <= verificar_cafe3;
                    	valor_cafe <= "000101011110";
		elsif tipo_cafe = "11" and confirmar = '1' then
			next_state <= verificar_cafe4;
			valor_cafe <= "000011111010";
		else
                    	next_state <= espera;
                    	valor_cafe <= "000000000000";
                end if;

            when inserir_moeda1 =>
                clr_moeda   <= '0';
                moeda1      <= '1';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
                led_vermelho <= '0';
                led_verde <= '0';
                valor_cafe  <= "000000000000";
                troco_valor <= "000000000000";
                cafe <= tipo_cafe;
                next_state <= espera;
					 
	when inserir_moeda2 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '1';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                led_vermelho <= '0';
                led_verde <= '0';
                valor_cafe  <= "000000000000";
                troco_valor <= "000000000000";
                cafe <= tipo_cafe;
                next_state <= espera;
					 
					 
	when inserir_moeda3 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '1';
                troco       <= '0';
		seletor     <= '0';
                led_vermelho <= '0';
                led_verde <= '0';
                valor_cafe  <= "000000000000";
                troco_valor <= "000000000000";
                cafe <= tipo_cafe;
		next_state <= espera;
								
	when verificar_cafe1 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                valor_cafe  <= "000011001000";
                troco_valor <= "000000000000";
                led_verde <= '0';
                cafe <= tipo_cafe;
               
		 if qtd_ok = '1' then
                 	next_state <= emitir_cafe1;
                else
                    	led_vermelho <= '1';
                    	next_state <= espera;
                end if;

         when emitir_cafe1 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
		seletor     <= '0';
                valor_cafe <= "000011001000";
                led_vermelho <= '0';
                led_verde <= '1';
                cafe <= tipo_cafe;

                if dar_troco = '1' then
                    troco       <= '1';
                    troco_valor <= valor_troco;
                else
                    troco       <= '0';
                    troco_valor <= "000000000000";
                end if;

                next_state <= init;

          when verificar_cafe2 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                valor_cafe  <= "000100101100";
                troco_valor <= "000000000000";
                cafe <= tipo_cafe;

                if qtd_ok = '1' then
                    next_state <= emitir_cafe2;
                else
                    led_vermelho <='1';
                    next_state <= espera;
                end if;

           when emitir_cafe2 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
		seletor     <= '0';
                valor_cafe <= "000100101100";
                led_vermelho <= '0';
                led_verde <= '1';
                cafe <= tipo_cafe;
                
		if dar_troco = '1' then
                    troco       <= '1';
                    troco_valor <= valor_troco;
                else
                    troco       <= '0';
                    troco_valor <= "000000000000";
                end if;

                next_state <= init;

            when verificar_cafe3 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                valor_cafe  <= "000101011110";
                troco_valor <= "000000000000";
                led_verde <= '0';
                cafe <= tipo_cafe;
                
                if qtd_ok = '1' then
                    next_state <= emitir_cafe3;
                else
                    led_vermelho <= '1';
                    next_state <= espera;
                end if;

            when emitir_cafe3 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
		seletor     <= '0';
                valor_cafe <= "000101011110";
                led_vermelho <= '0';
                led_verde <= '1';
                cafe <= tipo_cafe;

                if dar_troco = '1' then
                    troco       <= '1';
                    troco_valor <= valor_troco;
                else
                    troco       <= '0';
                    troco_valor <= "000000000000";
                end if;
				
	    when verificar_cafe4 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                valor_cafe  <= "000011111010";
                troco_valor <= "000000000000";
                led_verde <= '0';
                cafe <= tipo_cafe;
            
		if qtd_ok = '1' then
                    next_state <= emitir_cafe4;
                else
                    led_vermelho <= '1';
                    next_state <= espera;
                end if;
				
	     when emitir_cafe4 =>
                clr_moeda   <= '0';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
		seletor     <= '0';
                valor_cafe <= "000011111010";
                led_vermelho <= '0';
                led_verde <= '1';
                cafe <= tipo_cafe;
                
		if dar_troco = '1' then
                    troco       <= '1';
                    troco_valor <= valor_troco;
                else
                    troco       <= '0';
                    troco_valor <= "000000000000";
                end if;

                next_state <= init;

            when others =>
                clr_moeda   <= '1';
                moeda1      <= '0';
		moeda2      <= '0';
		moeda3      <= '0';
                troco       <= '0';
		seletor     <= '0';
                led_vermelho <= '0';
                led_verde <= '0';
                cafe <= tipo_cafe;
                valor_cafe  <= "000000000000";
                troco_valor <= "000000000000";
               
        end case;
    end process;

end PC;
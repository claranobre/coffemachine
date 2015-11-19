vlib work
vmap work

vcom PO.vhd
vcom PC.vhd
vcom maq_cafe.vhd
vcom maq_cafe_tb.vhd

vsim maq_cafe_tb

add wave /maq_cafe_tb/clock
add wave /maq_cafe_tb/reset
add wave /maq_cafe_tb/cafe_select
add wave /maq_cafe_tb/botaom1
add wave /maq_cafe_tb/botaom2
add wave /maq_cafe_tb/botaom3
add wave /maq_cafe_tb/confirmar
add wave /maq_cafe_tb/troco
add wave /maq_cafe_tb/led_verde
add wave /maq_cafe_tb/led_vermelho
add wave -radix unsigned /maq_cafe_tb/troco_valor
add wave /maq_cafe_tb/cafe
add wave /maq_cafe_tb/dut/i1/cont_moedas;
add wave /maq_cafe_tb/dut/i0/current_state;


view wave
run 1000ns
wave zoom full
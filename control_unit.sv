module control_unit (
	input logic Reset,
	input logic Clk,
	input logic alien1_hit,
	input logic alien2_hit,
	input logic alien3_hit,
	input logic alien4_hit,
	input logic alien5_hit,
	input logic alien6_hit,
	input logic alien7_hit,
	input logic alien8_hit,
	input logic alien9_hit,
	input logic alien10_hit,
	input logic alien11_hit,
	input logic alien12_hit,
	output logic [1:0] alien_control,
	output logic [3:0] CT
);

	logic [3:0] counter;
	hit_counter h_count (
		.Reset(Reset),
		.Clk(Clk),
		.alien1_hit(alien1_hit),
		.alien2_hit(alien2_hit),
		.alien3_hit(alien3_hit),
		.alien4_hit(alien4_hit),
		.alien5_hit(alien5_hit),
		.alien6_hit(alien6_hit),
		.alien7_hit(alien7_hit),
		.alien8_hit(alien8_hit),
		.alien9_hit(alien9_hit),
		.alien10_hit(alien10_hit),
		.alien11_hit(alien11_hit),
		.alien12_hit(alien12_hit),
		.counter(counter)
	);

	logic [1:0] AC;
	state_controller GAME_STATES (
		.Reset(Reset), 
		.Clk(Clk), //frame-clock
		.counter(counter), 
		.alien_control(AC)
	);
	
	assign alien_control = AC;
	assign CT = counter;
	
endmodule

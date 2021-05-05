/*
 *		Project Testbench
 */
 
module testbench();

	timeunit 10ns;			
	timeprecision 1ns;

   logic Clk;
   logic [1:0] alien_control;
	logic Reset;
	logic alien1_hit;
	logic alien2_hit;
	logic alien3_hit;
	logic alien4_hit;
	logic alien5_hit;
	logic alien6_hit;
	logic alien7_hit;
	logic alien8_hit;
   logic alien9_hit;
	logic alien10_hit;
	logic alien11_hit;
	logic alien12_hit;
	
	control_unit CU(
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
		.alien_control(alien_control)
	);
	
	always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
	end

	initial begin: CLOCK_INITIALIZATION
		 Clk = 0;
	end
	
	initial begin: TEST_VECTORS
		alien1_hit = 0;
		alien2_hit = 0;
		alien3_hit = 0; 
		alien4_hit = 0;
		alien5_hit = 0;
		alien6_hit = 0;
		alien7_hit = 0;
		alien8_hit = 0;
		alien9_hit = 0;
		alien10_hit = 0;
		alien11_hit = 0;
		alien12_hit = 0;
		Reset = 1;

		//Need to Give some time for KeyExpansion
		#4 Reset = 0;
		
		//Set Values
		#10 alien1_hit = 1;
		#10 alien2_hit = 1;
		#10 alien3_hit = 1;
		#10 alien3_hit = 1;
		#10 alien4_hit = 1;
		#10 alien5_hit = 1;
		#10 alien6_hit = 1;
		#10 alien7_hit = 1;
		#10 alien8_hit = 1;
		#10 alien9_hit = 1;
		#10 alien10_hit = 1;
		#10 alien11_hit = 1;
		#10 alien12_hit = 1;
		
//		#10 counter = 1;
//		#10 counter = 2;
//		#10 counter = 8;
//		#20 counter = 12;

	end

endmodule

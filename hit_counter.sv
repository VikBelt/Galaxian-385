module hit_counter (
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
	output logic [3:0] counter
);

	//used to increment counter
	logic [3:0] count = 4'b0;
	
	always_ff @ (posedge Reset or posedge Clk)
	begin
	if(Reset)
		count <= 0;
	else
		begin
			count = alien1_hit + alien2_hit + alien3_hit  + alien4_hit  + alien5_hit  + alien6_hit  + 
							alien7_hit  + alien8_hit  + alien9_hit  + alien10_hit  + alien11_hit  + alien12_hit; 
		end
	end
	
	
//	always_ff @ (posedge Reset or posedge alien2_hit) // or posedge alien2_hit or posedge alien3_hit or posedge alien4_hit or posedge alien5_hit
//						//or posedge alien6_hit or posedge alien7_hit or posedge alien8_hit or posedge alien9_hit or posedge alien10_hit or posedge alien11_hit or posedge alien12_hit)
//	begin: Increment_Counter
//		if(Reset)
//			count <= 0;
//			
//		else	
//		begin
//			count <= count + 1;
//		end
//	end
//	

assign counter = count;
//	
endmodule

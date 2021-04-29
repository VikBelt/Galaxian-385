//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input logic Clk, Reset, frame_clk, input logic [7:0] keycode, input [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 //alien row_position
	 parameter [9:0] alien_row_1 = 50;
	 parameter [9:0] alien_row_2 = 100;
	 //simple alien x positions - move to a seprate file later then use include
	 parameter [9:0] alien_1_StX = 200;
	 parameter [9:0] alien_2_StX = 250;      
    parameter [9:0] alien_3_StX = 300;   
	 parameter [9:0] alien_4_StX = 350;   
	 parameter [9:0] alien_5_StX = 400;
	 //row 2
    parameter [9:0] alien_6_StX = 150; 
	 parameter [9:0] alien_7_StX = 200;
	 parameter [9:0] alien_8_StX = 250;
	 parameter [9:0] alien_9_StX = 300;
	 parameter [9:0] alien_10_StX = 350;
	 parameter [9:0] alien_11_StX = 400;
	 parameter [9:0] alien_12_StX = 450;	

	 logic [10:0] sprite_addr;
	 logic [7:0] sprite_data;
	 
	 //declaring a new instance of the font_rom module (provided code)
	 font_rom(
		.addr(sprite_addr),
		.data(sprite_data)
	 );


	logic [18:0] ship_addr; 
	logic [23:0] dout;
	frameRAM ship_ram
	(
		.data_In(24'b0),
		.write_address(19'b0), 
		.read_address(ship_addr),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(dout)
	);
	
	logic [18:0] alien_addr; 
	logic [23:0] dout_1;
	alienRAM alien_ram
	(
		.data_In(24'b0),
		.write_address(19'b0), 
		.read_address(alien_addr),
		.we(1'b0), 
		.Clk(Clk),
		.data_Out(dout_1)
	);
	
	 logic missile_on;
	 logic [9:0] MissileX; 
	 logic [9:0] MissileY;
	 logic [9:0] MissileS;
	 
	logic missile_sight;
	//Declare Player's Missile
	missile player_missile (
		.Reset(Reset),
		.frame_clk(frame_clk),
		.keycode(keycode),
		.BallX(BallX),
		.Alien1X(Alien1X),.Alien1Y(Alien1Y), .Alien1S(Alien1S),
		.Alien2X(Alien2X),.Alien2Y(Alien2Y),.Alien2S(Alien2S),
		.Alien3X(Alien3X),.Alien3Y(Alien3Y),.Alien3S(Alien3S),
		.Alien4X(Alien4X),.Alien4Y(Alien4Y),.Alien4S(Alien4S),
		.Alien5X(Alien5X),.Alien5Y(Alien5Y),.Alien5S(Alien5S),
		.Alien6X(Alien6X),.Alien6Y(Alien6Y),.Alien6S(Alien6S),
		.Alien7X(Alien7X),.Alien7Y(Alien7Y),.Alien7S(Alien7S),
		.Alien8X(Alien8X),.Alien8Y(Alien8Y),.Alien8S(Alien8S),
		.Alien9X(Alien9X),.Alien9Y(Alien9Y),.Alien9S(Alien9S),
		.Alien10X(Alien10X),.Alien10Y(Alien10Y),.Alien10S(Alien10S),
		.Alien11X(Alien11X),.Alien11Y(Alien11Y),.Alien11S(Alien11Y),
		.Alien12X(Alien12X),.Alien12Y(Alien12Y),.Alien12S(Alien12S),
		.MissileX(MissileX),
		.MissileY(MissileY),
		.MissileS(MissileS),
		.visible(missile_sight)
	);
	
	 //row one
	 logic alien1_on, alien2_on, alien3_on, alien4_on, alien5_on, alien6_on, alien7_on, alien8_on, alien9_on, alien10_on, alien11_on, alien12_on;
	 logic alien1_hit, alien2_hit, alien3_hit, alien4_hit, alien5_hit, alien6_hit, alien7_hit, alien8_hit, alien9_hit, alien10_hit, alien11_hit, alien12_hit;
	 logic [9:0] Alien1X, Alien1Y, Alien1S;
	 logic [9:0] Alien2X,Alien2Y,Alien2S;
	 logic [9:0] Alien3X,Alien3Y,Alien3S;
	 logic [9:0] Alien4X,Alien4Y,Alien4S;
	 logic [9:0] Alien5X,Alien5Y,Alien5S;
	 logic [9:0] Alien6X,Alien6Y,Alien6S;
	 logic [9:0] Alien7X,Alien7Y,Alien7S;
	 logic [9:0] Alien8X,Alien8Y,Alien8S;
    logic [9:0] Alien9X,Alien9Y,Alien9S;
	 logic [9:0] Alien10X,Alien10Y,Alien10S;
	 logic [9:0] Alien11X,Alien11Y,Alien11S;
	 logic [9:0] Alien12X,Alien12Y,Alien12S;
	 
	 //Declare the Aliens
	 simple_alien alien_1 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_1_StX),.alienStY(alien_row_1),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien1_hit),.AlienX(Alien1X),.AlienY(Alien1Y),.AlienS(Alien1S));
		
	 simple_alien alien_2 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_2_StX),.alienStY(alien_row_1),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien2_hit),.AlienX(Alien2X),.AlienY(Alien2Y),.AlienS(Alien2S));
		
	 simple_alien alien_3 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_3_StX),.alienStY(alien_row_1),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien3_hit),.AlienX(Alien3X),.AlienY(Alien3Y),.AlienS(Alien3S));
		
	 simple_alien alien_4 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_4_StX),.alienStY(alien_row_1),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien4_hit),.AlienX(Alien4X),.AlienY(Alien4Y),.AlienS(Alien4S));
		
	 simple_alien alien_5 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_5_StX),.alienStY(alien_row_1),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien5_hit),.AlienX(Alien5X),.AlienY(Alien5Y),.AlienS(Alien5S));
	 
	 simple_alien alien_6 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_6_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien6_hit),.AlienX(Alien6X),.AlienY(Alien6Y),.AlienS(Alien6S));
	 
	 simple_alien alien_7 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_7_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien7_hit),.AlienX(Alien7X),.AlienY(Alien7Y),.AlienS(Alien7S));
	 
	 simple_alien alien_8 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_8_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien8_hit),.AlienX(Alien8X),.AlienY(Alien8Y),.AlienS(Alien8S));
	 
	 simple_alien alien_9 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_9_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien9_hit),.AlienX(Alien9X),.AlienY(Alien9Y),.AlienS(Alien9S));
	 
	 simple_alien alien_10 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_10_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien10_hit),.AlienX(Alien10X),.AlienY(Alien10Y),.AlienS(Alien10S));
	 
	 simple_alien alien_11 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_11_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien11_hit),.AlienX(Alien11X),.AlienY(Alien11Y),.AlienS(Alien11S));
	 
	 simple_alien alien_12 (.Reset(Reset),.frame_clk(frame_clk),.alienStX(alien_12_StX),.alienStY(alien_row_2),.PlayerMissileX(MissileX), .PlayerMissileY(MissileY), .PlayerMissileS(MissileS),
		.motion_code(motion_code),.visible(alien12_hit),.AlienX(Alien12X),.AlienY(Alien12Y),.AlienS(Alien12S));
	 
	 //Ball params
    int DistX, DistY, Size;
	 int DistAlien1X, DistAlien1Y, DistAlien2X, DistAlien2Y, DistAlien3X, DistAlien3Y, DistAlien4X, DistAlien4Y, DistAlien5X, DistAlien5Y, DistAlien6X, DistAlien6Y, DistAlien7X, DistAlien7Y;
	 int DistAlien8X, DistAlien8Y, DistAlien9X, DistAlien9Y, DistAlien10X, DistAlien10Y, DistAlien11X, DistAlien11Y, DistAlien12X, DistAlien12Y;
	 
	 assign DistAlien1X = DrawX - Alien1X; 
	 assign DistAlien1Y = DrawY - Alien1Y; 

	 assign DistAlien2X = DrawX - Alien2X; 
	 assign DistAlien2Y = DrawY - Alien2Y;
	 
	 assign DistAlien3X = DrawX - Alien3X; 
	 assign DistAlien3Y = DrawY - Alien3Y;
	 
	 assign DistAlien4X = DrawX - Alien4X; 
	 assign DistAlien4Y = DrawY - Alien4Y;
	 
	 assign DistAlien5X = DrawX - Alien5X; 
	 assign DistAlien5Y = DrawY - Alien5Y;
	 
	 assign DistAlien6X = DrawX - Alien6X; 
	 assign DistAlien6Y = DrawY - Alien6Y;
	 
	 assign DistAlien7X = DrawX - Alien7X; 
	 assign DistAlien7Y = DrawY - Alien7Y;
	 
	 assign DistAlien8X = DrawX - Alien8X; 
	 assign DistAlien8Y = DrawY - Alien8Y;
	 
	 assign DistAlien9X = DrawX - Alien9X; 
	 assign DistAlien9Y = DrawY - Alien9Y;
	 
	 assign DistAlien10X = DrawX - Alien10X; 
	 assign DistAlien10Y = DrawY - Alien10Y;
	 
	 assign DistAlien11X = DrawX - Alien11X; 
	 assign DistAlien11Y = DrawY - Alien11Y;
	 
	 assign DistAlien12X = DrawX - Alien12X; 
	 assign DistAlien12Y = DrawY - Alien12Y;
	 
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 
	 logic motion_code;
	 //used to make ships go side to side
	 always_ff @ (posedge Reset or posedge frame_clk )
	 begin: Move_Alien_Row
		if(Reset)
			motion_code <= 0;
		
		else	
		begin
			if ( (Alien12X + Alien12S) >= 620 )  // Right Most Alien Goes to far to the right
				motion_code <= 1;
				
			else if ((Alien6X - Alien6S) <= 20) //Left Most Alien Goes too far left
				motion_code <= 0;
		end
	 end
	 
	 always_comb
	 //ship
	 begin:Ball_on_proj
		if (DrawX >= BallX && DrawX < BallX + Ball_size &&
			DrawY >= BallY && DrawY < BallY + Ball_size)
		begin
           ball_on = 1'b1;
			  alien1_on = 1'b0;
			  alien2_on = 1'b0;
			  alien3_on = 1'b0;
			  alien4_on = 1'b0;
			  alien5_on = 1'b0;
			  alien6_on = 1'b0;
			  alien7_on = 1'b0;
			  alien8_on = 1'b0;
		     alien9_on = 1'b0;
			  alien10_on = 1'b0;
			  alien11_on = 1'b0;
			  alien12_on = 1'b0;
			  missile_on = 1'b0;
			  sprite_addr = 10'b0;
			  ship_addr = (DistY*40 + DistX);
			  alien_addr = 19'b0;
		end
		
		else if(DrawX >= Alien1X && DrawX < Alien1X + Alien1S &&
			DrawY >= Alien1Y && DrawY < Alien1Y + Alien1S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b1;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien1Y*25 + DistAlien1X);
			sprite_addr = 10'b0;
		end
		
		else if(DrawX >= Alien2X && DrawX < Alien2X + Alien2S &&
				DrawY >= Alien2Y && DrawY < Alien2Y + Alien2S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b1;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;			
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien2Y*25 + DistAlien2X);
			sprite_addr = 10'b0;
		end
		
		else if(DrawX >= Alien3X && DrawX < Alien3X + Alien3S &&
				DrawY >= Alien3Y && DrawY < Alien3Y + Alien3S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b1;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien3Y*25 + DistAlien3X);			
			sprite_addr = 10'b0;
		end

		else if(DrawX >= Alien4X && DrawX < Alien4X + Alien4S &&
				DrawY >= Alien4Y && DrawY < Alien4Y + Alien4S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b1;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien4Y*25 + DistAlien4X);		
			sprite_addr = 10'b0;
		end

		else if(DrawX >= Alien5X && DrawX < Alien5X + Alien5S &&
				DrawY >= Alien5Y && DrawY < Alien5Y + Alien5S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b1;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien5Y*25 + DistAlien5X);		
			sprite_addr = 10'b0;
		end

		else if(DrawX >= Alien6X && DrawX < Alien6X + Alien6S &&
				DrawY >= Alien6Y && DrawY < Alien6Y + Alien6S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b1;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien6Y*25 + DistAlien6X);		
			sprite_addr = 10'b0;
		end
		
		else if(DrawX >= Alien7X && DrawX < Alien7X + Alien7S &&
				DrawY >= Alien7Y && DrawY < Alien7Y + Alien7S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b1;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien7Y*25 + DistAlien7X);		
			sprite_addr = 10'b0;
		end
		
		else if(DrawX >= Alien8X && DrawX < Alien8X + Alien8S &&
				DrawY >= Alien8Y && DrawY < Alien8Y + Alien8S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b1;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien8Y*25 + DistAlien8X);		
			sprite_addr = 10'b0;
		end	
		
		else if(DrawX >= Alien9X && DrawX < Alien9X + Alien9S &&
				DrawY >= Alien9Y && DrawY < Alien9Y + Alien9S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b1;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien9Y*25 + DistAlien9X);		
			sprite_addr = 10'b0;
		end
	
		else if(DrawX >= Alien10X && DrawX < Alien10X + Alien10S &&
				DrawY >= Alien10Y && DrawY < Alien10Y + Alien10S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b1;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien10Y*25 + DistAlien10X);		
			sprite_addr = 10'b0;
		end
	
		else if(DrawX >= Alien11X && DrawX < Alien11X + Alien11S &&
				DrawY >= Alien11Y && DrawY < Alien11Y + Alien11S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b1;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien11Y*25 + DistAlien11X);		
			sprite_addr = 10'b0;
		end

		else if(DrawX >= Alien12X && DrawX < Alien12X + Alien12S &&
				DrawY >= Alien12Y && DrawY < Alien12Y + Alien12S)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b1;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = (DistAlien12Y*25 + DistAlien12X);		
			sprite_addr = 10'b0;
		end
		
		else if(DrawX >= MissileX && DrawX < MissileX + MissileS &&
				DrawY >= MissileY && DrawY < MissileY + 2*MissileS)
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b1;
			ship_addr = 19'b0;
			alien_addr = 19'b0;		
			sprite_addr = 10'b0;;
		end
		
		else
		begin
			ball_on = 1'b0;
			alien1_on = 1'b0;
			alien2_on = 1'b0;
			alien3_on = 1'b0;
			alien4_on = 1'b0;
			alien5_on = 1'b0;
			alien6_on = 1'b0;
			alien7_on = 1'b0;
		   alien8_on = 1'b0;
		   alien9_on = 1'b0;
		   alien10_on = 1'b0;
		   alien11_on = 1'b0;
		   alien12_on = 1'b0;
			missile_on = 1'b0;
			ship_addr = 19'b0;
			alien_addr = 19'b0;		
			sprite_addr = 10'b0;
		end
	 end 
	 
    always_comb
    begin:RGB_Display
	     if ((ball_on == 1'b1)) 
        begin 
            Red = dout[23:16];
            Green = dout[15:8];            
			   Blue = dout[7:0];
        end 
		  
        else if ((alien1_on == 1'b1) && (alien1_hit == 0)) 
        begin 
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
        end  
		  
		  else if((alien2_on == 1'b1) && (alien2_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end

		  else if((alien3_on == 1'b1) && (alien3_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien4_on == 1'b1) && (alien4_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];		  end
		  
		  else if((alien5_on == 1'b1) && (alien5_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien6_on == 1'b1) && (alien6_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end

		  else if((alien7_on == 1'b1) && (alien7_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien8_on == 1'b1) && (alien8_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien9_on == 1'b1) && (alien9_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien10_on == 1'b1) && (alien10_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((alien11_on == 1'b1) && (alien11_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		   
		  else if((alien12_on == 1'b1) && (alien12_hit == 0))
		  begin
            Red = dout_1[23:16];
            Green = dout_1[15:8];            
			   Blue = dout_1[7:0];
		  end
		  
		  else if((missile_on == 1'b1) && (missile_sight == 1'b1))
		  begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
		  end
		  
        else  
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
       end      
    end 
	 
endmodule

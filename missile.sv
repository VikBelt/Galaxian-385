

module missile ( 
	input Reset, 
	frame_clk, 
	input [7:0] keycode, 
	input [9:0] BallX,
	input  [9:0] Alien1X, Alien1Y, Alien1S,
	input [9:0] Alien2X,Alien2Y,Alien2S,
	input [9:0] Alien3X,Alien3Y,Alien3S,
	input [9:0] Alien4X,Alien4Y,Alien4S,
	input [9:0] Alien5X,Alien5Y,Alien5S,
	input [9:0] Alien6X,Alien6Y,Alien6S,
	input [9:0] Alien7X,Alien7Y,Alien7S,
	input [9:0] Alien8X,Alien8Y,Alien8S,
   input [9:0] Alien9X,Alien9Y,Alien9S,
	input [9:0] Alien10X,Alien10Y,Alien10S,
	input [9:0] Alien11X,Alien11Y,Alien11S,
	input [9:0] Alien12X,Alien12Y,Alien12S,
   output [9:0]  MissileX, MissileY, MissileS, 
	output visible 
);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [9:0] Ball_X_St = 337;  // Center position on the X axis
    parameter [9:0] Ball_Y_St = 434;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=0;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=0;      // Step size on the Y axis
	 parameter [9:0] MissileWidth = 3;
	 parameter [9:0] MissileHeight = 6;
	 parameter [9:0] Alien_Size = 25;
	 
    assign Ball_Size = 3;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign visible = fired;
	 
	 logic fired;//,fired_next;
	 logic alien1_hit, alien2_hit, alien3_hit, alien4_hit, alien5_hit, alien6_hit, alien7_hit, alien8_hit, alien9_hit, alien10_hit, alien11_hit, alien12_hit;
	 
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= Ball_X_St;
				fired <= 0;
				alien1_hit <= 0;
				alien2_hit <= 0;
				alien3_hit <= 0;
				alien4_hit <= 0;
				alien5_hit <= 0;
				alien6_hit <= 0;
				alien7_hit <= 0;
				alien8_hit <= 0;
				alien9_hit <= 0;
				alien10_hit <= 0;
				alien11_hit <= 0;
				alien12_hit <= 0;
				//fired_next <= 0;
        end
		 
		  else if (((Ball_Y_Pos - Ball_Size) <= 6) && (fired ==1))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
		  end
			
		  else if ( ((MissileX + MissileWidth > Alien1X) && (MissileX < Alien1X + Alien_Size)
							&& (MissileY + MissileHeight > Alien1Y) && (MissileY < Alien1Y + Alien_Size)) && (alien1_hit==0))
		  begin 
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;	
				alien1_hit<=1;			
		  end
			
		  else if (((MissileX + MissileWidth > Alien2X) && (MissileX < Alien2X + Alien_Size)
							&& (MissileY + MissileHeight > Alien2Y) && (MissileY < Alien2Y + Alien_Size)) && (alien2_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;	
				alien2_hit<=1;		
		  end
		  
		  else if (((MissileX + MissileWidth > Alien3X) && (MissileX < Alien3X + Alien_Size)
							&& (MissileY + MissileHeight > Alien3Y) && (MissileY < Alien3Y + Alien_Size)) && (alien3_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;	
				alien3_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien4X) && (MissileX < Alien4X + Alien_Size)
							&& (MissileY + MissileHeight > Alien4Y) && (MissileY < Alien4Y + Alien_Size)) && (alien4_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien4_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien5X) && (MissileX < Alien5X + Alien_Size)
							&& (MissileY + MissileHeight > Alien5Y) && (MissileY < Alien5Y + Alien_Size)) && (alien5_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;	
				alien5_hit<=1;				
		  end
		  
		  else if (((MissileX + MissileWidth > Alien6X) && (MissileX < Alien6X + Alien_Size)
							&& (MissileY + MissileHeight > Alien6Y) && (MissileY < Alien6Y + Alien_Size)) && (alien6_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien6_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien7X) && (MissileX < Alien7X + Alien_Size)
							&& (MissileY + MissileHeight > Alien7Y) && (MissileY < Alien7Y + Alien_Size)) && (alien7_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien7_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien8X) && (MissileX < Alien8X + Alien_Size)
				 && (MissileY + MissileHeight > Alien8Y) && (MissileY < Alien8Y + Alien_Size)) && (alien8_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien8_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien9X) && (MissileX < Alien9X + Alien_Size)
				  && (MissileY + MissileHeight > Alien9Y) && (MissileY < Alien9Y + Alien_Size)) && (alien9_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien9_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien10X) && (MissileX < Alien10X + Alien_Size)
				  && (MissileY + MissileHeight > Alien10Y) && (MissileY < Alien10Y + Alien_Size)) && (alien10_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;	
				alien10_hit<=1;				
		  end
		  
		  else if (((MissileX + MissileWidth > Alien11X) && (MissileX < Alien11X + Alien_Size)
				  && (MissileY + MissileHeight > Alien11Y) && (MissileY < Alien11Y + Alien_Size)) && (alien11_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien11_hit<=1;					
		  end
		  
		  else if (((MissileX + MissileWidth > Alien12X) && (MissileX < Alien12X + Alien_Size)
					&& (MissileY + MissileHeight > Alien12Y) && (MissileY < Alien12Y + Alien_Size)) && (alien12_hit==0))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				Ball_Y_Pos <= Ball_Y_St;
				Ball_X_Pos <= BallX+17;
				Ball_Y_Motion <= 0;
				alien12_hit<=1;					
		  end
		  
        else 
        begin 
				
					Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving	
					if(keycode == 8'h2c)
					begin
					      Ball_X_Motion <= 0;// SPACEBAR - want missile to go up when fired
							Ball_Y_Motion <= -4;
							fired <= 1;
							//fired_next <= 1;
					end
					
					else 
					begin
						if(fired == 0)
						begin
								case (keycode)
								8'h04 : begin

											Ball_X_Motion <= -1;//A
											Ball_Y_Motion<= 0;
										end
									  
								8'h50 : begin

											Ball_X_Motion <= -1;// LEFT ARROW
											Ball_Y_Motion<= 0;
										end    
									  
								8'h07 : begin
											
											Ball_X_Motion <= 1;//D
											Ball_Y_Motion <= 0;
										end  
							
								8'h4f : begin
										
											Ball_X_Motion <= 1;// RIGHT ARROW
											Ball_Y_Motion <= 0;
										end  
									  
								default: begin
											Ball_X_Motion <= 0;
											//Ball_Y_Motion <= 0;
										end
								endcase
						end
					
				 end
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				 //fired <= fired_next;
		end  
    end
       
    assign MissileX = Ball_X_Pos;
   
    assign MissileY = Ball_Y_Pos;
   
    assign MissileS = Ball_Size;
    

endmodule

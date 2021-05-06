// module for the alien missile in the game

module alien_missile ( 
	input Reset,frame_clk, 
	input shoot_missile,
	input [9:0] AlienX, AlienY,
	input [1:0] motion_code,
	input [9:0] PlayerX,PlayerY,PlayerS,
   output [9:0]  AlienMissileX, AlienMissileY, AlienMissileS, 
	output visible 
);
    
    logic [9:0] AM_X_Pos, AM_X_Motion, AM_Y_Pos, AM_Y_Motion, AlienMissileSize;
	 parameter [9:0] AlienMissileWidth = 3;
	 parameter [9:0] AlienMissileHeight = 6;
	 parameter [9:0] Alien_Size = 25;
	 
    assign AlienMissileSize = 3;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign visible = fired;

	 logic fired;
	 
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				AM_X_Motion <= 10'd0; //Ball_X_Step;
				AM_Y_Pos <= AlienY + 25;
				AM_X_Pos <= AlienX + 12;
				fired <= 0;
        end
		 
		  else if (((AM_Y_Pos + AlienMissileSize) >= 470) && (fired ==1))
		  begin
				fired <= 0;
			   //fired_next <= 0;
				AM_Y_Pos <= AlienY + 25;
				AM_X_Pos <= AlienX + 12;
				AM_Y_Motion <= 0;
		  end
		  
        else 
        begin 
					if(shoot_missile) //want posedge of shoot
					begin
					      AM_X_Motion <= 0;
							AM_Y_Motion <= 3;
							fired <= 1;
					end
					
					else 
					begin
						if(fired == 0) //if not fired change motion according 
						begin
							 //missile right with alien
							 if (motion_code == 2'b00)  
							 begin
								  AM_X_Motion <= 1;  // 2's complement.
								  AM_Y_Motion <= 0;
							 end
							 //missile left with alien
							 else if (motion_code == 2'b01)  // Ball is at the Left edge, BOUNCE!
							 begin
								  AM_X_Motion <= -1;
								  AM_Y_Motion <= 0;
							 end
							 
							 //diagonal with alien
							 else if (motion_code == 2'b10)  
							 begin
								  
								  if(PlayerX > AM_X_Pos + Alien_Size)
								  begin
										AM_X_Motion <= 1;
										AM_Y_Motion <= 1;
								  end
								  else if(PlayerX + 40 < AM_X_Pos)
								  begin
										AM_X_Motion <= -1;
										AM_Y_Motion <= 1;					  
								  end
							 end
						end
				 end
				 
				 AM_Y_Pos <= (AM_Y_Pos + AM_Y_Motion);  // Update ball position
				 AM_X_Pos <= (AM_X_Pos + AM_X_Motion);
		end  
    end
       
    assign AlienMissileX = AM_X_Pos;
   
    assign AlienMissileY = AM_Y_Pos;
   
    assign AlienMissileS = AlienMissileSize;
    

endmodule
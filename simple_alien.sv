

module  simple_alien ( 
	input Reset, frame_clk, 
	input [9:0] alienStX, alienStY, PlayerMissileX, PlayerMissileY, PlayerMissileS, 
	input motion_code,
	output visible, output [9:0]  AlienX, AlienY, AlienS
);
    
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
	 
	 parameter [9:0] Ball_X_Step=0;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=0;      // Step size on the Y axis
	 
	 parameter [9:0] MissileWidth = 3;
	 parameter [9:0] MissileHeight = 6;
	 
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Alien_Size;
    assign Alien_Size = 25;  
	 
	 logic hit;
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
		  
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= alienStY;
				Ball_X_Pos <= alienStX;
				hit <= 0;
        end
		  
		  //collision between aliens and the player missile
        else if ((PlayerMissileX + MissileWidth > Ball_X_Pos) && (PlayerMissileX < Ball_X_Pos + Alien_Size)
							&& (PlayerMissileY + MissileHeight > Ball_Y_Pos) && (PlayerMissileY < Ball_Y_Pos + Alien_Size))
				hit <= 1;
		  
				   
        else 
        begin 
				 
				 if (motion_code == 0)  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= 1;  // 2's complement.
					  
				 else if (motion_code == 1)  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= -1;
					  
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
		end  
    end
       
    assign AlienX = Ball_X_Pos;
   
    assign AlienY = Ball_Y_Pos;
   
    assign AlienS = Alien_Size;
	 
	 assign visible = hit;
    

endmodule

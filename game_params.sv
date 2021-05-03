//Game Parameters - Useful Constants to be used in the game

`ifndef _GAME_PARAMS__SV 
`define _GAME_PARAMS__SV

package GAME_PARAMS;
	
	/////////ALIEN INFORMATION/////////
	//alien start positions
	parameter [9:0] alien_1_StX = 200;
	parameter [9:0] alien_2_StX = 250;      
	parameter [9:0] alien_3_StX = 300;   
	parameter [9:0] alien_4_StX = 350;   
	parameter [9:0] alien_5_StX = 400;
	parameter [9:0] alien_6_StX = 150; 
	parameter [9:0] alien_7_StX = 200;
	parameter [9:0] alien_8_StX = 250;
	parameter [9:0] alien_9_StX = 300;
	parameter [9:0] alien_10_StX = 350;
	parameter [9:0] alien_11_StX = 400;
	parameter [9:0] alien_12_StX = 450;	

	//alien row_position
	parameter [9:0] alien_row_1 = 50;
	parameter [9:0] alien_row_2 = 100;
	
	/////////STAR INFORMATION/////////
	parameter [9:0] star_size = 3;
	parameter [9:0] star_row_one = 25;
	parameter [9:0] star_row_two = 75; 
	parameter [9:0] star_row_three = 125;
	parameter [9:0] star_row_four = 175;
	parameter [9:0] star_row_five = 225;
	parameter [9:0] star_row_six = 275;
	parameter [9:0] star_row_seven = 325;
	parameter [9:0] star_row_eight = 375;
	parameter [9:0] star_row_nine = 425;
	parameter [9:0] star_row_ten = 475;
	
	parameter [9:0] star_OneX = 50;
	parameter [9:0] star2_X = 100;
	parameter [9:0] star3_X = 150;
	parameter [9:0] star4_X = 200;
	parameter [9:0] star5_X = 250;
	parameter [9:0] star6_X = 300;
	parameter [9:0] star7_X = 350;
	parameter [9:0] star8_X = 400;
	parameter [9:0] star9_X = 450;
	parameter [9:0] star10_X = 500;
	parameter [9:0] star11_X = 550;
	parameter [9:0] star12_X = 600;
	
endpackage
`endif 
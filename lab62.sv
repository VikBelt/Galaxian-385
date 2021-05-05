//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

`include "game_params.sv"
import GAME_PARAMS::*;

module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);

logic Reset_h, vssig, blank, sync, VGA_Clk;

//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
//	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
//	assign HEX4[7] = 1'b1;
//	
//	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
//	assign HEX3[7] = 1'b1;
//	
//	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
//	assign HEX1[7] = 1'b1;
//	
	HexDriver hex_driver0 (CT/*hex_num_0*/, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.
vga_controller VGAC (
	.Clk(MAX10_CLK1_50),
	.Reset(Reset_h),
	.hs(VGA_HS),
	.vs(VGA_VS),
	.pixel_clk(VGA_CLCK),
	.blank(blank),
	.sync(sync),
	.DrawX(drawxsig),
	.DrawY(drawysig)
);

player SHIP (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.keycode(keycode),
	.BallX(ballxsig),
	.BallY(ballysig),
	.BallS(ballsizesig)
);

color_mapper CMAP (
	.Clk(MAX10_CLK1_50),
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.keycode(keycode),
	.BallX(ballxsig),
	.BallY(ballysig),
	.DrawX(drawxsig),
	.DrawY(drawysig),
	.Ball_size(ballsizesig),
	.Alien1X(Alien1X), 
	.Alien1Y(Alien1Y), 
	.Alien1S(Alien1S),
	.Alien2X(Alien2X), 
	.Alien2Y(Alien2Y),
	.Alien2S(Alien2S),
   .Alien3X(Alien3X), 
	.Alien3Y(Alien3Y),
	.Alien3S(Alien3S),
	.Alien4X(Alien4X), 
	.Alien4Y(Alien4Y),
	.Alien4S(Alien4S),
	.Alien5X(Alien5X), 
	.Alien5Y(Alien5Y),
	.Alien5S(Alien5S),
	.Alien6X(Alien6X), 
	.Alien6Y(Alien6Y),
	.Alien6S(Alien6S),
	.Alien7X(Alien7X), 
	.Alien7Y(Alien7Y),
	.Alien7S(Alien7S),
	.Alien8X(Alien8X), 
	.Alien8Y(Alien8Y),
	.Alien8S(Alien8S),
	.Alien9X(Alien9X), 
	.Alien9Y(Alien9Y),
	.Alien9S(Alien9S),
	.Alien10X(Alien10X), 
	.Alien10Y(Alien10Y),
	.Alien10S(Alien10S),
	.Alien11X(Alien11X), 
	.Alien11Y(Alien11Y),
	.Alien11S(Alien11S),
	.Alien12X(Alien12X), 
	.Alien12Y(Alien12Y),
	.Alien12S(Alien12S),
	.MissileX(MissileX), 
	.MissileY(MissileY),
	.MissileS(MissileS),
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
	.missile_sight(missile_sight),
	.Red(Red),
	.Green(Green),
	.Blue(Blue)
);
	 
logic [9:0] MissileX; 
logic [9:0] MissileY;
logic [9:0] MissileS;

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
 
logic missile_sight;
//Declare Player's Missile
missile player_missile (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.keycode(keycode),
	.BallX(ballxsig),
	.Alien1X(Alien1X),
	.Alien1Y(Alien1Y), 
	.Alien1S(Alien1S),
	.Alien2X(Alien2X),
	.Alien2Y(Alien2Y),
	.Alien2S(Alien2S),
	.Alien3X(Alien3X),
	.Alien3Y(Alien3Y),
	.Alien3S(Alien3S),
	.Alien4X(Alien4X),
	.Alien4Y(Alien4Y),
	.Alien4S(Alien4S),
	.Alien5X(Alien5X),
	.Alien5Y(Alien5Y),
	.Alien5S(Alien5S),
	.Alien6X(Alien6X),
	.Alien6Y(Alien6Y),
	.Alien6S(Alien6S),
	.Alien7X(Alien7X),
	.Alien7Y(Alien7Y),
	.Alien7S(Alien7S),
	.Alien8X(Alien8X),
	.Alien8Y(Alien8Y),
	.Alien8S(Alien8S),
	.Alien9X(Alien9X),
	.Alien9Y(Alien9Y),
	.Alien9S(Alien9S),
	.Alien10X(Alien10X),
	.Alien10Y(Alien10Y),
	.Alien10S(Alien10S),
	.Alien11X(Alien11X),
	.Alien11Y(Alien11Y),
	.Alien11S(Alien11Y),
	.Alien12X(Alien12X),
	.Alien12Y(Alien12Y),
	.Alien12S(Alien12S),
	.MissileX(MissileX),
	.MissileY(MissileY),
	.MissileS(MissileS),
	.visible(missile_sight)
);


logic alien1_hit, alien2_hit, alien3_hit, alien4_hit, alien5_hit, alien6_hit, alien7_hit, alien8_hit, alien9_hit, alien10_hit, alien11_hit, alien12_hit;

//Alien 1
simple_alien alien_1 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_1_StX),
	.alienStY(alien_row_1),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien1_hit),
	.AlienX(Alien1X),
	.AlienY(Alien1Y),
	.AlienS(Alien1S)
);

//Alien 2
simple_alien alien_2 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_2_StX),
	.alienStY(alien_row_1),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien2_hit),
	.AlienX(Alien2X),
	.AlienY(Alien2Y),
	.AlienS(Alien2S)
);

//Alien 3
simple_alien alien_3 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_3_StX),
	.alienStY(alien_row_1),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien3_hit),
	.AlienX(Alien3X),
	.AlienY(Alien3Y),
	.AlienS(Alien3S)
);

//Alien 4
simple_alien alien_4 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_4_StX),
	.alienStY(alien_row_1),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien4_hit),
	.AlienX(Alien4X),
	.AlienY(Alien4Y),
	.AlienS(Alien4S)
);

//Alien 5
simple_alien alien_5 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_5_StX),
	.alienStY(alien_row_1),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien5_hit),
	.AlienX(Alien5X),
	.AlienY(Alien5Y),
	.AlienS(Alien5S)
);

//Alien 6
simple_alien alien_6 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_6_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code6),
	.visible(alien6_hit),
	.AlienX(Alien6X),
	.AlienY(Alien6Y),
	.AlienS(Alien6S)
);

//Alien 7
simple_alien alien_7 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_7_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien7_hit),
	.AlienX(Alien7X),
	.AlienY(Alien7Y),
	.AlienS(Alien7S)
);

//Alien 8
simple_alien alien_8 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_8_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien8_hit),
	.AlienX(Alien8X),
	.AlienY(Alien8Y),
	.AlienS(Alien8S)
);

//Alien 9
simple_alien alien_9 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_9_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien9_hit),
	.AlienX(Alien9X),
	.AlienY(Alien9Y),
	.AlienS(Alien9S)
);

//Alien 10
simple_alien alien_10 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_10_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien10_hit),
	.AlienX(Alien10X),
	.AlienY(Alien10Y),
	.AlienS(Alien10S)
);

//Alien 11
simple_alien alien_11 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_11_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code),
	.visible(alien11_hit),
	.AlienX(Alien11X),
	.AlienY(Alien11Y),
	.AlienS(Alien11S)
);

//Alien 12
simple_alien alien_12 (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.alienStX(alien_12_StX),
	.alienStY(alien_row_2),
	.PlayerMissileX(MissileX), 
	.PlayerMissileY(MissileY), 
	.PlayerMissileS(MissileS),
	.motion_code(motion_code12),
	.visible(alien12_hit),
	.AlienX(Alien12X),
	.AlienY(Alien12Y),
	.AlienS(Alien12S)
);	

logic [1:0] alien_control;
logic [3:0] CT;
control_unit CONTROL(
	.Reset(Reset_h),
	.Clk(VGA_VS),
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
	.alien_control(alien_control),
	.CT(CT)
);

logic [1:0] motion_code;
logic [1:0] motion_code6;
logic [1:0] motion_code12;
//used to make ships go side to side
always_ff @ (posedge Reset_h or posedge VGA_VS )
begin: Move_Alien_Row

	if(Reset_h)
	begin
		motion_code <= 2'b00;
		motion_code6 <= 2'b00;
		motion_code12 <= 2'b00;
	end
	
	else	
	begin
		if(alien_control == 2'b00)
		begin
			if ( (Alien12X + Alien12S) >= 620 )  // Right Most Alien Goes to far to the right
			begin
				motion_code <= 2'b01;
				motion_code6 <= 2'b01;
				motion_code12 <= 2'b01;
			end
			
			else if ((Alien6X - Alien6S) <= 20) //Left Most Alien Goes too far left
			begin
				motion_code <= 2'b00;
				motion_code6 <= 2'b00;
				motion_code12 <= 2'b00;
			end
		end
		
		else if(alien_control == 2'b01)
		begin
				//bound checking
				if ( (Alien11X + Alien11S) >= 620 )  // Right Most Alien Goes to far to the right
					motion_code <= 2'b01;
		
				
				else if ((Alien1X - Alien1S) <= 20) //Left Most Alien Goes too far left
					motion_code <= 2'b00;
			
			   motion_code6 <= 2'b10;
				motion_code12 <= 2'b11;
		end
		
	end
end

	 
endmodule

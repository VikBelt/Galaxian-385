//FSM for the Game States

module state_controller (
	input logic Reset, Clk, //frame-clock
	input int counter, 
	output logic [1:0] alien_control
);

enum logic[2:0] {
	START,
	EASY,
	HARD,
	END
} State, NextState;

always_ff @ (posedge Clk)
begin
	if(Reset)
		State <= START;
	
	else
		State <= NextState;
end

always_comb
begin
	//set default value
	alien_control = 2'b00;
	
	//state transitions
	unique case(State)
		
		START:
			NextState = EASY;
		
		EASY:
			if(counter < 2)
				NextState = EASY;
				
			else
				NextState = HARD;
			
		HARD:
			if(counter < 12)
				NextState = HARD;
			else
				NextState = END;
		
		END:
			NextState = END;
	
		default : ;
		
	endcase
	
	case (State)
	
		START:
			alien_control = 2'b00;
		
		EASY:
			alien_control = 2'b00;
		
		HARD:
			alien_control = 2'b01;
		
		END: 
			alien_control = 2'b00;
		
		default : ;
			
	endcase
end

endmodule


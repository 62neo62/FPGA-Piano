module time_multiplex_7seg
	(
		input clk,
		inout [3:0] val0, val1, val2, val3,
		input dp_in
		output reg [3:0] an,
		output reg [6:0] sseg
	);
	
	localparam N= 18 //16 bits for counter feedback and 2 bits for the selection input (GENDRIC VARIABLE***)
	reg [N-1:0] regN;
	reg [3:0] val_in;
	reg dp;
	
	assign dp_in = 1'b0;
	
	//there is 3 blocks that require always including the multiplexor, the d flip flop, and the 2 to 4 decoder
	//refresh rate or up counter or clock (feedback loop)
	always@ (posedge clk)
	begin
		regN = regN + 1 
	end
	
	//Multiplexor
	always@*(val0, val1, val2, val3, clk)
	begin
		case(regN[N-1:N-2])
		begin
			case //use case
	end
	
	//Decoder
	always@ *
	begin
	//use case statement
	
	end
module quad_seven_seg (
	input wire clk,
	input wire 
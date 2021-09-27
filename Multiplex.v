module time_multiplex_7seg
	(
		input clk,
		inout [3:0] val0, val1, val2, val3,
		input [1:0] sel,
		input dp_in,
		output reg [3:0] an, //register for 4 bit enable
		output reg [6:0] sseg
	);
	
	localparam N = 18 //16 bits for counter feedback and 2 bits for the selection input (GENDRIC VARIABLE***)
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
	//This b2'b11 : out = val3;lock gets executed whe val0 or val1 or val2 or val3 change in value
	//Depending on the case of sel
	always@*(val0, val1, val2, val3, clk)
	begin
		case(regN[N-1:N-2])
		2'b00:
		hex_to_sseg(val0,sseg)
		
		2'b01:
		hex_to_sseg(val1,sseg)
		
		2'b10:
		hex_to_sseg(val2,sseg)
		
		2'b11:
		hex_to_sseg(val3,sseg)

		endcase



	end
	
	//Decoder
	always@ *
	begin
		case(regN[N-3:N-4])
		2'b00:
		an[0] = 1'b0;
		2'b01 
		an[1] = 1'b0;
		2'b10
		an[2] = 1'b0;
		2'b11
		an[3] = 1'b0;
	end
endmodule

module hex_to_sseg
	(
		input wire [3:0] hex,
		output reg [6:0] sseg
	);
	
	always @*
	begin
		case(hex)
			4'h0: sseg[6:0] = 7'b0000001;
			4'h1: sseg[6:0] = 7'b1001111;
			4'h2: sseg[6:0] = 7'b0010010;
			4'h3: sseg[6:0] = 7'b0000110;
			4'h4: sseg[6:0] = 7'b1001100;
			4'h5: sseg[6:0] = 7'b0100100;
			4'h6: sseg[6:0] = 7'b0100000;
			4'h7: sseg[6:0] = 7'b0001111;
			4'h8: sseg[6:0] = 7'b0000000;
			4'h9: sseg[6:0] = 7'b0000100;
			4'ha: sseg[6:0] = 7'b0001000;
			4'hb: sseg[6:0] = 7'b1100000;
			4'hc: sseg[6:0] = 7'b0110001;
			4'hd: sseg[6:0] = 7'b1000010;
			4'he: sseg[6:0] = 7'b0110000;
			default: sseg[6:0] = 7'b0111000;  //4'hf			
		endcase
	end
end module

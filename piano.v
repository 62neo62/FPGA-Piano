// This is the top level design for EE178 Lab #4.
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).
`timescale 1 ns / 1 ps
// Declare the module and its ports. This is
// using Verilog-2001 syntax.
module piano (
    input wire clk,
    input wire hush,
    input wire [3:0] note,
    output wire speaker
 );
    localparam N = 17;
	reg [N-1:0] counter;
	reg [N-1:0] period;
	reg speakerout;
	

	//initialize the reg just declared ^
	initial
	begin
	   counter = 5'h00000;
	   period = 5'h00000;
	   speakerout = 0;
	end
	
	always @(posedge clk)
	begin
	   case(note)
		4'b0000:
		period = 17'b11011101111100011;
        4'b0001:
        period = 17'b11010001011111001;
        4'b0010:
        period = 17'b11000101101110101;
        4'b0011:
        period = 17'b10111010101000011;
        4'b0100:
        period = 17'b10110000001010000;
        4'b0101:
        period = 17'b10100110010001010;
        4'b0110:
        period = 17'b10011100111100000;
        4'b0111:
        period = 17'b10010100001000010;
        4'b1000:
        period = 17'b10001011110100001;
        4'b1001:
        period = 17'b10000011111110000;
        4'b1010:
        period = 17'b01111100100011111;
        4'b1011:
        period = 17'b01110101100100100;
        4'b1100:
        period = 17'b01101110111110001;
        4'b1101:
        period = 17'b01101000101111100;
        4'b1110:
        period = 17'b01100010110111010;
        4'b1111:
        period = 17'b01011101010100001;
		default:
		period = 17'b00000000000000000;
	   endcase
    end



	always@(posedge clk)
    begin
    counter = counter + 1;
    if(counter == period)
    begin
       speakerout = ~speakerout;
       counter = 0;
    end
    if(hush == 1'b1)
        speakerout = 1'b0;
  
    end
	

    // use assign to connect the a reg variable to the output speaker
    assign speaker = speakerout;
endmodule

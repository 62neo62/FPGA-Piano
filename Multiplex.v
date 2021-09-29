module disp_mux
(
	input wire clk, 
	input [3:0] in0, in1, in2, in3,
	output reg [3:0] an,
	output reg [6:0] sseg,
);

	//constant dec
	//refresh
	localparam N = 18;
	//signal declaration
	//D-FlipFlop
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;

	always @(posedge clk)
	begin
		if(posedge clk)
			q_reg = 0;
		else
			q_reg =  q_next;
	end

	assign q_next = q_reg + 1;
	
	//2 MSB ofcounter to control 4-to-1 multiplexing
	//
	always@ * //this is just to display onto the seven segment using mux, recall that the anodes are active low
	begin
		case(q_reg[N-1:N-2])
			2'b00: begin
				an = 4'b1110 //same thing as selecting the first seven segment an[0] so if bits 17 and 16 are 00
				sseg = in0;
				end
			2'b01: begin
				an = 4'b1101 //same thing as selecting the second seven segment an[1] so if bits 17 and 16 are 01
				sseg = in1;
				end
			2'b10: begin
				an = 4'b1011 //same thing as selecting the third seven segment an[2] so if bits 17 and 16 are 10
				sseg = in2;
				end
			2'b11: begin
				an = 4'b0111 //same thing as selecting the second seven segment an[3] so if bits 17 and 16 are 11
				sseg = in3;
				end
		endcase
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

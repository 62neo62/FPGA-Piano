`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2021 04:06:57 PM
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module disp_mux
(
	input wire clk, reset,
	input [3:0] val0, val1, val2, val3,
	output wire an0, an1, an2, an3,
	output reg ca, cb, cc, cd, ce, cf, cg
);
	
	reg [3:0] hex_mux_out;
	reg [1:0] sel;
	
	//constant dec
	//refresh
	localparam N = 18;
	//signal declaration
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;

	always @(posedge clk, posedge reset)
	begin
		if(reset)
			q_reg = 0;
		else
			q_reg =  q_next;
	end

	assign q_next = q_reg + 1;
	
	// 2 to 4 Encoder
	assign an0 = (sel == 2'b00);
	assign an1 = (sel == 2'b01);
	assign an2 = (sel == 2'b10);
	assign an3 = (sel == 2'b11);
	
	//2 MSB ofcounter to control 4-to-1 multiplexing
	always@ * //this is just to display onto the seven segment using mux, recall that the anodes are active low
	if (sel == 2'b00) begin
	hex_mux_out = val0;
	end else if (sel == 2'b01) begin
	hex_mux_out = val1;
	end else if (sel == 2'b10) begin
	hex_mux_out = val2;
	end else if (sel == 2'b11) begin
	hex_mux_out = val3;
	end else begin
	hex_mux_out = 4'bzzzz; //to prevent latching ya dig
	end
 


// 4 to 7 Decoder
	always @*
	begin
		case(hex_mux_out)
			4'h0: {ca,cb,cc,cd,ce,cf,cg} = {7'b0000001};
			4'h1: {ca,cb,cc,cd,ce,cf,cg} = {7'b1001111};
			4'h2: {ca,cb,cc,cd,ce,cf,cg} = {7'b0010010};
			4'h3: {ca,cb,cc,cd,ce,cf,cg} = {7'b0000110};
			4'h4: {ca,cb,cc,cd,ce,cf,cg} = {7'b1001100};
			4'h5: {ca,cb,cc,cd,ce,cf,cg} = {7'b0100100};
			4'h6: {ca,cb,cc,cd,ce,cf,cg} = {7'b0100000};
			4'h7: {ca,cb,cc,cd,ce,cf,cg} = {7'b0001111};
			4'h8: {ca,cb,cc,cd,ce,cf,cg} = {7'b0000000};
			4'h9: {ca,cb,cc,cd,ce,cf,cg} = {7'b0000100};
			4'ha: {ca,cb,cc,cd,ce,cf,cg} = {7'b0001000};
			4'hb: {ca,cb,cc,cd,ce,cf,cg} = {7'b1100000};
			4'hc: {ca,cb,cc,cd,ce,cf,cg} = {7'b0110001};
			4'hd: {ca,cb,cc,cd,ce,cf,cg} = {7'b1000010};
			4'he: {ca,cb,cc,cd,ce,cf,cg} = {7'b0110000};
			default: {ca,cb,cc,cd,ce,cf,cg} = {7'b0111000}; //4'hf			
		endcase
	end
endmodule

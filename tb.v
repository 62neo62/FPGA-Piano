 // File: testbench.v
// This is a top level testbench for the piano design,
// which is part of the EE178 Lab #4 assignment.
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).
`timescale 1 ns / 1 ps
module testbench;
 // Generate a free running 100 MHz clock
 // signal to mimic what is on the board.
reg clk;
always
begin
clk = 1'b0;
#5;
clk = 1'b1;
#5;
end
 // In this block, include a mechanism
 // to exercise the design and finally
 // stop the simulation.
reg [3:0] note;
reg hush;
integer loopvar;
initial
begin
$display("If simulation ends before the testbench");
$display("completes, use the menu option to run all.");
note = 4'h0;
hush = 1'b1;
#100;
$display("Beginning note loop.");
 // Loop through all 16 possible notes
 // and also exercise the hush signal.
for (loopvar = 0; loopvar < 16; loopvar = loopvar + 1)
begin
hush = 1'b0; // make noise
note = loopvar[3:0]; // assign note
#10000000; // allow it to run
hush = 1'b1; // go quiet
#1000000; // allow it to run
end
 // End the simulation.
$display("Simulation is over, check the waveforms.");
$stop;
end
 // Now instantiate the top level design.
wire speaker;
piano my_piano (
.clk(clk),
.hush(hush),
.note(note),
.speaker(speaker)
);
endmodule

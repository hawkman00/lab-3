`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [1:0] CL;
   logic  reset;
   
   logic  [5:0] y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, CL, y);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b %b || %b", 
		     reset, CL, y);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#41  reset = 1'b0;	//time 41
	#0   CL = 2'b00;    //time 41
	#40  CL = 2'b01;    //time 61
     #40  CL = 2'b10;    //time 81
	#40  CL = 2'b11;    //time 101
     #50 $finish;
     end

endmodule // FSM_tb


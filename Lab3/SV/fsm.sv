module FSM (clk, reset, CL, y);

   input logic  clk;
   input logic  reset;
   input logic 	[1:0] CL;
   
   output logic[5:0] y;

  logic L, R;
  assign L = CL[1];
  assign R = CL[0];

   typedef enum 	logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
      
    

   // next state logic
   always_comb
     case (state)
       S0: begin
	      y <= 6'b000_000;	  
        if ((L)&(~R))
          nextstate <= S1;
        else if ((L)&(R))
          nextstate <= S4;
        else if ((~L)&(R))
        nextstate <= S7;
        else 
        nextstate <= S0;
       end
       
       S1: begin
        y <= 6'b001_000;
          nextstate <= S2;
       end
       S2: begin
        y <= 6'b011_000;
        nextstate <= S3;
       end
       S3: begin
        y <= 6'b111_000;
        nextstate <= S0;
       end
       S4: begin
        y <= 6'b001_100;
        nextstate <= S5;
       end
       S5: begin
        y <= 6'b011_110;
        nextstate <= S6;
       end
       S6: begin
        y <= 6'b111_111;
        nextstate <= S0;
        end
      S7: begin
        y <= 6'b000_001;
        nextstate <= S8;
      end 
      S8: begin
        y <= 6'b000_011;
        nextstate <= S9;
      end
      S9: begin
        y <= 6'b000_111;
        nextstate <= S0;
      end
       //default: begin
	  //y <= 6'b000_000;	  	  
	  //nextstate <= S0;
      // end
     endcase
   
endmodule

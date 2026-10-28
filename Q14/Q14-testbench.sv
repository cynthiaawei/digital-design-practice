// Question 14: RTL for a 3-input sorting logic.

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q14_tb;
  	  parameter int N = 3;
      logic [N:0] a;
      logic [N:0] b;
      logic [N:0] c;
      logic [N:0] max;
      logic [N:0] mid;
      logic [N:0] min;
	
  	// instantiate instance with name test
  Q14 #(
    			.N(N)
  ) test ( 
                .a(a),
                .b(b),
                .c(c),
                .max(max),
            	.mid(mid),
            	.min(min)
    );

  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
        
      	a = 3'b101;
      	b = 3'b011;
        c = 3'b100;
      #1
      $display("max = %b \n mid = %b \n min = %b", max, mid, min);
    end
endmodule
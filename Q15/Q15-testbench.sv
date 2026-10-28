// Question 15: RTL for three input Median circuit

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q15_tb;
  	  parameter int N = 3;
      logic [N:0] a;
      logic [N:0] b;
      logic [N:0] c;
      logic [N:0] mid;
	
  	// instantiate instance with name test
  Q15 #(
    			.N(N)
  ) test ( 
                .a(a),
                .b(b),
                .c(c),
            	.mid(mid)
    );

  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
        
      	a = 3'b101;
      	b = 3'b011;
        c = 3'b100;
      #1
      $display("mid = %b", mid);
    end
endmodule
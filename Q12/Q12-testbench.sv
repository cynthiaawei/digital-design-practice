// Question 12: Implement 4-to-1 MUX using 2-to-1 MUXs.

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q12_tb;
  	logic 				a;
    logic				b;
  	logic				c;    
  	logic 				d;
    logic				s1;
  	logic				s2; 
  	logic				f; 
  
  	// instantiate instance with name test
  Q12 test ( 
                .a(a),
                .b(b),
                .c(c),
                .d(d),
                .s1(s1),
                .s2(s2),
                .f(f)
    );
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
      	a = '1;
      	b = '0;
      	c = '0;
      	d = '1;
      	s1 = '0;
      	s2 = '0;
      #1
      $display("f = %b", f);
    end
endmodule
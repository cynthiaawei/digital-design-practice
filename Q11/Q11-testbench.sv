// Question 11: Implement NAND, XOR, and NOT gate using 2-to-1 MUX.

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q11_tb;
  	logic 				a;
    logic				b;
  	logic				NAND;    
  	logic 				XOR;
    logic				NOT_a;
  	logic				NOT_b; 
  
  	// instantiate instance with name test
  Q11 test ( 
                .a(a),
                .b(b),
    			.NAND(NAND),
    			.XOR(XOR),
      			.NOT_a(NOT_a),
     		    .NOT_b(NOT_b)
    );
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
      	a = '1;
      	b = '0;
      #1
      $display("NAND = %b \n XOR = %b \n NOT_a = %b \n NOT_b = %b", NAND, XOR, NOT_a, NOT_b);
    end
endmodule
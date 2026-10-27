// Question 10: RTL for binary to gray and gray to binary logic.

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q10_tb;
  	parameter int 			N = 5;
  	logic [N:0]				data;
    logic [N:0]				gray;
  	logic [N:0]				binary;    
	
  	// instantiate instance with name test
  Q10 #(
          		.N(N)
  ) test ( 
     		    .data(data),
      			.gray(gray),
     		    .binary(binary)
    );
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
      	data = 5'b10010;
      #1
      $display("Input = %b \n Gray = %b \n Binary = %b", data, gray, binary);
    end
endmodule
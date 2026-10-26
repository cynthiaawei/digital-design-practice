// Question 21: RTL for a) the index of the first set bit in 32-bit input. b) Number of 1’s in 32-bit input signal. 

module Q21_tb;
  	logic [31:0]			num_tb;
  	logic [5:0] 			count_tb;
  	logic [5:0]				index_tb;
	
  	// instantiate instance with name test
  	Q21 test ( 
      			.num(num_tb),
     		    .count(count_tb),
      			.index(index_tb)
    );
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;

     	num_tb =  32'h80000000;
      	 #10;
      	$display("num = %b", num_tb);
      	$display("count = %b", count_tb);
        $display("index = %b", index_tb);
    end
endmodule
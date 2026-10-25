// Question 2: RTL for a fixed priority arbiter with decreasing priority from MSB to LSB

module Q2_tb;
    parameter int N_tb = 3; // define the parameter
  	logic [N_tb-1:0] 	req_tb; // declare the input and output signals
  	logic [N_tb-1:0] 	gnt_tb;
	
  	// instantiate instance with name test
    Q2 #( 
      			.N(N_tb)
    ) test ( 
            	.req(req_tb),
            	.gnt(gnt_tb)
    );

    // test cases
  	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      
     	 req_tb = 3'b011;
    end
endmodule
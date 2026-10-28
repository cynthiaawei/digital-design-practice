
// Question 1: write a fixed priority arbiter with decreasing priority from LSB to MSB

module Q1_tb;
    parameter int N_tb = 3; // define the parameter
    logic [0:0] 	req_tb [N_tb]; // declare the input and output signals
    logic [0:0] 	gnt_tb [N_tb];
	
  	// instantiate instance with name test
    Q1 #( 
      			.N(N_tb)
    ) test ( 
            	.req(req_tb),
            	.gnt(gnt_tb)
    );

    // test cases
  	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      
        req_tb[0] = '0;
        req_tb[1] = '1;
        req_tb[2] = '1;
      
    end
endmodule
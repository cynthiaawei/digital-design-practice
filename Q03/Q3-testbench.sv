// Question 3: Implement a Round-Robin Arbiter with 3 I/p requests

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q3_tb;
    logic 				clk_tb;
    logic 				rst_n_tb;
    logic [2:0] 		req_tb; 
  	logic [2:0] 		gnt_tb;
	
  	// instantiate instance with name test
    Q3 test ( 
   			    .clk(clk_tb),
     		    .rst_n(rst_n_tb),
            	.req(req_tb),
            	.gnt(gnt_tb)
    );

    initial begin						// Generate a Clock
        clk_tb = 0;        		        // Initialize clock to low at time 0
        forever #5 clk_tb = ~clk_tb; 	// Toggle every 5ns (half-period)
    end
  
  	initial begin
      	#100;							// Wait 100 time units (100ns)
        $finish; 						// End the clock cycle
	end
  
  	initial begin
     	rst_n_tb = '1;
      	#50;
      	rst_n_tb = '0;
      	#10;
      	rst_n_tb = '1;
    end

  	initial begin
     	req_tb = 3'b111;
      	#20;
   	    req_tb = 3'b110;
      	#20;
        req_tb = 3'b010;
      	#10;
        req_tb = 3'b011;
      	#20;
        req_tb = 3'b101;
    end
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
    end
endmodule
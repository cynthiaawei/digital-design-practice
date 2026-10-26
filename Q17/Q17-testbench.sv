// Question 17: Design clock divider logic for divide by 2,3,4,5. 

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q17_tb;
  	parameter int 			N_tb = 3;
    logic 					ick_tb;
    logic 					rst_n_tb;
  	logic					ock_tb;
	
  	// instantiate instance with name test
  	Q17 #(
      			.N(N_tb)
  	) test ( 
      			.ick(ick_tb),
     		    .rst_n(rst_n_tb),
      			.ock(ock_tb)
    );

    initial begin						// Generate a Clock
        ick_tb = 0;        		        // Initialize clock to low at time 0
        forever #5 ick_tb = ~ick_tb; 	// Toggle every 5ns (half-period)
    end
  
  	initial begin
      	#200;							// Wait 100 time units (100ns)
        $finish; 						// End the clock cycle
	end
  
  	initial begin
     	rst_n_tb = '0;
      	#10
      	rst_n_tb = '1;
      	#50;
      	rst_n_tb = '0;
      	#10;
      	rst_n_tb = '1;
    end
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
    end
endmodule
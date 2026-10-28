// Question 7: RTL and Circuit for a Pulse Synchronization Circuit 

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q7_tb;
    logic 					data;
    logic 					pulse;
  	logic					clk_A;    
  	logic 					clk_B;
  	logic					rst_n_tb;
	
  	// instantiate instance with name test
  	Q7 test ( 
      			.data(data),
     		    .pulse(pulse),
      			.clk_A(clk_A),
     		    .clk_B(clk_B),
      			.rst_n(rst_n_tb)
    );

    initial begin						// Generate a Clock
        clk_A = 0;        		        // Initialize clock to low at time 0
        forever #5 clk_A = ~clk_A; 		// Toggle every 5ns (half-period)
    end
  
    initial begin						// Generate a Clock
      	clk_B = 0;        		        // Initialize clock to low at time 0
        forever #8 clk_B = ~clk_B; 		// Toggle every 5ns (half-period)
    end
  
  	initial begin
      	#200;							// Wait 100 time units (100ns)
        $finish; 						// End the clock cycle
	end
  
  	initial begin
     	rst_n_tb = '0;
      	#10
      	rst_n_tb = '1;
      	#80;
      	rst_n_tb = '0;
      	#10;
      	rst_n_tb = '1;
    end
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
      	data = '0;
      	#20
      	data = '1;
      	#10
      	data = '0;
    end
endmodule
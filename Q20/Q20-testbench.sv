// Question 20: 11011 sequence detector FSM.

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q20_tb;
    logic 				i;
    logic 				clk;
  	logic  				rst_n; 
  	logic 				detected;
	
  	// instantiate instance with name test
    Q20 test ( 
                .i(i),
                .clk(clk),
            	.rst_n(rst_n),
            	.detected(detected)
    );

    initial begin						// Generate a Clock
        clk = 0;        		        // Initialize clock to low at time 0
        forever #5 clk = ~clk; 	// Toggle every 5ns (half-period)
    end
  
  	initial begin
      	#100;							// Wait 100 time units (100ns)
        $finish; 						// End the clock cycle
	end
  
  	initial begin
     	rst_n = '0;
      	#10
      	rst_n = '1;
      	#50;
      	//rst_n = '0;
      	#10;
      	//rst_n = '1;
    end

  	initial begin
        i = '1;
        #20;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '1;
        #10;
        i = '0;
        #10;
        i = '1;
        #10;
    end
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
    end
endmodule
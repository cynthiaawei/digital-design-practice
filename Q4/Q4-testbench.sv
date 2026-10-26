// Question 4: RTL Design synchronous FIFO buffer for generic depth 

`timescale 1ns/1ps  // Defines <time unit>/<time precision>

module Q4_tb;
  	parameter int 			DEPTH_tb = 4;
  	parameter int			WIDTH_tb = 2;
    logic 					clk_tb;
    logic 					rst_n_tb;
    logic [WIDTH_tb-1:0] 	write_input_tb; 
    logic [WIDTH_tb-1:0] 	read_output_tb;
  	logic					wr_en_tb;
  	logic					rw_en_tb;
	
  	// instantiate instance with name test
  	Q4 #(
                .DEPTH(DEPTH_tb),
                .WIDTH(WIDTH_tb)
  	) test ( 
   			    .clk(clk_tb),
     		    .rst_n(rst_n_tb),
            	.write_input(write_input_tb),
                .read_output(read_output_tb),
                .wr_en(wr_en_tb),
                .rw_en(rw_en_tb)
    );

    initial begin						// Generate a Clock
        clk_tb = 0;        		        // Initialize clock to low at time 0
        forever #5 clk_tb = ~clk_tb; 	// Toggle every 5ns (half-period)
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
      	//rst_n_tb = '0;
      	#10;
      	//rst_n_tb = '1;
    end

  	initial begin
      	wr_en_tb = '1;
     	write_input_tb = 2'b11;
      	rw_en_tb = '1;
      	#20
      	//wr_en_tb = '0;
      	write_input_tb = 2'b10;
      	#20
      	rw_en_tb = '0;
        write_input_tb = 2'b10;
      	#10
      	//rw_en_tb = '0;
        write_input_tb = 2'b00;
     	#20
      	write_input_tb = 2'b01;
      	#10
      	write_input_tb = 2'b11;
      	#10
      	write_input_tb = 2'b01;
      	#10
      	wr_en_tb = '0;
      	rw_en_tb = '1;
    end
  
  	initial begin
      	$dumpfile("dump.vcd"); $dumpvars;
    end
endmodule